Given(/^a client does not know how to format uri strings to call the service$/) do
  # do-nothing method
end

When(/^a client calls the service passing no query values$/) do
  @result_hash = JSON.parse(RestClient.get "#{$BASE_URL}")
end

Then(/^the service returns information about how to submit queries$/) do
    expect(@result_hash['result'].keys).to eq([ 'description', 'examples' ])
    expect(@result_hash['result']['examples'][0].keys).to eq([ 'uri', 'description' ])
end
