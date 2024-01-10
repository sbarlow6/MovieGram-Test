Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'deletereviews?revid=' + revid
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    When method delete
    Then status 200
    # * karate.log(response.cookies['JSESSIONID'][0])
    # * cookie sessionToken = response.cookies['sessionToken']