require 'json'

class LinkMeUp
  attr_accessor :ready

  def initialize
    @ready = false
  end

  def ready?(message_text)
    @ready = true if message_text == '/connect'

    # if message is not a command
    @ready = false if message_text != '/connect' && message_text[0] == '/'
    @ready
  end

  def find_match(message)
    request = message.text.split(',')
    stripped_request = []
    request.each { |item| stripped_request.push(item.strip) }

    json = File.read('./bin/connect_request.json')
    obj = JSON.parse(json)

    obj['table'].each do |table|
      user = table['id']
      interests = table['interests']

      matched_interests = interests.select { |interest| stripped_request.include? interest }

      return user if matched_interests.count == 2
    end
    'Hey there\\! There is currently no match for your interest\\.
    But trust us we will alert you when we find a match\\.'
  end
end
