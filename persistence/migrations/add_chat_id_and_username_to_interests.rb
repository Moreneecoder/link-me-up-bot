class AddChatIdAndUsernameToInterests < ActiveRecord::Migration[6.1]
  def change
    add_column :interests, :chat_id, :integer
    add_column :interests, :username, :string

    # remove_column :interests, :request_id
  end
end
