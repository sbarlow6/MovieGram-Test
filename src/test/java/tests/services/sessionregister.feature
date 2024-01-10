Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'register?username=' + usernamefore2e + '&password=' + passwordfore2e + '&fullname=' + fullnamefore2e + '&aboutme=undefined'
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method post
    Then status 200
