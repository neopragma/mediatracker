require 'sinatra'
require 'json'
require 'yaml'
require_relative "./search"

$config = YAML.load_file("config/config.yml")

get '/recordings/by/composer/:surname/:given_name' do
  return_as_json(
    search.find_recordings_by_composer({
      :surname => CGI.unescape(params[:surname]),
      :given_name => CGI.unescape(params[:given_name])})
  )
end

def search
  puts "self test: #{self.class.methods}"
  @search ||= Search.new
end

def return_as_json result
  content_type :json
  {
    :request_url => "#{request.url}",
    :result => result
  }.to_json
end
