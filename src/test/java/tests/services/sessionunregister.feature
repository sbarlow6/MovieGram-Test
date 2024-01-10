Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'unregister'
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method delete
    Then status 200
