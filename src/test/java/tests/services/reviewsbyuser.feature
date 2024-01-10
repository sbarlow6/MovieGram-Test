Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'reviewsbyuser?username=' + revusername
    When method get
