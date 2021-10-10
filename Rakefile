require 'active_record'
require 'yaml'
require 'pg'

namespace :db do

  db_config = YAML.safe_load(File.open('config/database.yml'), aliases: true)
  db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})

  if ENV['RACK_ENV']
    environment = ENV['RACK_ENV']
    db_config['database'] = ENV['DATABASE_URL'] || 'postgres://localhost/mydb'
    connector = db_config[enviroment]
    p "It's production"
  else
    environment = 'development'
    connector = db_config
    p "It's development"
  end

  desc "Create the database"
  task :create do
    # conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost')
    # db_create = conn.exec_params("CREATE DATABASE #{db_name} ENCODING 'UTF8' TEMPLATE template0")
    ActiveRecord::Base.establish_connection(db_config_admin)
    db_create = ActiveRecord::Base.connection.create_database(db_config['database'], {
      template: 'template0',
      encoding: 'unicode',      
    })

    puts "Database #{db_config['database']} created." if db_create
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(connector)
    require_relative './persistence/migrations/migrator.rb'
    puts "Database migrated." if Migrator.new.migrate
  end

  desc "Drop the database"
  task :drop do 
    conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost')
    db_drop = conn.exec_params("DROP DATABASE IF EXISTS #{db_config['database']}")

    # db_drop = ActiveRecord::Base.connection.drop_database(db_name)
    puts "Database #{db_config['database']} deleted." if db_drop
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

end