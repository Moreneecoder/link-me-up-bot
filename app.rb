require 'sinatra'
get '/' do
  redirect 'http://t.me/link_me_up_bot', 303
end
