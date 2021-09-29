#!/usr/bin/env ruby

require_relative '../db_connect'

class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    create_table :interests do |t|
      t.string :title
    end
  end
end
