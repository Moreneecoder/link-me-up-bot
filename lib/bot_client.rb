require 'dotenv'
Dotenv.load('./.env')
require 'telegram/bot'
require_relative '../lib/bot_message'
require_relative '../lib/link_me_bot'

class BotClient
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

  private

  def listen(bot)
    bot.listen do |message|
      bot_message = BotMessage.new(message)
      respond_to_command(bot, message, bot_message)

      connection_ready = @connect_request.ready?(message.text) && message.text != '/connect'

      if connection_ready
        if interests_not_above_5?(bot, message, bot_message)
          puts "Interest not above five"
        end
      else
        unless @connect_request.valid_command?(message)
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.help_message)
          end
      end
      
    end
  end

  private

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

end
