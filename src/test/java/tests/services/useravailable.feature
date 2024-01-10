Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'checkuser?username=' + textuname
    When method post
    Then status 200
