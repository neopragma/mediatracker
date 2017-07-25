class Usage

  def help
    {
      :description => 'Locate items that belong to a media collection',
      :examples =>
      [
        {
          :uri => '/recordings/by/composer/:surname/:given_name',
          :description => 'Find all recordings of music written by a given composer or songwriter.'
        }
      ]  
    }
  end

end
