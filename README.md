# BCrypt Module for the ColdBox Framework [![Build Status](https://travis-ci.com/coldbox-modules/bcrypt.svg?branch=development)](https://travis-ci.com/coldbox-modules/bcrypt)

BCrypt's primary usage would be for the secure hashing of passwords.  The hashing method provides a high level of security, but also makes it too slow use as a simple digest. It is also not reversible, and therefore is not suitable for encrypting transmission data.

More information about BCrypt:

* http://en.wikipedia.org/wiki/Bcrypt
* http://bcrypt.sourceforge.net/
* http://www.mindrot.org/projects/jBCrypt/

## Installation

Install the module via [Commandbox](https://www.ortussolutions.com/products/commandbox), which will ensure all dependencies are installed as well:

```bash
box install bcrypt
```

## Requirements

* ColdBox Framework 5.0+
* `cbjavaloader` module ( automatically installed as a dependency by Forgebox )

## BCrypt.jar

A compiled version (0.4) of **jBCrypt** is listed as a dependency for the test harness.  You can update the version by following the steps below.

1. Visit http://www.mindrot.org/projects/jBCrypt/.
2. Copy the link to the latest version
3. Update the `test-harness/box.json` dependency with the correct version information
4. Run `box install` from within the `test-harness` directory
5. Execute `ant -f test-harness/resources/jBCrypt-[version number]/build.xml` and move the generated `jbcrypt.jar` file to `models/lib`

## Usage


### BCrypt WireBox Mapping

This module registers a wirebox mapping to the Bcrypt singleton, `BCrypt@BCrypt`, which you may inject or instantiate in your componets:

```js
// Long Format
property name="BCrypt" inject="BCrypt@BCrypt";

// Module Alias Shortcut
property name="BCrypt" inject="@BCrypt";
```

or via `getInstance()` ( a ColdBox framework supertype method ) inside your handlers, views, interceptors, etc.

```js
getInstance( "BCrypt@BCrypt" )
getInstance( "@BCrypt" )
```

### BCrypt Mixins

We have also created three mixin helpers that will be injected to all your handlers, interceptors, layouts and views: `bcryptHash(), bcryptCheck(), bcryptSalt()`

```js
/**
 * Hashes an incoming input string according to work factor and salt
 *
 * @password The input password to encrypt
 * @workFactor Optional work factor
 *
 * @return The bcrypted password
 */
string function bcryptHash(
	required string password,
	workFactor,
	salt
)

/**
 * Check if the incoming candidate is the same as a bcrypthash, usually the best check for comparing them.
 *
 * @candidate The plain text string to compare against the encrypted hash
 * @bCryptHash The bCrypt hash to compare it to
 *
 * @return True - if the match, false if they dont!
 */
boolean function bcryptCheck( required string candidate, required string bCryptHash )

/**
 * Generates a salt for you.
 *
 * @workFactor The workfactor to use for the salt, by default we use the one in the settings
 */
string function bcryptSalt( workFactor )
```

### Generating a password hash

The hashed password should be persisted so candidate passwords (submitted from login) can be checked against.

```js
var hashedPassword = getInstance( "BCrypt" ).hashPassword( plaintextPassword );
```

### Checking a password hash

The `plaintextPasswordCandidate` is the password the user submits for authentication.  The hashed password is retrieved for the user being authenticated.

```js
var isSamePassword = getInstance( "BCrypt" ).checkPassword( plaintextPasswordCandidate, hashedPassword );
```

### Using a Custom Salt

Internally we generate a `salt` for you according to the default work factor.  You can however, alter this and pass in your own salt:

```js
var hashedPassword = getInstance( "BCrypt" ).hashPassword( 
	password : plaintextPassword,
	salt : mySalt
);
```

### Configuring WorkFactor

`WorkFactor` is an input to BCrypt that controls how long (generally) it takes to hash a password.  The module sets a default value of `12`.  You should experiment to find the optimal value for your environment.  It should take as long as possible to hash a password without being burdensome to your users on login.  Half a second to a full second is generally a good target to shoot for.

You can also set the workFactor on a per-call basis by passing it in as a second parameter to the `hashPassword` method like so:

```js
var hashedPassword = getInstance( "@BCrypt" ).hashPassword( plaintextPassword, 7 );
```

### BCrypt Settings

You may override the default work factor by creating a `BCrypt` settings struct in your `ColdBox.cfc` under the `moduleSettings` struct:


```js
moduleSettings = {
	bcrypt = {
		workFactor = 15
	}
};
```

********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

#### HONOR GOES TO GOD ABOVE ALL

Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

>"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

### THE DAILY BREAD

>"I am the way, and the truth, and the life; no one comes to the Father, but by me (JESUS)" Jn 14:1-12

