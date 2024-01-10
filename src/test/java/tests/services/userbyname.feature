Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'userbyname?username=' + textuname
    When method get