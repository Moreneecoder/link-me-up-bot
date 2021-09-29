require_relative '../db_connect.rb'

class Interest < ActiveRecord::Base
  belongs_to :connect_request
end