Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'reviewsbymovie?imdbid=' + imdbid
    When method get
    Then status 200
    