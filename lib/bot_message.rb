class BotMessage
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def start_message
    "Hello *#{message.from.first_name}*\\. What will you like me to help you with?\n
    If you don't already know the commands to engage with me, type /help and hit enter
    to see a list of tasks I can help you with\\."
  end

  def stop_message
    "Bye *#{message.from.first_name}*\\. Feel free to check back on me again\\! I'm always here my friend\\."
  end

  def help_message
    "I see you need some help\\! Here is a list of commands to interact with me:

    \\* /start \\- Initiate the bot
    \\* /stop \\- End conversation with bot
    \\* /help \\- Get list of tasks
    \\* /connect \\- Tell bot to connect you with people who share your interest"
  end

  def connect_message
    "Great\\! To connect you with people who share similar interests, type a list
     of your current interests and separate them with commas\\.
    E\\.g: _mentorship_, _football_, _politics_, _beyonce_, _tech_\\. You cannot enter more than 5\\."
  end

  def match_found_message(interests)
    message = 'Pssst\\! found you a match for the following interests: '
    interests.each { |interest| message.concat(" _#{interest}_,") }
    message
  end

  def match_not_found_message
    'Hey there\\! There is currently no match for your interest\\.
    But trust me, I will alert you when we find a match\\.'
  end

  def exceeded_message
    'Sorry, I don\'t process more than 5 interests at a time\\. 
    Kindly enter /connect again and stick to 5 interests or less this time\\.'
  end
end
