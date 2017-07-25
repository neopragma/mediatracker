require_relative "../../app/usage"

context 'providing usage help to clients:' do

  before do
    @usage = Usage.new
  end

  it 'returns a json document with usage notes and sample queries' do
    expect(@usage.help).to eq(
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
    )

  end

end
