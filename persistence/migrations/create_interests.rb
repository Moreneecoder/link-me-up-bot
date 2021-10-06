class CreateInterests < ActiveRecord::Migration[6.1]
  def change
    unless self.exists?
      create_table :interests do |t|
        t.string :title
      end
    end
  end

  def exists?
    ActiveRecord::Base.connection.data_source_exists? 'interests'
  end 
end
