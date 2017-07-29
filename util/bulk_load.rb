require 'smarter_csv'
require_relative "../app/db_connect"
require_relative "../app/db_helpers"

class BulkLoad
  include DbConnect, DbHelpers

  def load_data
    connect
    options = { :col_sep => ';' }
    SmarterCSV.process('spec/bulk_load/fixtures/data.csv', options).each do |row|
      send("load_#{row[:table_name]}", row)
    end
  end

  def load_groups row
    add_group "#{row[:group_name]}"
  end

  def load_group_types row
    add_group_type "#{row[:group_type_name]}"
  end

  def load_group_type_synonyms row
    associate_group_type_and_synonym "#{row[:base_group_type]}", "#{row[:synonym_group_type]}"
  end

  def load_groups_group_types row
    associate_group_and_group_type({
      :group_name => row[:group_name],
      :group_type_name => row[:group_type_name]
    })
  end

  def load_labels row
    add_label "#{row[:label_name]}"
  end

end
