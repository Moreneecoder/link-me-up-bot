require 'active_record'

ActiveRecord::Base.establish_connection(
    {
    adapter: 'postgresql',
    template: 'template0',
    encoding: 'unicode',
    pool: 5,
    database: 'link_me_bot'
    }
)

# ActiveRecord::Base.connection.create_database('link_me_bot', {
#     adapter: 'postgresql',
#     template: 'template0',
#     encoding: 'unicode',
#     pool: 5,
#     # database: 'link_me_bot'
#     })