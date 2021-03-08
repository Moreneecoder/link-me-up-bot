#!/usr/bin/env ruby
require 'dotenv'
Dotenv.load('./.env')
require 'telegram/bot'
require './lib/bot_message'
require './lib/link_me_bot'

token = ENV['BOT_API_KEY']
connect_request = LinkMeUp.new

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    bot_message = BotMessage.new(message)

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

    if connect_request.ready?(message.text)
      p match_found = connect_request.find_match(message) unless message.text == '/connect'

      if match_found
        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: match_found)
      elsif !match_found && message.text != '/connect'
        # store interest
        response = 'Hey there\\! There is currently no match for your interest\\.
        But trust us we will alert you when we find a match\\.'
        
        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: response)
      end
    end
  end
end
