require_relative "./db_connect"

class Search
  include DbConnect

  def find_recordings_by_composer values_hash
    #TODO try and get this down to a single select statement
    person_id = db[:people]
      .select(:id)
      .where(:surname => values_hash[:surname], :given_name => values_hash[:given_name])
      .first[:id]
    role_id = db[:roles]
      .select(:id)
      .where(:role_name => 'Composer')
      .first[:id]
    db[:recordings, :pieces, :pieces_recordings, :people_roles_recordings]
      .select(:filename, :title, :subtitle)
      .distinct
      .where(Sequel[:recordings][:id] => Sequel[:people_roles_recordings][:recording_id],
             Sequel[:people_roles_recordings][:person_id] => person_id,
             Sequel[:people_roles_recordings][:role_id] => role_id,
             Sequel[:people_roles_recordings][:recording_id] => Sequel[:pieces_recordings][:recording_id],
             Sequel[:pieces][:id] => Sequel[:pieces_recordings][:piece_id])
      .order(:title, :subtitle)
      .all
  end

end
