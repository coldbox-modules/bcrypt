# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

----

## [3.1.0] => 2022-SEP-06

### Added

* Compatibility with ColdBox and CommandBox modules
* New module template updates
* Github actions build process


----

## [3.0.1] => 2020-NOV-25

### Fixed

* @wpdebruin <wil@site4u.nl> - enabled `workfactor` to be used in `hashPassword()`

----

## [3.0.0] => 2020-NOV-1

### Added

* Added three new helper mixins for easy usage : `bcryptHash(), bcryptCheck(), bcryptSalt()`
* New method to generate bcrypt salts: `generateSalt( workFactor = default ): bcryptSalt()`
* Ability to pass in a custom `salt` argument via the `hashPassword( input, workFactor, salt )` method
* `compatiblity` : New `moduleSettings` configuration as per ColdBox 5+ instead of parsing parent settings
* Updated to newest module layout
* Lots of docs for methods
* Upgraded tests to ColdBox 6+

### Fixed

* Upgraded to cbJavaloader 2.x due to security issues in 1.x

### Removed

* ACF11 Support
* Lucee 4.5 Support

----

## [2.5.0] => 2017-MAR-22

* Updated BCrypt library to v0.4
* Fixes a memory leak when performing over 10 concurrent hashes
* Module test harness updates

----

## [2.1.0] => 2016-MAY-04

* Updated Docs
* Fixed javacast issue when passing a work factor
* Updated JavaLoader dependencies
* Added Java source for references and future inline build compilation
* Updated settings to match ColdBox module standards
* Added full test suites
* Added Travis integration
* Added git ignores and attributes
