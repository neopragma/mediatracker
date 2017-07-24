require_relative "./db_connect"

class Search
  include DbConnect

  def initialize
    connect
  end

  def find_recordings_by_composer values_hash
    find_recordings_by_role 'Composer', values_hash
  end

  def find_recordings_by_role role_name, values_hash

puts "Search.find_recordings_by_role: role_name: #{role_name}, values_hash: #{values_hash}"

    person_id = lookup_person_id_for values_hash[:surname], values_hash[:given_name]
    role_id = lookup_role_id_for role_name
    @db[:recordings, :pieces, :pieces_recordings, :people_roles_recordings]
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

private

  def lookup_role_id_for role_name
    role = @db[:roles]
      .select(:id)
      .where(:role_name => role_name)
    raise RuntimeError, "The role \"#{role_name}\" is not in the roles table. "\
      "Most likely the database has not been loaded correctly." unless role && (role.count > 0)
    role.first[:id]
  end

  def lookup_person_id_for surname, given_name
    person = @db[:people]
      .select(:id)
      .where(:surname => surname, :given_name => given_name)
    raise RuntimeError, "The name \"#{surname}, #{given_name}\" is not in the people table. "\
      'Most likely the database has not been loaded correctly.' unless person && (person.count > 0)
    person.first[:id]
  end

end
