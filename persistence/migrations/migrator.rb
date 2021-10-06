require_relative '../db_connect'

require_relative './create_interests'
require_relative './add_chat_id_and_username_to_interests'

class Migrator
  def migrate
    CreateInterests.new.change
    AddChatIdAndUsernameToInterests.new.change
  end
end
