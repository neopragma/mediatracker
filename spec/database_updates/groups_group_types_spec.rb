require_relative "../../app/db_helpers"

# Expresses behaviors of the groups_group_types association.

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'groups_group_types table:' do

    before do
      $dbtest.clear_table :groups
      [
        'Philip Jones Brass Ensemble',
        'Canadian Brass',
        'Aerosmith'
      ].each do |group_name|
        $dbtest.add_group group_name
      end

      $dbtest.clear_table :group_types
      [
        'Brass Ensemble',
        'Brass Quintet',
        'Rock Band'
      ].each do |group_type_name|
        $dbtest.add_group_type group_type_name
      end
    end

    it 'associates a group with a group type' do
      expect($dbtest.associate_group_and_group_type(
        { :group_name => 'Philip Jones Brass Ensemble',
          :group_type_name => 'Brass Ensemble'
        })).to include_groups([
          { :group_name => 'Philip Jones Brass Ensemble' }
        ])
    end
=begin
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
=end
  end # describe groups_group_types table

end # context sequel gem
