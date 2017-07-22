require_relative "../../app/db_helpers"

class Db
  include DbHelpers
end

context 'sequel gem:' do

  before do
    @dbtest = Db.new
  end

  describe 'groups table:' do

    before do
      @dbtest.clear_table :groups
    end

    it 'deletes all rows from the groups table' do
      expect(@dbtest.groups.count).to eq 0
    end

    it 'inserts one row into the groups table' do
      @dbtest.add_group 'Philip Jones Brass Ensemble' 
      expect(@dbtest.groups.count).to eq 1
    end

    it 'inserts the expected values into a single row of the groups table' do
      @dbtest.add_group('Philip Jones Brass Ensemble')
      expect(@dbtest.groups.first[:group_name]).to eq 'Philip Jones Brass Ensemble'
    end

    it 'inserts multiple rows into the groups table' do
      @dbtest.add_groups([ 'Philip Jones Brass Ensemble', 'Canadian Brass' ])
      expect(@dbtest.groups.count).to eq 2
    end

    it 'returns the data for the specified group' do
      @dbtest.add_groups([ 'Philip Jones Brass Ensemble', 'Canadian Brass' ])
      expect(@dbtest.group('Canadian Brass')[:group_name]).to eq 'Canadian Brass'
    end

    it 'returns all group names in ascending order' do
      @dbtest.add_groups([ 'Philip Jones Brass Ensemble', 'Canadian Brass', 'Aerosmith' ])
      result = @dbtest.groups.all
      expect(result[0][:group_name]).to eq 'Aerosmith'
      expect(result[1][:group_name]).to eq 'Canadian Brass'
      expect(result[2][:group_name]).to eq 'Philip Jones Brass Ensemble'
    end

  end # describe groups table

end # context sequel gem
