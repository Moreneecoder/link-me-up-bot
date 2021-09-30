require 'active_record'

db_options = { adapter: 'postgresql', host: 'localhost', database: 'app_db' }
ActiveRecord::Base.establish_connection(db_options)
