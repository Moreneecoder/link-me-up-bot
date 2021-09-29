require_relative '../db_connect.rb'

class ConnectRequest < ActiveRecord::Base
  has_many :interests
end