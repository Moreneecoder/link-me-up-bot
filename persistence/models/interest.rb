require_relative '../db_connect'

class Interest < ActiveRecord::Base
  validates :title, presence: true
  validates :chat_id, presence: true
  validates :username, presence: true

  def match(limit = 1); end
end
