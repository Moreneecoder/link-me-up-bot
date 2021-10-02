# rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

require 'dotenv'
Dotenv.load('./.env')
require 'telegram/bot'
require_relative '../lib/bot_message'
require_relative '../lib/link_me_bot'

class BotClient
  attr_reader :token

  def initialize
    @token = ENV['BOT_API_KEY']
    @connect_request = LinkMeUp.new
  end

  def start
    Telegram::Bot::Client.run(@token) do |bot|
      puts 'Bot is running...'

      listen(bot)
    end
  end

  def listen(bot)
    bot.listen do |message|
      bot_message = BotMessage.new(message)
      respond_to_command(bot, message, bot_message)

      connection_ready = @connect_request.ready?(message.text) && message.text != '/connect'

      if connection_ready
        if interests_not_above_5?(bot, message, bot_message)
          match_found = @connect_request.find_match(message)

          if match_found
            exchange_contact(bot, message, match_found, bot_message)
          elsif !match_found && message.text != '/connect'

            @connect_request.store_interest(message)
            match_not_found_msg = bot_message.match_not_found_message
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: match_not_found_msg)
          end
        end
      else
        unless @connect_request.valid_command?(message)
          bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.help_message)
        end
      end
    end
  end

  def respond_to_command(bot, message, bot_message)
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.start_message)
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.stop_message)
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.help_message)
    when '/connect'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.connect_message)
    end
  end

  def interests_not_above_5?(bot, message, bot_message)
    user_interests = @connect_request.formatted_request(message.text)

    if user_interests.count > 5
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.exceeded_message)
      return false
    end
    true
  end

  def exchange_contact(bot, message, match_found, bot_message)
    # matched_message = bot_message.match_found_message(match_found.pluck(:title).uniq)
    # bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: matched_message)

    match_found.each do |match|
      current_username = "t.me/#{message.from.username}"
      matched_username = "t.me/#{match.connect_request.username}"

      matched_interest = fetch_interests_per_connec(match, message)

      matched_message = bot_message.match_found_message(matched_interest)
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: matched_message)


      bot.api.send_message(chat_id: message.chat.id, text: matched_username)

      bot.api.send_message(chat_id: match.connect_request.chat_id, parse_mode: 'MarkdownV2', text: matched_message)
      bot.api.send_message(chat_id: match.connect_request.chat_id, text: current_username)
    end
  end

  def fetch_interests_per_connec(match_, message_)
    match_req_interests = match_.connect_request.interests.pluck(:title)
    interests = @connect_request.formatted_request(message_.text)
    response = match_req_interests & interests
  end

  private :listen
  private :respond_to_command
  private :interests_not_above_5?
  private :exchange_contact
  private :fetch_interests_per_connec
end

# rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
