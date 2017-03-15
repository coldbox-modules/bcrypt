# BCrypt Module for the Coldbox Framework [![Build Status](https://travis-ci.org/coldbox-modules/cbox-bcrypt.svg?branch=master)](https://travis-ci.org/coldbox-modules/cbox-bcrypt)

BCrypt's primary usage would be for the secure hashing of passwords.  The hashing method provides a high level of security, but also makes it too slow use as a simple digest. It is also not reversible, and therefore is not suitable for encrypting transmission data.


More information about BCrypt:

* http://en.wikipedia.org/wiki/Bcrypt
* http://bcrypt.sourceforge.net/

## Installation

Install the module via [Commandbox](https://www.ortussolutions.com/products/commandbox), which will ensure all dependencies are installed as well:

```bash
box install bcrypt
```

## Requirements

* ColdBox Framework 4.0+
* cbjavaloader module ( automatically installed as a dependency by Forgebox )  

## BCrypt.jar
A compiled version (0.3) of jBCrypt is included in the `models/lib` directory.  You can update the version by following the steps below.

1. Download jBCrypt from http://www.mindrot.org/projects/jBCrypt/.
2. Compile `BCrypt.java` to a `.class` file named `BCrypt.class`.
3. Package `BCrypt.class` into a jar file named `BCrypt.jar`.


## Usage


### BCrypt WireBox Mapping

This module registers a wirebox mapping to the Bcrypt singleton, `BCrypt@BCrypt`, which you may inject or instantiate in your componets:

```js
property name="BCrypt" inject="BCrypt@BCrypt";
```

or via `getInstance()` ( a ColdBox framework supertype method ) inside your handlers, views, interceptors, etc.

```js
getInstance( "BCrypt@BCrypt" )
```

### Generating a password hash

The hashed password should be persisted so candidate passwords (submitted from login) can be checked against.

```js
var hashedPassword = getInstance( "BCrypt@BCrypt" ).hashPassword( plaintextPassword );
```
    
### Checking a password hash

The `plaintextPasswordCandidate` is the password the user submits for authentication.  The hashed password is retrieved for the user being authenticated.

```js
var isSamePassword = getInstance( "BCrypt@BCrypt" ).checkPassword( plaintextPasswordCandidate, hashedPassword );
```

### Configuring WorkFactor

`WorkFactor` is an input to BCrypt that controls how long (generally) it takes to hash a password.  The module sets a default value of `12`.  You should experiment to find the optimal value for your environment.  It should take as long as possible to hash a password without being burdensome to your users on login.  Half a second to a full second is generally a good target to shoot for.

You can also set the workFactor on a per-call basis by passing it in as a second parameter to the `hashPassword` method like so:

```js
var hashedPassword = getInstance( "BCrypt@BCrypt" ).hashPassword( plaintextPassword, 7 );
```

### BCrypt Settings

You may override the default work factor by creating a `BCrypt` settings struct in your `ColdBox.cfc`:


```js
BCrypt = {
    workFactor = 12
};
```

You can read more about this module here: https://github.com/coldbox-modules/cbox-bcrypt/wiki



********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
####HONOR GOES TO GOD ABOVE ALL
Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

###THE DAILY BREAD
 > "I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

