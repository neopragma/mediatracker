Given(/^the standard test database load$/) do
  # do-nothing method
end

When(/^a client searches for recordings composed by "([^"]*)", "([^"]*)"$/) do |arg1, arg2|
  params = CGI.escape("#{arg1}/#{arg2}")
  result_hash = JSON.parse(RestClient.get "#{$BASE_URL}/recordings/by/composer/#{params}")
  @actual_filenames = []
  result_hash['result'].each do |result|
    @actual_filenames << result['filename']
  end
end

Then(/^the service returns filename "([^"]*)"$/) do |arg1|
  expect(@actual_filenames).to include(arg1)
end

Then(/^the service does not return filename "([^"]*)"$/) do |arg1|
  expect(@actual_filenames).not_to include(arg1)
end
