require_relative "../../app/search.rb"
require_relative "../../app/db_helpers.rb"

class Db
  include DbHelpers
end

context 'search for recordings:' do
  before do
    @db = Db.new
    @search = Search.new
  end

  describe 'find recordings of pieces by a composer:' do

    it 'finds all recordings of music by by J.S. Bach' do
      set_up_bach_recordings
      expect(@search.find_recordings_by_composer({
        :surname => 'Bach',
        :given_name => 'Johann Sebastian'
      })).to include_recordings([
        { :filename => 'PJBE - Brass Splendour/Track 2' },
        { :filename => 'PJBE - Brass Splendour/Track 3' }
      ])
    end

    it 'raises runtime error when the role "Composer" is not in the roles table' do
      set_up_bach_recordings
      @db.db.transaction do
        @db.db[:roles].where(:role_name => 'Composer').delete
      end

      expect{ @search.find_recordings_by_composer({
        :surname => 'Bach',
        :given_name => 'Johann Sebastian'
      })}.to raise_error 'The role "Composer" is not in the roles table. '\
                         'Most likely the database has not been loaded correctly.'
    end

    it 'raises runtime error when the name of the composer is not in the people table' do
      set_up_bach_recordings
      @db.db.transaction do
        @db.db[:people].where(:surname => 'Bach', :given_name => 'Johann Sebastian').delete
      end

      expect{ @search.find_recordings_by_composer({
        :surname => 'Bach',
        :given_name => 'Johann Sebastian'
      })}.to raise_error 'The name "Bach, Johann Sebastian" is not in the people table. '\
                         'Most likely the database has not been loaded correctly.'
    end

  end

private

  def set_up_bach_recordings
    @db.db.transaction do
      @db.clear_table :people
      @db.add_person 'Bach', 'Johann Sebastian', ''
      @db.add_person 'Handel', 'Georg Fridrick', ''

      @db.clear_table :roles
      @db.add_roles [ 'Arranger', 'Composer' ]

      @db.clear_table :pieces
      @db.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      @db.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'
      @db.add_piece 'Music for the Royal Fireworks', ''

      @db.clear_table :recordings
      @db.add_recording 'PJBE - Brass Splendour/Track 1.wav', 537, '1984-01-01', ''
      @db.add_recording 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', ''
      @db.add_recording 'PJBE - Brass Splendour/Track 3.wav', 163, '1984-01-01', ''

      @db.associate_piece_and_recording(
        { :title => 'Music for the Royal Fireworks',
          :subtitle => '',
          :filename => 'PJBE - Brass Splendour/Track 1.wav'
        })
      @db.associate_piece_and_recording(
        { :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })
      @db.associate_piece_and_recording(
        { :title => 'Christmas Oratorio',
          :subtitle => 'Ach, mein hertzliches Jesulein',
          :filename => 'PJBE - Brass Splendour/Track 3.wav'
        })

      @db.associate_person_role_and_recording(
        { :surname => 'Handel',
          :given_name => 'Georg Fridrick',
          :role_name => 'Composer',
          :filename => 'PJBE - Brass Splendour/Track 1.wav'
        })
      @db.associate_person_role_and_recording(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })
      @db.associate_person_role_and_recording(
        { :surname => 'Bach',
          :given_name => 'Johann Sebastian',
          :role_name => 'Composer',
          :filename => 'PJBE - Brass Splendour/Track 3.wav'
        })
    end
  end
end
