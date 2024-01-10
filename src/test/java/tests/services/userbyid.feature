Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'namebyuser?userid=' + textuid
    When method get
