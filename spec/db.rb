require_relative "../app/db_helpers"

class Db
  include DbHelpers

  def initialize
    connect
  end
end
