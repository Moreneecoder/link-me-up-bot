require 'active_record'

# ActiveRecord::Base.establish_connection(
#   {
#     adapter: 'postgresql',
#     template: 'template0',
#     encoding: 'unicode',
#     pool: 5,
#     database: 'link_me_bot'
#   }
# )

# ActiveRecord::Base.connection.create_database('link_me_bot', {
#     adapter: 'postgresql',
#     template: 'template0',
#     encoding: 'unicode',
#     pool: 5,
#     # database: 'link_me_bot'
#     })

db_config = {
  host: 'localhost',
  adapter: 'postgresql',
  template: 'template0',
  encoding: 'unicode',
  database: 'link_me_bot',
}

db_config_admin = db_config.merge({'database' => 'postgres', 'schema_search_path' => 'public'})

puts 'connection established' if ActiveRecord::Base.establish_connection(db_config_admin)
# ActiveRecord::Base.connection.create_database(db_config['database'])