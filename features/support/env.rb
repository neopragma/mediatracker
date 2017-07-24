require 'rest-client'
require 'rspec/expectations'
require 'json'
require 'yaml'

ENV['RACK_ENV'] ||= 'development'

config = YAML.load_file('config/config.yml')
$BASE_URL = config[ENV['RACK_ENV']]['base_url']
