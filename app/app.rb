require 'sinatra'
require 'json'
require 'yaml'
require_relative "./search"

$config = YAML.load_file("./config/config.yml")

get '/recordings/by/composer/:surname/:given_name' do
  content_type :json
  @search ||= Search.new
  result = @search.find_recordings_by_composer({
    :surname => CGI.unescape(params[:surname]),
    :given_name => CGI.unescape(params[:given_name])})

  puts "result: #{result}"

  {
    :request_url => "#{request.url}",
    :result => result
  }.to_json
end
