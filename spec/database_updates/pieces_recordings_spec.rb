require_relative "../db"
require_relative "../matchers/matchers_spec"

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'pieces_recordings table:' do

    before do
      $dbtest.clear_table :pieces
      $dbtest.add_piece 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen'
      $dbtest.add_piece 'Christmas Oratorio', 'Ach, mein hertzliches Jesulein'

      $dbtest.clear_table :recordings
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', ''
      $dbtest.add_recording 'PJBE - Brass Splendour/Track 3.wav', 163, '1984-01-01', ''
    end

    it 'associates a piece with a recording' do
      expect($dbtest.associate_piece_and_recording(
        { :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen',
          :filename => 'PJBE - Brass Splendour/Track 2.wav'
        })).to include_recordings([
          { :filename => 'PJBE - Brass Splendour/Track 2.wav' }
        ])
    end

    it 'raises runtime error when the piece is not in the pieces table' do
      expect{ $dbtest.associate_piece_and_recording(
        { :title => 'No such piece',
          :subtitle => 'Nun seid Ihr wohl gerochen',
          :filename => 'PJBE - Brass SplendourTrack 2.wav'
        })
      }.to raise_error "Piece entitled No such piece and subtitled Nun seid Ihr wohl gerochen not found in table: pieces"
    end

    it 'raises runtime error when the recording is not in the recordings table' do
      expect{ $dbtest.associate_piece_and_recording(
        { :title => 'Christmas Oratorio',
          :subtitle => 'Nun seid Ihr wohl gerochen',
          :filename => 'no such filename'
        })
      }.to raise_error "no such filename not found in table: recordings"
    end

  end # describe people_roles_recordings table

end # context sequel gem
