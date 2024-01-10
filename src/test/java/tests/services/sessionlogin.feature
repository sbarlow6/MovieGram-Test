Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'login?username=' + usernamefore2e + '&password=' + passwordfore2e
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method post
    Then status 200
    # And cookie sessionToken
