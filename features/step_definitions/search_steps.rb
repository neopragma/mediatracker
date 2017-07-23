Given(/^the standard test database load$/) do
  # do-nothing method
end

When(/^a client searches for recordings composed by "([^"]*)", "([^"]*)"$/) do |arg1, arg2|
  params = CGI.escape("#{arg1}/#{arg2}")
  @response = RestClient.get "#{$BASE_URL}/recordings/by/composer/#{params}"
end

Then(/^the service returns "([^"]*)"$/) do |arg1|
  expect(@response).to eq('foo')
end
