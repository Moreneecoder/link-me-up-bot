#!/usr/bin/env ruby

require 'active_record'

db_options = { adapter: 'sqlite3', database: 'app_db' }
ActiveRecord::Base.establish_connection(db_options)

class CreateConnectRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :connect_requests do |t|
      t.integer :chat_id
      t.string :username
    end
  end
end
