require_relative "../db"
require_relative "../matchers/matchers_spec"
require_relative "../../util/bulk_load"

# Note: SmarterCSV claims to handle any object that responds to readline, but in
# fact it does not work (or did not at the time I tried it) read a StringIO
# object correctly. It is necessary to write actual files for testing it.

context 'bulk load:' do
  before do
    @db = Db.new
    @loader = BulkLoad.new
  end

  describe 'populate groups table:' do
    before do
      @db.clear_table :groups
      load_test_fixture :groups
    end

    it 'loads 2 rows into the groups table from the delimited file' do
      @loader.load_data
      expect(@db.groups.count).to eq 2
    end

    it 'loads the expected values into the groups table' do
      @loader.load_data
      expect(@db.groups).to include_groups([
        'The Beatles',
        'Philip Jones Brass Ensemble'
      ])
    end
  end

  describe 'populate group_types table:' do
    before do
      @db.clear_table :group_types
      load_test_fixture :group_types
    end

    it 'loads 2 rows into the group_types table from the delimited file' do
      @loader.load_data
      expect(@db.group_types.count).to eq 2
    end

    it 'loads the expected values into the group_types table' do
      @loader.load_data
      expect(@db.group_types).to include_group_types([
        'Pop Band',
        'Brass Ensemble'
      ])
    end
  end

=begin
    it 'raises runtime error when the role "Composer" is not in the roles table' do
      set_up_bach_recordings
      @db.transaction do
        @db.dataset(:roles).where(:role_name => 'Composer').delete
      end

      expect{ @search.find_recordings_by_composer({
        :surname => 'Bach',
        :given_name => 'Johann Sebastian'
      })}.to raise_error 'The role "Composer" is not in the roles table. '\
                         'Most likely the database has not been loaded correctly.'
    end
=end

  def load_test_fixture table_name
    data = {
      :groups => [
        'table_name;group_name;',
        'groups;The Beatles;',
        'groups;Philip Jones Brass Ensemble;'
      ],
      :group_types => [
        'table_name;group_type_name;',
        'group_types;Pop Band;',
        'group_types;Brass Ensemble'
      ]
    }
    File.open('spec/bulk_load/fixtures/data.csv', "w") do |file|
      data[table_name].each do |line|
        file.puts line
      end
    end
  end

end
