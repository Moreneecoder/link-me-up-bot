require 'json'
require 'securerandom'
require_relative '../persistence/models/interest'
require_relative '../persistence/models/connect_request'

class LinkMeUp
  attr_accessor :ready

  def initialize
    @ready = false
  end

  def run_bot; end

  def ready?(message_text)
    @ready = true if message_text == '/connect'

    @ready = false if message_text != '/connect' && message_text[0] == '/'
    @ready
  end

  def valid_command?(message)
    ['/connect', '/start', '/help', '/stop'].include? message.text
  end

  def formatted_request(message_text)
    request = message_text.split(',')
    stripped_request = []
    request.each { |item| stripped_request.push(item.downcase.strip) }
    stripped_request
  end

  def find_match(message_obj)
    formatted_request = self.formatted_request(message_obj.text)

    matched_request = Interest.where(title: formatted_request)
      .group('connect_request_id')
      .order('count(connect_request_id) DESC')
      .limit(2)
      .includes(:connect_request)

    return matched_request unless matched_request.empty?

    false
  end

  def store_interest(message_obj)
    interests = formatted_request(message_obj.text)

    request = ConnectRequest.new(chat_id: message_obj.chat.id, username: message_obj.from.username)
    interests.each { |interest| request.interests.create(title: interest) } if request.save

    self.ready = false
  end
end
