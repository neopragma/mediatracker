require_relative "../../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  describe 'group_type_synonyms table:' do

    before do
      $dbtest.clear_table :group_types
      [
        'Concert Band',
        'Military Band'
      ].each do |group_type_name|
        $dbtest.add_group_type group_type_name
      end
    end

    it 'associates a synonym with a group_type' do
      expect($dbtest.associate_group_type_and_synonym 'Concert Band', 'Military Band')
        .to equate_base_group_type_with_synonym_group_type([
          $dbtest.db[:group_types].select(:id).where(:group_type_name => 'Concert Band').first,
          $dbtest.db[:group_types].select(:id).where(:group_type_name => 'Military Band').first
        ])
    end

    it 'finds the base group type for a given synonym group type' do
      $dbtest.associate_group_type_and_synonym 'Concert Band', 'Military Band'
      expect($dbtest.find_base_group_type_for_synonym('Military Band')[:group_type_name])
        .to eq('Concert Band')
    end

  end

end
