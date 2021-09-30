require_relative '../db_connect'

class CreateConnectRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :connect_requests do |t|
      t.integer :chat_id
      t.string :username
    end
  end
end
