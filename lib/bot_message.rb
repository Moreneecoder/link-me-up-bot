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

end