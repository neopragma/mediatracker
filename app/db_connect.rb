require 'sequel'
require 'logger'

module DbConnect

  # connect to DATABASE_URL using default logger
  def connect
    @db = Sequel.connect(
      ENV['DATABASE_URL'],
      :loggers => [Logger.new(ENV['SEQUEL_LOG'])])
  end

  def db
    @db = connect unless @db
    @db
  end

end
