require_relative '../db_connect'

class ConnectRequest < ActiveRecord::Base
  validates :chat_id, presence: true
  validates :username, presence: true

  has_many :interests
end
