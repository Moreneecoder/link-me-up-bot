#!/usr/bin/env ruby
require 'dotenv'
Dotenv.load('./.env')
require 'telegram/bot'

token = ENV['BOT_API_KEY']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: "Hi, *#{message.from.first_name}*, What will you like me to help you with?")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/help'
        bot.api.send_message(chat_id: message.chat.id, text: "Which useless help you dey find")
    end
  end
end