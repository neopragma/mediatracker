When(/^client invokes the default route$/) do
  @response = RestClient.get 'http://localhost:9292/'
end

Then(/^the service returns the text "Welcome to Sinatra"$/) do
  expect(@response).to eq 'Welcome to Sinatra'
end

When(/^the client invokes the sample JSON route$/) do
  @response = RestClient.get 'http://localhost:9292/json'
end

Then(/^the service returns the "welcome" JSON document$/) do
  expect(JSON.parse(@response)["message"]).to eq 'Welcome to Sinatra'
end
