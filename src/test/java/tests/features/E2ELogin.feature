Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * def smoke = read('classpath:tests/CSVfiles/logine2e/smoke.csv')
    * def sessionvalue = ''
	* def DbUtils = Java.type('util.DBUtils')
	* def db = new DbUtils(dbconfig)

# Search for a movie
  Scenario Outline: '<Scenario>'
    * print 'test'
    # Attempt to delete a review that isn't ours
    * def deletereview = call read('classpath:tests/services/reviewdelete.feature')
    * karate.log(deletereview)
    * karate.log(deletereview.responseHeaders)
    * karate.log(sessionvalue)
    * def sessionvalue = deletereview.responseHeaders['Set-Cookie'][0].split('=')[1].split(';')[0].trim()
    * assert deletereview.responseStatus == respStatus
    * assert deletereview.response == failedrevdelete

    # Verify that we are not currently logged in
    * def sessioncheck = call read('classpath:tests/services/sessioncheck.feature')
    * karate.log(sessioncheck.response)
    * assert sessioncheck.responseStatus == respStatus
    * match sessioncheck.response == ''

    # Register the test user
    * def register = call read('classpath:tests/services/sessionregister.feature')
    * karate.log(register.response)
    * assert register.responseStatus == respStatus

    # Login to the newly registered test user
    * def login = call read('classpath:tests/services/sessionlogin.feature')
    * karate.log(login.response)
    * assert login.responseStatus == respStatus

    # Verify that we are now currently logged in
    * def sessioncheck2 = call read('classpath:tests/services/sessioncheck.feature')
    * karate.log(sessioncheck2.response.username)
    * assert sessioncheck2.responseStatus == respStatus
    * match sessioncheck2.response.username == usernamefore2e

    # Submit a review
    * def savereview1 = call read('classpath:tests/services/reviewsave.feature')
    * karate.log(savereview1.response)
    * assert savereview1.responseStatus == respStatus

    # Submit a second review
    * def savereview2 = call read('classpath:tests/services/reviewsave.feature')
    * karate.log(savereview2.response)
    * assert savereview2.responseStatus == respStatus

    # Confirm that both reviews are present for the Test User
    * def revusername = usernamefore2e
    * def test = call read('classpath:tests/services/reviewsbyuser.feature')
    * karate.log(test.response)
    * def reviews = db.readRows('SELECT * FROM reviews WHERE revid IN (' + test.response[0].revid + ',' + test.response[1].revid + ')')
    * karate.log(reviews.length)
    * assert reviews.length == 2

    # Delete the first review
    * def revid = test.response[0].revid
    * def deletereview1 = call read('classpath:tests/services/reviewdelete.feature')
    * karate.log(deletereview1.response)
    * assert deletereview1.responseStatus == respStatus
    * match deletereview1.response == 'Success'
    

    # Confirm that one review is gone
    * def test = call read('classpath:tests/services/reviewsbyuser.feature')
    * karate.log(test.response)
    * karate.log(test.response.length)
    * assert test.response.length == 1

    # Log out
    * def logout = call read('classpath:tests/services/sessionlogout.feature')
    * karate.log(logout.response)
    * assert logout.responseStatus == respStatus

    # Confirm that session is blank
    * def sessioncheck3 = call read('classpath:tests/services/sessioncheck.feature')
    * karate.log(sessioncheck3.response)
    * assert test.responseStatus == respStatus
    * match sessioncheck.response == ''

    # Log back in
    * def login = call read('classpath:tests/services/sessionlogin.feature')
    * def sessionvalue = login.responseHeaders['Set-Cookie'][0].split('=')[1].split(';')[0].trim()
    * karate.log(login.response)
    * assert test.responseStatus == respStatus

    # Verify that we are now currently logged in
    * def sessioncheck6 = call read('classpath:tests/services/sessioncheck.feature')
    * karate.log(sessioncheck6.response.username)
    * assert sessioncheck6.responseStatus == respStatus
    * match sessioncheck6.response.username == usernamefore2e

    # Unregister User
    * def login = call read('classpath:tests/services/sessionunregister.feature')
    * karate.log(login.response)
    * assert test.responseStatus == respStatus

    # Confirm that session is blank
    * def sessioncheck4 = call read('classpath:tests/services/sessioncheck.feature')
    * karate.log(sessioncheck4.response)
    * assert test.responseStatus == respStatus
    * match sessioncheck.response == ''

    # Confirm that all reviews for the user are deleted properly
    * def test = call read('classpath:tests/services/reviewsbyuser.feature')
    * karate.log(test.response)
    * karate.log(test.response.length)
    * assert test.response.length == 0

    @smoke
    Examples:
    | smoke |



   