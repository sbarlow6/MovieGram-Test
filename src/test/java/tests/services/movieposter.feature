Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'movieposter?imdbID=' + imdbID
    When method get

