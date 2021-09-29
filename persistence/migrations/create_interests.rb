#!/usr/bin/env ruby

require 'active_record'

db_options = { adapter: 'sqlite3', database: 'app_db' }
ActiveRecord::Base.establish_connection(db_options)

class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.string :title
    end
  end
end

CreateInterests.new.change