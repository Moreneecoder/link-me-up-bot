require "active_record"
require "yaml"
require 'pg'

# db_options = {
#   adapter: 'postgresql',
#   host: 'localhost',
#   database: 'link_me_bot',
#   encoding: 'unicode'
# }
# ActiveRecord::Base.establish_connection(db_options)

db_config = YAML::load(File.open('config/database.yml'))
p db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
environment = ENV['RACK_ENV'] || 'development'

ActiveRecord::Base.establish_connection(db_config[environment])
