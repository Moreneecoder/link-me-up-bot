require 'active_record'
require 'pg'

db_options = {
  adapter: 'postgresql',
  host: 'localhost',
  database: 'link_me_bot',
  encoding: 'unicode'
}
ActiveRecord::Base.establish_connection(db_options)
