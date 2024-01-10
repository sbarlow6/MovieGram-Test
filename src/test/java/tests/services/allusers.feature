Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'all'
    When method get
    Then status 200
