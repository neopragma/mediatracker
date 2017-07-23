Feature: Search for recordings

Background:
  Given the standard test database load

Scenario Outline: Find all recordings of music by J.S. Bach
  When a client searches for recordings composed by "Bach", "Johann Sebastian"
  Then the service returns <filename>
  Examples:
    | filename |
    | "Track 3.wav" |
    | "Track 2.wav" |
