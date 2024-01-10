Feature: Test for CSV

Scenario:
    * print 'Inside get review service'
    Given url baseUrl + 'savereviews'
    And header Cookie = 'JSESSIONID=' + sessionvalue + '; Domain=localhost'
    And request { movieid: '#(imdbid)', revrating: '#(revrating)', revdesc: '#(revdesc)' }
    When method post
    Then status 200
