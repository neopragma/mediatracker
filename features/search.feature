Feature: Search for recordings

Background:
  Given the standard test database load

Scenario: Find all recordings of music by J.S. Bach
  When a client searches for recordings composed by "Bach", "Johann Sebastian"
  Then the service returns filename "PJBE - Brass Splendour/Track 2.wav"
  And the service returns filename "PJBE - Brass Splendour/Track 3.wav"
  And the service does not return filename "PJBE - Brass Splendour/Track 1.wav"
