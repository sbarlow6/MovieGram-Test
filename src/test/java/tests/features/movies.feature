Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * def smoke = read('classpath:tests/CSVfiles/moviesearch/smoke.csv')
    * def smoke2 = read('classpath:tests/CSVfiles/movieposter/smoke.csv')
    * def negative = read('classpath:tests/CSVfiles/moviesearch/negative.csv')
    * def negative2 = read('classpath:tests/CSVfiles/movieposter/negative.csv')


	* def DbUtils = Java.type('util.DBUtils')
	* def db = new DbUtils(dbconfig)

# Search for a movie
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/moviesearch.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * match test.response.imdbID == imdbID

    @smoke
    Examples:
    | smoke |

    @negative
    Examples:
    | negative |

  # Search for a movie Poster
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/movieposter.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * assert test.response.imdbID == imdbID
    * assert test.response.Poster == moviePoster

    @smoke
    Examples:
    | smoke2 |

  # Search for a movie Poster Negative Scenarios
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/movieposter.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * karate.log(test.response.error)
    * karate.log(error)
    * assert test.response.error == error
    * assert test.response.message == message

    @negative
    Examples:
    | negative2 |
   