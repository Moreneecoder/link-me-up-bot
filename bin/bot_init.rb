#!/usr/bin/env ruby
require 'dotenv'
Dotenv.load('./.env')
require 'telegram/bot'
require './lib/bot_message'

token = ENV['BOT_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot_message = BotMessage.new(message)
    
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.start_message )
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: bot_message.stop_message )
    when '/help'
        bot.api.send_message(chat_id: message.chat.id, text: bot_message.help_message )
    end
  end
end