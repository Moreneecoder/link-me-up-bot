require_relative '../db_connect'

class Interest < ActiveRecord::Base
  validates :title, presence: true
  validates :connect_request_id, presence: true

  belongs_to :connect_request

  def match(limit = 1); end
end
