require_relative "../db"
require_relative "../matchers/matchers_spec"

context 'sequel gem:' do

  before do
    $dbtest = Db.new
  end

  describe 'collections_labels table:' do

    before do
      $dbtest.clear_table :collections
      $dbtest.add_collection 'PJBE - Brass Splendour', '1984', 'great brass playing'

      $dbtest.clear_table :labels
      $dbtest.add_label 'Apple'
      $dbtest.add_label 'London'
      $dbtest.add_label 'Nonesuch'
    end

    it 'associates a collection with a label' do
      expect($dbtest.associate_collection_and_label(
        { :title => 'PJBE - Brass Splendour',
          :label_name => 'London'
        })).to include_labels([
          { :label_name => 'London' }
        ])
    end

    it 'raises runtime error when the collection is not in the collections table' do
      expect{ $dbtest.associate_collection_and_label(
        { :title => 'No such collection',
          :label_name => 'London'
        })
      }.to raise_error 'No such collection not found in table: collections'
    end

    it 'raises runtime error when the label is not in the labels table' do
      expect{ $dbtest.associate_collection_and_label(
        { :title => 'PJBE - Brass Splendour',
          :label_name => 'no such label'
        })
      }.to raise_error 'no such label not found in table: labels'
    end

  end # describe collections_labels table

end # context sequel gem
