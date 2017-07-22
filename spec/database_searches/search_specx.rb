require_relative "../../app/search.rb"
require_relative "../../app/db_helpers.rb"

class Db
  include DbHelpers
end

context 'search for recordings:' do
  before do
    @db = Db.new
  end

  describe 'pieces by a composer:' do

    it 'finds all pieces and recordings by J.S. Bach' do
      @db.clear_table :people
      @db.add_person 'Bach', 'J.S.', ''

      @db.clear_table :pieces
      @db.add_piece 'Bach Thing One'
      @db.add_piece 'Bach Thing Two'

      @db.clear_table :recordings
      @db.add_recording 'Bach Album A/Track 1.wav', '2009', ''
      @db.add_recording 'Bach Album A/Track 2.wav', '1992', ''
      @db.add_recording 'Bach Album B/Track 7.wav', '1999', ''
      @db.add_recording 'Bach Album B/Track 9.wav', '1999', ''

      @db.clear_table :roles
      @db.add_roles [ 'Composer', 'Not Composer' ]

      



    end

  end

end
