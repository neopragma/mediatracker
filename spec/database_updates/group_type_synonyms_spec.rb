require_relative "../../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'group_type_synonyms table:' do

    


  end

end
