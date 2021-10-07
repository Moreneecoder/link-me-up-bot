require "active_record"
require "yaml"
require 'pg'

namespace :db do
  db_name = 'link_me_bot'

  conn = ActiveRecord::Base.establish_connection({
    adapter: 'postgresql',
    # host: 'localhost',
    user: 'pdoevfkghzlshv'
    host: 'ec2-18-214-214-252.compute-1.amazonaws.com',
    password: 'dac59925bb7346e3621b2b90db067520a3b6a2201e4287d9a21da896325da1a4',
    port: '5432',
    # host: '0.0.0.0',
    # database: 'postgres',
    database: 'd18ioam4eqmpm9',
    template: 'template0',
    schema_search_path: 'public'
  })

  desc "Create the database"
  task :create do
    # conn = PG::Connection.open(:dbname => 'postgres', :host => 'localhost')
    # db_create = conn.exec_params("CREATE DATABASE #{db_name} ENCODING 'UTF8' TEMPLATE template0")

    db_create = ActiveRecord::Base.connection.create_database(db_name, {
      template: 'template0',
      encoding: 'unicode'
    })

    puts "Database #{db_name} created." if db_create
  end

  desc "Migrate the database"
  task :migrate do
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