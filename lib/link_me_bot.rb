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

  # def find_match(message_obj)
  #   formatted_request = self.formatted_request(message_obj.text)

  #   json = File.read('./bin/connect_request.json')
  #   obj = JSON.parse(json)

  #   obj['table'].each do |table|
  #     interests = table['interests']

  #     matched_interests = interests.select { |interest| formatted_request.include? interest }

  #     matched_data = { obj: table, matched_interests: matched_interests }

  #     self.ready = false

  #     return matched_data if matched_interests.count >= 1
  #   end

  #   false
  # end

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

    data = {
      id: SecureRandom.uuid,
      chat_id: message_obj.chat.id,
      username: message_obj.from.username,
      interests: interests
    }

    json = File.read('./bin/connect_request.json')
    obj = JSON.parse(json)
    obj['table'].push(data)

    formatted_data = JSON.pretty_generate(obj)

    File.open('./bin/connect_request.json', 'w') do |f|
      f.write(formatted_data)
    end

    self.ready = false
  end
end
