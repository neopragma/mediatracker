require 'sequel'
require 'logger'
require_relative "../app/db_helpers"

class DbInit
  include DbHelpers

  def run
    drop_table :people_roles_pieces

    db.create_table! :collections  do
      primary_key :id
      String :title, :null=>false
      String :year_released
      String :remarks
    end

    db.create_table! :groups do
      primary_key :id
      String :group_name, :null => false
    end

    db.create_table! :group_types do
      primary_key :id
      String :group_type_name, :null => false
    end

    db.create_table! :labels  do
      primary_key :id
      String :label_name, :null=>false
    end

    db.create_table! :people  do
      primary_key :id
      String :surname, :null=>false
      String :given_name
      String :nickname

    end

    db.create_table! :pieces do
      primary_key :id
      String :title, :null=>false
      String :subtitle
    end

    db.create_table! :recordings  do
      primary_key :id
      String :filename, :null=>false
      String :description
      Date :recording_date
      Integer :duration_in_seconds
    end

    db.create_table! :roles  do
      primary_key :id
      String :role_name, :null=>false
    end

    db.create_table! :groups_group_types do
      foreign_key :group_id, :groups,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      foreign_key :group_type_id, :group_types,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      primary_key [ :group_id, :group_type_id ]
    end

    db.create_table! :pieces_recordings do
      foreign_key :piece_id, :pieces,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :recording_id, :recordings,
                  { :deferrable => true,
                    :on_delete => :cascade,
                     :on_update => :set_null
                  }
      primary_key [ :piece_id, :recording_id ]
    end

    db.create_table! :people_roles_pieces do
      foreign_key :piece_id, :pieces,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :person_id, :people,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :role_id, :roles,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      primary_key [ :piece_id, :person_id, :role_id ]
    end

    db.create_table! :people_roles_recordings do
      foreign_key :recording_id, :recordings,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :person_id, :people,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :role_id, :roles,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null }
      primary_key [ :recording_id, :person_id, :role_id ]
    end

    db.create_table! :collections_labels do
      foreign_key :collection_id, :collections,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      foreign_key :label_id, :labels,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      primary_key [ :collection_id, :label_id ]
    end

    db.create_table! :collections_recordings do
      foreign_key :collection_id, :collections,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      foreign_key :recording_id, :recordings,
                  { :deferrable => true,
                    :on_delete => :cascade,
                    :on_update => :set_null
                  }
      primary_key [ :collection_id, :recording_id ]
    end

    db.create_table! :group_types_recordings do
      foreign_key :group_type_id, :group_types,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      foreign_key :recording_id, :recordings,
                { :deferrable => true,
                  :on_delete => :cascade,
                  :on_update => :set_null
                }
      primary_key [ :group_type_id, :recording_id ]
    end
  end

end

DbInit.new.run
