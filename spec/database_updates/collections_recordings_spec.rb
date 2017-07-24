require_relative "../db"
require_relative "../matchers/matchers_spec"

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'collections_recordings table:' do

    before do
      $dbtest.clear_table :collections
      $dbtest.add_collection 'PJBE - Brass Splendour', '1984', 'great brass playing'

      $dbtest.clear_table :recordings
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 5.wav', 163, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 6.wav', 243, '1984-01-01', ''
    end

    it 'associates a collection with a recording' do
      expect($dbtest.associate_collection_and_recording(
        { :title => 'PJBE - Brass Splendour',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })).to include_recordings([
          { :filename => 'PJBE - Brass Splendour/Track 2.wav' }
        ])
    end

    it 'raises runtime error when the collection is not in the collections table' do
      expect{ $dbtest.associate_collection_and_recording(
        { :title => 'No such collection',
          :filename => 'PJBE - Brass Splendour'
        })
      }.to raise_error 'No such collection was not found in table: collections'
    end

    it 'raises runtime error when the recording is not in the recordings table' do
      expect{ $dbtest.associate_collection_and_recording(
        { :title => 'PJBE - Brass Splendour',
          :filename => 'no such filename'
        })
      }.to raise_error 'no such filename was not found in table: recordings'
    end

  end # describe people_roles_recordings table

end # context sequel gem
