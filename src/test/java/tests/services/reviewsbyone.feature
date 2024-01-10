Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'reviewsbyone?revid=' + revid
    When method get
