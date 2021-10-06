require_relative '../models/interest.rb'

class AddChatIdAndUsernameToInterests < ActiveRecord::Migration[6.1]
  def change
    add_column :interests, :chat_id, :integer unless self.exists?('chat_id')
    add_column :interests, :username, :string unless self.exists?('username')
  end

  def exists?(attr_name)
    Interest.column_names.include? attr_name
  end 
end
