require_relative "../../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'group_types table:' do

    before do
      @dbtest.clear_table :group_types
    end

    it 'deletes all rows from the group_types table' do
      expect(@dbtest.group_types.count).to eq 0
    end

    it 'inserts one row into the group_types table' do
      @dbtest.add_group_type 'Brass Ensemble'
      expect(@dbtest.group_types.count).to eq 1
    end

    it 'inserts the expected values into a single row of the group_types table' do
      @dbtest.add_group_type('Brass Ensemble')
      expect(@dbtest.group_types.first[:group_type_name]).to eq 'Brass Ensemble'
    end

    it 'inserts multiple rows into the group_types table' do
      @dbtest.add_group_types([ 'Brass Ensemble', 'Brass Quintet' ])
      expect(@dbtest.group_types.count).to eq 2
    end

    it 'returns the data for the specified group type' do
      @dbtest.add_group_types([ 'Brass Ensemble', 'Brass Quintet' ])
      expect(@dbtest.group_type('Brass Quintet')[:group_type_name]).to eq 'Brass Quintet'
    end

    it 'returns all group types names in ascending order' do
      @dbtest.add_group_types([ 'Rock Band', 'Brass Ensemble', 'String Quartet' ])
      result = @dbtest.group_types.all
      expect(result[0][:group_type_name]).to eq 'Brass Ensemble'
      expect(result[1][:group_type_name]).to eq 'Rock Band'
      expect(result[2][:group_type_name]).to eq 'String Quartet'
    end

  end # describe group_types table

end # context sequel gem
