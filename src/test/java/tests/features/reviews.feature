Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * def smoke = read('classpath:tests/CSVfiles/reviewsbyone/smoke.csv')
    * def negative = read('classpath:tests/CSVfiles/reviewsbyone/negative.csv')
    * def smoke2 = read('classpath:tests/CSVfiles/reviewsforhome/smoke.csv')
    * def smoke3 = read('classpath:tests/CSVfiles/reviewsbymovie/smoke.csv')
    * def negative3 = read('classpath:tests/CSVfiles/reviewsbymovie/negative.csv')
    * def smoke4 = read('classpath:tests/CSVfiles/reviewsbyuser/smoke.csv')
    * def negative4 = read('classpath:tests/CSVfiles/reviewsbyuser/negative.csv')
    * def smoke5 = read('classpath:tests/CSVfiles/allusers/smoke.csv')
	* def DbUtils = Java.type('util.DBUtils')
	* def db = new DbUtils(dbconfig)

  # Get data for a single review 
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbyone.feature')
    * karate.log(test.response)
    * def reviews = db.readRows('SELECT * FROM reviews')
    * karate.log(reviews[0].revid)
    * def queriedrevid = revid
    * assert test.responseStatus == respStatus
    * assert test.response.revid == queriedrevid
    

    @smoke
    Examples:
    | smoke |

  # Get data for a single review NEGATIVE
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbyone.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * karate.log(test.response.error)
    * karate.log(error)
    * match test.response.error == error
    * match test.response.message == message

    @negative
    Examples:
    | negative |


  # Get a list of all reviews
  Scenario Outline: '<Scenario>'
    * print 'test'
    * karate.log(baseUrl)
    * def test = call read('classpath:tests/services/reviewsforhome.feature')
    * karate.log(test.response)
    * def reviews = db.readRows('SELECT * FROM reviews WHERE revid = ' + test.response[0].revid)
    * karate.log(reviews)
    * karate.log(reviews[0].movieid)
    * karate.log(test.response[0].movieid)
    * assert reviews[0].movieid == test.response[0].movieid
    * assert test.responseStatus == respStatus
    

    @smoke
    Examples:
    | smoke2 |

    

    # Get a list of all reviews for a particular movie
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbymovie.feature')
    * karate.log(test.response)
    * def reviews = db.readRows('SELECT * FROM reviews WHERE movieid = "' + imdbid + '"')
    * assert reviews[0].movieid == test.response[0].movieid
    * assert test.responseStatus == respStatus
    

    @smoke
    Examples:
    | smoke3 |
# Get a list of all reviews for a particular movie NEGATIVE
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbymovie.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * karate.log(test.response.error)
    * karate.log(error)
    * match test.response.error == error
    * match test.response.message == message
    

    @negative
    Examples:
    | negative3 |

# Get a list of all reviews for a particular user
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbyuser.feature')
    * karate.log(test.response[0].revid)
    * def reviews = db.readRows('SELECT * FROM reviews WHERE revid IN (' + test.response[0].revid + ',' + test.response[1].revid + ',' + test.response[2].revid + ')')
    * karate.log(reviews.length)
    * assert reviews.length == 3
    * assert test.responseStatus == respStatus
    

    @smoke
    Examples:
    | smoke4 |

  # Get a list of all reviews for a particular user NEGATIVE
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/reviewsbyuser.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * karate.log(test.response.error)
    * karate.log(error)
    * match test.response.error == error
    * match test.response.message == message
    
    

    @negative
    Examples:
    | negative4 |

