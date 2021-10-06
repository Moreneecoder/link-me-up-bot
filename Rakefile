require "active_record"
require "yaml"
require 'pg'

namespace :db do
  db_name = 'link_me_bot'

  # conn = ActiveRecord::Base.establish_connection({
  #   adapter: 'postgresql',
  #   host: 'localhost',
  #   database: 'postgres'  
  # })

  desc "Create the database"
  task :create do
    conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost', :port => 5432)
    db_create = conn.exec_params("CREATE DATABASE #{db_name} ENCODING 'UTF8' TEMPLATE template0")

    # db_create = ActiveRecord::Base.connection.create_database(db_name, {
    #   template: 'template0',
    #   encoding: 'unicode'
    # })

    puts "Database #{db_name} created." if db_create
  end

  desc "Migrate the database"
  task :migrate do
    require_relative './persistence/migrations/migrator.rb'
    puts "Database migrated." if Migrator.new.migrate
  end

  desc "Drop the database"
  task :drop do 
    conn = PG::Connection.open(:dbname => 'postgres')
    db_drop = conn.exec_params("DROP DATABASE IF EXISTS #{db_name}")

    # db_drop = ActiveRecord::Base.connection.drop_database(db_name)
    puts "Database #{db_name} deleted." if db_drop
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

end