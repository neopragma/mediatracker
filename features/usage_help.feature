Feature: Getting help for formulating queries

Scenario: Client wants to know how to use the service
  Given a client does not know how to format uri strings to call the service
  When a client calls the service passing no query values
  Then the service returns information about how to submit queries
