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

    matched_interest = Interest.where(title: formatted_request)
    .where.not(chat_id: message_obj.chat.id)

    matched_request = Interest.where(title: formatted_request)

    return matched_interest unless matched_interest.empty?

    false
  end

  def store_interest(message_obj)
    interests_request = formatted_request(message_obj.text)
    interests = self.removeExistingInterests(message_obj, interests_request)

    unless interests.empty?
      request = ConnectRequest.new(chat_id: message_obj.chat.id, username: message_obj.from.username)
      interests.each { |interest| request.interests.create(title: interest) } if request.save
    end    

    self.ready = false
  end

  def removeExistingInterests(message_, interests_)
    # NEXT: CHECK IF USER ALREADY HAS INTEREST IN DATABASE BEFORE DELETING
    chat_connecs = ConnectRequest.includes(:interests).where(chat_id: message_.chat.id)
    previous = chat_connecs.map {|connec| connec.interests.where(title: interests_).pluck(:title)}.compact

    interests_ - previous.flatten
  end
end
