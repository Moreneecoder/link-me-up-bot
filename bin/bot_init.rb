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

        current_username = "t\\.me/#{message.from.username}"
        matched_username = "t\\.me/#{match_found[:obj]['username']}"

        matched_message = bot_message.match_found_message(match_found[:matched_interests])

        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: matched_message)
        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: matched_username)

        bot.api.send_message(chat_id: match_found[:obj]['chat_id'], parse_mode: 'MarkdownV2', text: matched_message)
        bot.api.send_message(chat_id: match_found[:obj]['chat_id'], parse_mode: 'MarkdownV2', text: current_username)
      elsif !match_found && message.text != '/connect'

        connect_request.store_interest(message)
        match_not_found_msg = bot_message.match_not_found_message
        bot.api.send_message(chat_id: message.chat.id, parse_mode: 'MarkdownV2', text: match_not_found_msg)
      end
    end
  end
end
