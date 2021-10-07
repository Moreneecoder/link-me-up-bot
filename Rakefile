require "active_record"
require "yaml"
require 'pg'

namespace :db do
  db_name = 'link_me_bot'

  db_config = YAML::load(File.open('config/database.yml'))
  p db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})
  environment = ENV['RACK_ENV'] || 'development'

  # conn = ActiveRecord::Base.establish_connection({
  #   adapter: 'postgresql',
  #   uri: 'postgres://pdoevfkghzlshv:dac59925bb7346e3621b2b90db067520a3b6a2201e4287d9a21da896325da1a4@ec2-18-214-214-252.compute-1.amazonaws.com:5432/d18ioam4eqmpm9',
  #   user: 'pdoevfkghzlshv',
  #   host: 'ec2-18-214-214-252.compute-1.amazonaws.com',
  #   password: 'dac59925bb7346e3621b2b90db067520a3b6a2201e4287d9a21da896325da1a4',
  #   port: '5432',
  #   database: 'd18ioam4eqmpm9',
  #   template: 'template0',
  #   schema_search_path: 'public'
  # })

  # ENV['RACK_ENV']
  # conn = ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  # conn = ActiveRecord::Base.establish_connection({
  #   adapter: 'postgresql',
  #   host: 'localhost',    
  #   database: 'postgres'
  # })

  desc "Create the database"
  task :create do
    # conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost')
    # db_create = conn.exec_params("CREATE DATABASE #{db_name} ENCODING 'UTF8' TEMPLATE template0")

    # db_create = ActiveRecord::Base.connection.create_database(db_name, {
    #   template: 'template0',
    #   encoding: 'unicode',      
    # })

    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.create_database(db_config["database"])

    puts "Database #{db_name} created." if db_create
  end

  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Base.establish_connection(db_config_admin[environment])
    require_relative './persistence/migrations/migrator.rb'
    puts "Database migrated." if Migrator.new.migrate
  end

  desc "Drop the database"
  task :drop do 
    conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost')
    db_drop = conn.exec_params("DROP DATABASE IF EXISTS #{db_name}")

    # db_drop = ActiveRecord::Base.connection.drop_database(db_name)
    puts "Database #{db_name} deleted." if db_drop
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

end