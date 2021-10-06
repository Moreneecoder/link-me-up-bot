require "active_record"
require "yaml"
require 'pg'

namespace :db do

  desc "Create the database"
  task :create do
    db_name = 'link_me_bot'
    conn = PG::Connection.open(:dbname => 'postgres')
    res = conn.exec_params("CREATE DATABASE #{db_name} ENCODING 'UTF8' TEMPLATE template0")

    puts "Database #{db_name} created." if res
  end

  desc "Migrate the database"
  task :migrate do
    require_relative './persistence/migrations/migrator.rb'
    puts "Database migrated." if Migrator.new.migrate
  end

  desc "Drop the database"
  task :drop do
    ActiveRecord::Base.establish_connection(db_config_admin)
    ActiveRecord::Base.connection.drop_database(db_config["database"])
    puts "Database deleted."
  end

  desc "Reset the database"
  task :reset => [:drop, :create, :migrate]

end