Feature: sample karate test script
  for help, see: https://github.com/karatelabs/karate/wiki/IDE-Support

  Background:
    * def smoke = read('classpath:tests/CSVfiles/allusers/smoke.csv')
    * def smoke2 = read('classpath:tests/CSVfiles/usersbyname/smoke.csv')
    * def negative2 = read('classpath:tests/CSVfiles/usersbyname/negative.csv')
    * def smoke3 = read('classpath:tests/CSVfiles/usersbyid/smoke.csv')
    * def negative3 = read('classpath:tests/CSVfiles/usersbyid/negative.csv')
    * def smoke4 = read('classpath:tests/CSVfiles/useravailable/smoke.csv')
	* def DbUtils = Java.type('util.DBUtils')
	* def db = new DbUtils(dbconfig)

# Get a list of all users
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/allusers.feature')
    * karate.log(test.response[0].profileid)
    * def users = db.readRows('SELECT * FROM userprofiles WHERE profileid IN (' + test.response[0].profileid + ',' + test.response[1].profileid + ',' + test.response[2].profileid + ')')
    * karate.log(users.length)
    * assert users.length == 3
    * assert test.responseStatus == respStatus
    

    @smoke
    Examples:
    | smoke |

    # Get a specific user by name
    Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/userbyname.feature')
    * karate.log(test.response)
    * def user = db.readRows('SELECT * FROM userprofiles WHERE profileid = "' + test.response + '"')
    * karate.log(user)
    * assert test.responseStatus == respStatus
    * assert test.response == user[0].profileid

    @smoke
    Examples:
    | smoke2 |

        # Get a specific user by name NEGATIVE
      Scenario Outline: '<Scenario>'
        * print 'test'
        * def test = call read('classpath:tests/services/userbyname.feature')
        * assert test.responseStatus == respStatus
        * karate.log(test.response.error)
        * karate.log(error)
        * assert test.response.error == error
        * assert test.response.message == message

    @negative
    Examples:
    | negative2 |

    # Get a specific username by id
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/userbyid.feature')
    * karate.log(test.response)
    * def user = db.readRows('SELECT * FROM userprofiles WHERE profileid = "' + textuid + '"')
    * karate.log(user)
    * assert test.responseStatus == respStatus
    * assert test.response.uname == user[0].username

    @smoke
    Examples:
    | smoke3 |

    # Get a specific username by id NEGATIVE
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/userbyid.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
        * karate.log(test.response.error)
        * karate.log(error)
        * assert test.response.error == error
        * karate.log(test.response.message)
        * karate.log(message)
        * assert test.response.message == message

    @negative
    Examples:
    | negative3 |

        # Verify username availabilty check is functioning as expected
  Scenario Outline: '<Scenario>'
    * print 'test'
    * def test = call read('classpath:tests/services/useravailable.feature')
    * karate.log(test.response)
    * assert test.responseStatus == respStatus
    * assert test.response == returned
    @smoke
    Examples:
    | smoke4 |