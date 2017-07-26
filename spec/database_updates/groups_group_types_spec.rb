require_relative "../db"
require_relative "../matchers/matchers_spec"

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

    it 'raises runtime error when the group is not in the groups table' do
      expect{ $dbtest.associate_group_and_group_type(
        { :group_name => 'No such group',
          :group_type_name => 'PJBE - Brass Splendour'
        })
      }.to raise_error 'No such group not found in table: groups'
    end

    it 'raises runtime error when the group type is not in the group_types table' do
      expect{ $dbtest.associate_group_and_group_type(
        { :group_name => 'Philip Jones Brass Ensemble',
          :group_type_name => 'no such group_type'
        })
      }.to raise_error 'no such group_type not found in table: group_types'
    end

  end # describe groups_group_types table

end # context sequel gem
