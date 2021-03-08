require 'json'

class LinkMeUp
  attr_accessor :ready

  def initialize
    @ready = false
  end

  def ready?(message_text)
    @ready = true if message_text == '/connect'

    # if message is any other command
    @ready = false if message_text != '/connect' && message_text[0] == '/'
    @ready
  end

  def formatted_request(message_text)
    request = message_text.split(',')
    stripped_request = []
    request.each { |item| stripped_request.push(item.strip) }
    stripped_request
  end

  def find_match(message)
    formatted_request = self.formatted_request(message.text)

    json = File.read('./bin/connect_request.json')
    obj = JSON.parse(json)

    obj['table'].each do |table|
      # user = "t\\.me/#{table['username']}"
      interests = table['interests']

      matched_interests = interests.select { |interest| formatted_request.include? interest }

      return table if matched_interests.count >= 1
    end
    
    return false
  end

  def store_interest(messageObj)
    interests = self.formatted_request(messageObj.text)

    data = {
      id: 2345,
      chat_id: messageObj.chat.id,
      username: messageObj.from.username,
      interests: interests
    }

    json = File.read('./bin/connect_request.json')
    obj = JSON.parse(json)
    obj["table"].push(data);

    formatted_data = JSON.pretty_generate(obj);

    File.open("./bin/connect_request.json","w") do |f|
      f.write(formatted_data)
    end

  end
end
