require 'sequel'
require 'logger'
require 'yaml'

module DbConnect

  # connect to DATABASE_URL using default logger
  def connect
    $config = YAML.load_file("./config/config.yml")
    @db ||= Sequel.connect(
      $config[ENV['RACK_ENV']]['database_url'],
      :loggers => [Logger.new(ENV['SEQUEL_LOG'])])
  end

end
