Feature: Verify installation of skeleton microservices app

Scenario: Retrieval of plain text content
  When client invokes the default route
  Then the service returns the text "Welcome to Sinatra"

Scenario: Retrieval of JSON content
  When the client invokes the sample JSON route
  Then the service returns the "welcome" JSON document

