Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'logout'
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method get
    Then status 200
