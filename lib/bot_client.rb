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
      processMessage(bot, message, @connect_request) if message.respond_to?(:text) && !message.text.nil?
    end
  end

  def processMessage(bot, message, connect_request)
    if message.from.username.nil?
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: 'You do not have a Username, hence you cannot use this service\\.')
      return
    end

    bot_message = BotMessage.new(message)
    respond_to_command(bot, message, bot_message)

    connection_ready = connect_request.ready?(message.text) && message.text != '/connect'

    if connection_ready
      if interests_not_above_5?(bot, message, bot_message)
        match_found = connect_request.find_match(message)

        if match_found
          exchange_contact(bot, message, match_found, bot_message)
        elsif !match_found && message.text != '/connect'
          match_not_found_msg = bot_message.match_not_found_message
          bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: match_not_found_msg)
        end

        connect_request.store_interest(message)

      end
    else
      unless connect_request.valid_command?(message)
        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.help_message)
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
    current_username = "t.me/#{message.from.username}"

    contacts = match_found.group('interests.chat_id').order('count(chat_id) DESC').pluck(:chat_id).uniq

    contacts.take(2).each do |contact|
      match_set = match_found.where(chat_id: contact)

      contact_username = "t.me/#{match_set.last.username}"
      matched_interests = match_set.pluck(:title)

      matched_message = bot_message.match_found_message(matched_interests)

      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: matched_message)
      bot.api.send_message(chat_id: message.chat.id, text: contact_username)

      bot.api.send_message(chat_id: contact, parse_mode: 'MarkdownV2', text: matched_message)
      bot.api.send_message(chat_id: contact, text: current_username)
    end
  end

  private :listen
  private :respond_to_command
  private :interests_not_above_5?
  private :exchange_contact
end

# rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
