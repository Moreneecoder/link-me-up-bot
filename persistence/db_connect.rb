require 'active_record'
require 'yaml'

db_config = YAML.safe_load(File.open('config/database.yml'), aliases: true)
connector = db_config

if ENV['RACK_ENV']
  environment = ENV['RACK_ENV']
  db_config['database'] = ENV['DATABASE_URL'] || 'postgres://localhost/mydb'
  connector = db_config[environment]
  p "It's production"
end

ActiveRecord::Base.establish_connection(connector)
