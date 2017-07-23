require 'rest-client'
require 'rspec/expectations'
require 'json'
require 'yaml'

ENV['RACK_ENV'] ||= 'development'
config = YAML.load_file("#{ENV['PROJECT_ROOT']}/config/config.yml")
$BASE_URL = config['development']['base_url']
