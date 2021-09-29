#!/usr/bin/env ruby
# require_relative '../lib/bot_client'

# bot_client = BotClient.new
# bot_client.start

require 'active_record'

# ActiveRecord::Base.establish_connection(
#     adapter: 'postgresql',
#     host: 'localhost',
#     username: 'admin',
#     password: 'p@ssw0rd',
#     database: 'my_db'
# )

db_options = { adapter: 'sqlite3', database: 'app_db' }
# ActiveRecord::Base.connection.create_database(db_options)

# ActiveRecord::Base.establish_connection(
#     adapter: 'postgresql',
#     host: 'localhost',
#     database: 'app_db'
# )

# class User < ActiveRecord::Base
#   self.table_name = 'user'
#   self.primary_key = 'user_id'
# end

# User.columns.each { |column|
#     puts column.name
#     puts column.type
# }

ActiveRecord::Base.establish_connection(db_options)

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :description
    end
  end
end

#   CreateUsers.new.change

# Can override table name and primary key
class User < ActiveRecord::Base
  #   self.table_name = 'user'
  #   self.primary_key = 'user_id'
end

User.connection

User.columns.each do |column|
  puts column.name
  puts column.type
end
