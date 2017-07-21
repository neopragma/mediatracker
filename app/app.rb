require 'sinatra'
require 'json'

get '/' do
  'Welcome to Sinatra'
end

get '/json' do
  content_type :json
  { :message => 'Welcome to Sinatra' }.to_json
end
