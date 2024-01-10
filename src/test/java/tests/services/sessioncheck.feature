Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'session'
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method get
    Then status 200
    # And cookie sessionToken
