class LinkMeUp
  attr_accessor :ready

  def initialize
    @ready = false
  end

  def ready?(message_text)
    @ready = true if message_text == '/connect'
    @ready = false if message_text != '/connect' && message_text[0] == '/'
    @ready
  end
end
