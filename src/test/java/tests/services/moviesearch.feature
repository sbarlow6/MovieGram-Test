Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'movies?moviename=' + filmtitle + '&movieyear=' + filmyear
    When method get
    Then status 200
