require_relative "../db"
require_relative "../matchers/matchers_spec"

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'group_types_recordings table:' do

    before do
      $dbtest.clear_table :group_types
      $dbtest.add_group_type 'Brass Ensemble'

      $dbtest.clear_table :recordings
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 5.wav', 163, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 6.wav', 243, '1984-01-01', ''
    end

    it 'associates a group_type with a recording' do
      expect($dbtest.associate_group_type_and_recording(
        { :group_type_name => 'Brass Ensemble',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })).to include_recordings([
          { :filename => 'PJBE - Brass Splendour/Track 2.wav' }
        ])
    end

    it 'raises runtime error when the group_type is not in the group_types table' do
      expect{ $dbtest.associate_group_type_and_recording(
        { :group_type_name => 'No such group_type',
          :filename => 'PJBE - Brass Splendour'
        })
      }.to raise_error 'No such group_type not found in table: group_types'
    end

    it 'raises runtime error when the recording is not in the recordings table' do
      expect{ $dbtest.associate_group_type_and_recording(
        { :group_type_name => 'Brass Ensemble',
          :filename => 'no such filename'
        })
      }.to raise_error 'no such filename not found in table: recordings'
    end

  end # describe group_types_recordings table

end # context sequel gem
