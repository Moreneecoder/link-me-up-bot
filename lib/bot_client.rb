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

  

end
