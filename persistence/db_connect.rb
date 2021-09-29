require 'active_record'

db_options = { adapter: 'sqlite3', database: 'app_db' }
ActiveRecord::Base.establish_connection(db_options)
