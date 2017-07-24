require 'sequel'
require 'logger'
require 'yaml'
require_relative "../app/db_connect"
require_relative "../app/db_helpers"


class DbLoad
  include DbConnect, DbHelpers

  def run
    $config = YAML.load_file("./config/config.yml")
    connect

    # table: groups
    [
      'Philip Jones Brass Ensemble'
    ].each do |group_name|
      add_group group_name
    end

    # table: group_types
    [
      'Big Band',
      'Bluegrass Band',
      'Chamber Orchestra',
      'Country Band',
      'Brass Ensemble',
      'Brass Quintet',
      'Concert Band',
      'Jazz Combo',
      'Jazz Orchestra',
      'Metal Band',
      'Military Band',
      'Orchestra',
      'Pop Band',
      'Rock Band',
      'SATB Chorus',
      'String Orchestra',
      'String Quartet',
      'Symphonic Band',
      'Wind Ensemble',
      'Wind Orchestra',
      'Woodwind Ensemble',
      'Woodwind Quintet'
    ].each do |group_type_name|
      add_group_type group_type_name
    end

    # table: group_type_synonyms
    [
      [ 'Big Band', 'Jazz Orchestra' ],
      [ 'Concert Band', 'Wind Ensemble' ],
      [ 'Concert Band', 'Symphonic Band' ],
      [ 'Concert Band', 'Wind Orchestra' ],
      [ 'Concert Band', 'Military Band' ],
    ].each do |base, synonym|
      associate_group_type_and_synonym base, synonym
    end

    # table: groups_group_types
    #TODO load the groups_group_types table

    # table: labels
    #TODO load the labels table


    # table: people
    [
      [ 'Bach', 'Carl Philip Emmanuel', 'C.P.E. Bach' ],
      [ 'Bach', 'Johann Sebastian', '' ],
      [ 'Byrd', 'William', '' ],
      [ 'Clarke', 'Jeremiah', '' ],
      [ 'Copland', 'Aaron', '' ],
      [ 'Dvorak', 'Antonin', '' ],
      [ 'Gabrieli', 'Giovanni', '' ],
      [ 'Handel', 'Georg Fridric', '' ],
      [ 'Howarth', 'Elgar', '' ],
      [ 'Jones', 'Philip', '' ],
      [ 'Mussorgsky', 'Modest', '' ],
      [ 'Purcell', 'Henry', '' ],
      [ 'Scheidt', 'Samuel', '' ],
      [ 'Strauss', 'Richard', '' ],
      [ 'Tchaikovsky', 'Pyotr Ilyich', '' ],
      [ 'Wagner', 'Richard', '' ],
    ].each do |person|
      add_person person[0], person[1], person[2]
    end

    # table: roles
    add_roles([
      'Arranger',
      'Composer',
      'Conductor',
      'Engineer',
      'Lyricist',
      'Performer',
      'Soloist'
    ])

    # table: pieces
    [
      [ 'Christmas Oratorio', 'Ach, mein herzliches Jesulein' ],
      [ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
      [ 'Music for the Royal Fireworks', '' ],
      [ 'Sonata pian\'e forte', '' ],
      [ 'Trumpet Voluntary', '' ],
      [ 'The Battell', 'The Marche to the Fighte' ],
      [ 'The Battell', 'The Retraite' ],
      [ 'Trumpet Tune and Air', '' ],
      [ 'Galliard Battaglia', '' ],
      [ 'March', '(C.P.E. Bach)' ],
      [ 'Festmusik der Stadt Wien', 'Fanfare' ],
      [ 'Humoresque', 'Op. 101, No. 7' ],
      [ 'Sleeping Beauty', 'Waltz' ],
      [ 'Fanfare for the Common Man', '' ],
      [ 'Pictures at an Exhibition', 'Baba Yaga' ],
      [ 'Pictures at an Exhibition', 'Great Gate of Kiev' ]
    ].each do |piece|
      add_piece piece[0], piece[1]
    end

    # table: people_roles_pieces
    [
      [ 'Bach', 'Carl Philip Emmanuel', 'Composer', 'March', '(C.P.E. Bach)' ],
      [ 'Bach', 'Johann Sebastian', 'Composer', 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen' ],
      [ 'Bach', 'Johann Sebastian', 'Composer', 'Christmas Oratorio', 'Ach, mein herzliches Jesulein' ],
      [ 'Byrd', 'William', 'Composer', 'The Battell', 'The Marche to the Fighte'],
      [ 'Byrd', 'William', 'Composer', 'The Battell', 'The Retraite' ],
      [ 'Clarke', 'Jeremiah', 'Composer', 'Trumpet Voluntary', ''],
      [ 'Copland', 'Aaron', 'Composer', 'Fanfare for the Common Man', '' ],
      [ 'Dvorak', 'Antonin', 'Composer', 'Humoresque', 'Op. 101, No. 7' ],
      [ 'Gabrieli', 'Giovanni', 'Composer', 'Sonata pian\'e forte', '' ],
      [ 'Handel', 'Georg Fridric', 'Composer', 'Music for the Royal Fireworks', '' ],
      [ 'Mussorgsky', 'Modest', 'Composer', 'Pictures at an Exhibition', 'Baba Yaga' ],
      [ 'Mussorgsky', 'Modest', 'Composer', 'Pictures at an Exhibition', 'Great Gate of Kiev' ],
      [ 'Purcell', 'Henry', 'Composer', 'Trumpet Tune and Air' ],
      [ 'Scheidt', 'Samuel', 'Composer', 'Galliard Battaglia', '' ],
      [ 'Strauss', 'Richard', 'Composer', 'Festmusik der Stadt Wien', 'Fanfare' ],
      [ 'Tchaikovsky', 'Pyotr Ilyich', 'Composer', 'Sleeping Beauty', 'Waltz' ]
    ].each do |assoc|
      associate_person_role_and_piece({
        :surname => assoc[0], :given_name => assoc[1], :role_name => assoc[2], :title => assoc[3], :subtitle => assoc[4]
      })
    end

    # table: recordings
    [
      [ 'PJBE - Brass Splendour/Track 1.wav', 537, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 2.wav', 193, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 3.wav', 77, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 4.wav', 277, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 5.wav', 163, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 6.wav', 243, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 7.wav', 173, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 8.wav', 110, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 9.wav', 177, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 10.wav', 132, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 11.wav', 155, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 12.wav', 186, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 13.wav', 182, '1984-01-01', '' ],
      [ 'PJBE - Brass Splendour/Track 14.wav', 529, '1984-01-01', '' ],
    ].each do |recording|
      add_recording recording[0], recording[1], recording[2], recording[3]
    end

    # table: pieces_recordings
    [
      [ 'Music for the Royal Fireworks', '', 'PJBE - Brass Splendour/Track 1.wav', 537, '1984-01-01' ],
      [ 'Christmas Oratorio', 'Nun seid Ihr wohl gerochen', 'PJBE - Brass Splendour/Track 2.wav' ],
      [ 'Christmas Oratorio', 'Ach, mein herzliches Jesulein', 'PJBE - Brass Splendour/Track 3.wav' ],
      [ 'Sonata pian\'e forte', '', 'PJBE - Brass Splendour/Track 4.wav' ],
      [ 'Trumpet Voluntary', '', 'PJBE - Brass Splendour/Track 5.wav' ],
      [ 'The Battell', 'The Marche to the Fighte', 'PJBE - Brass Splendour/Track 6.wav' ],
      [ 'The Battell', 'The Retraite', 'PJBE - Brass Splendour/Track 6.wav' ],
      [ 'Trumpet Tune and Air', '', 'PJBE - Brass Splendour/Track 7.wav' ],
      [ 'Galliard Battaglia', '', 'PJBE - Brass Splendour/Track 8.wav' ],
      [ 'March', '(C.P.E. Bach)', 'PJBE - Brass Splendour/Track 9.wav' ],
      [ 'Festmusik der Stadt Wien', 'Fanfare', 'PJBE - Brass Splendour/Track 10.wav' ],
      [ 'Humoresque', 'Op. 101, No. 7', 'PJBE - Brass Splendour/Track 11.wav' ],
      [ 'Sleeping Beauty', 'Waltz', 'PJBE - Brass Splendour/Track 12.wav' ],
      [ 'Fanfare for the Common Man', '', 'PJBE - Brass Splendour/Track 13.wav' ],
      [ 'Pictures at an Exhibition', 'Baba Yaga', 'PJBE - Brass Splendour/Track 14.wav' ],
      [ 'Pictures at an Exhibition', 'Great Gate of Kiev', 'PJBE - Brass Splendour/Track 14.wav' ],
    ].each do|title, subtitle, filename|
      associate_piece_and_recording(
        { :title => title,
          :subtitle => subtitle,
          :filename => filename
        })
    end

  end # run

end

DbLoad.new.run
