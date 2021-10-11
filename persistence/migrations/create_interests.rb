class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    return if exists?

    create_table :interests do |t|
      t.string :title
    end
  end

  def exists?
    ActiveRecord::Base.connection.data_source_exists? 'interests'
  end
end
