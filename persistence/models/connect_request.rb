require_relative '../db_connect'

class ConnectRequest < ActiveRecord::Base
  has_many :interests
end
