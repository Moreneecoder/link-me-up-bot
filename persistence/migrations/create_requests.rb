#!/usr/bin/env ruby

require_relative '../db_connect.rb'

class CreateConnectRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :connect_requests do |t|
      t.integer :chat_id
      t.string :username
    end
  end
end
