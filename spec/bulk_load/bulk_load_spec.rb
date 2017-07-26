require_relative "../db"
require_relative "../matchers/matchers_spec"
require_relative "../../util/bulk_load"

# Note: SmarterCSV claims to handle any object that responds to readline, but in
# fact it does not work (or did not at the time I tried it) read a StringIO
# object correctly. It is necessary to write actual files for testing it.

TEST_FIXTURES = 'spec/bulk_load/fixtures/data.csv'

context 'bulk load:' do
  before do
    @db = Db.new
    @loader = BulkLoad.new
  end

  describe 'populate groups table:' do
    before do
      load_test_fixture :groups
      @loader.load_data
    end

    it 'loads 2 rows into the groups table from the delimited file' do
      expect(@db.groups.count).to eq 2
    end

    it 'loads the expected values into the groups table' do
      expect(@db.groups).to include_groups([
        'The Beatles',
        'Philip Jones Brass Ensemble'
      ])
    end
  end

  describe 'populate group_types table:' do
    before do
      load_test_fixture :group_types
      @loader.load_data
    end

    it 'loads 3 rows into the group_types table from the delimited file' do
      expect(@db.group_types.count).to eq 3
    end

    it 'loads the expected values into the group_types table' do
      expect(@db.group_types).to include_group_types([
        'Pop Band',
        'Brass Ensemble'
      ])
    end
  end

  describe 'populate group_type_synonyms table:' do
    before do
      load_test_fixture :group_types
      @loader.load_data
      load_test_fixture :group_type_synonyms
      @loader.load_data
    end

    it 'loads 1 row into the group_type_synonyms table' do
      expect(@db.find_base_group_type_for_synonym('Rock Band')[:group_type_name])
        .to eq('Pop Band')
    end
  end

  def load_test_fixture table_name
    File.delete(TEST_FIXTURES)
    data = {
      :groups => [
        'table_name;group_name;',
        'groups;The Beatles;',
        'groups;Philip Jones Brass Ensemble;'
      ],
      :group_types => [
        'table_name;group_type_name;',
        'group_types;Pop Band;',
        'group_types;Rock Band;',
        'group_types;Brass Ensemble;'
      ],
      :group_type_synonyms => [
        'table_name;base_group_type;synonym_group_type;',
        'group_type_synonyms;Pop Band;Rock Band;'
      ]
    }
    File.open(TEST_FIXTURES, "a") do |file|
      @db.clear_table table_name
      data[table_name].each do |line|
        file.puts line
      end
    end
  end

end
