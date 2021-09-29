require_relative '../db_connect'

class AddRequestIdToInterests < ActiveRecord::Migration[6.1]
  def change
    add_reference :interests, :connect_request, foreign_key: true
    # remove_column :interests, :request_id
  end
end
