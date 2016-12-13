demo_secrets
============

Shhhhh....

# MODEL TESETING

[Pramod Jacob](https://github.com/domarp-j)
[Luke Schleicher](https://github.com/luke-schleicher)

## User

* Happy Paths

  * Have a secure password
  * Can have secrets
  * Have a name
  * Have an email
  * Have a name with length between 3 and 20
  * Have a unique email
  * Have a password with length between 6 and 16
  * How to test allow_nil? (update test)

* Sad Paths
  * Can't sign up without name or email
  * Can't sign up with name less than 3 or greater than 20 characters
  * Can't sign up with an email that previous user used
  * Can't have a password less than 6 or greater than 16

* Bad Paths
  * Trying to delete another user when logged in? (more a controller thing)


## Secret

* Happy Paths
  * has an associated author
  * has a title, body and author
  * has a title of appropriate length
  * has a body of appropriate length
  * last_five class method returns 5 or fewer entries
  * last_five secrets are returned in descending order by id

* Sad Paths
  * Can't create secret without title, body or author
  * Can't submit secret if title is too short or long
  * Can't submit secret if body is too short or long
  * last_five doesn't return more than 5 entries
  * last_five secrets aren't in ascending order by id

# INTEGRATION TESTING

[Pramod Jacob](github.com/domarp-j)
[Catherine Kwak](github.com/khopsickle)
