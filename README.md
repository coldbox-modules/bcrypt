coldbox-plugin-BCrypt
=====================

A ColdBox module for BCrypt.

You can ready more about BCrypt here:

http://en.wikipedia.org/wiki/Bcrypt

http://codahale.com/how-to-safely-store-a-password/

# BCrypt.jar
A compiled version (0.3) of jBCrypt is included in the models/lib directory.  You can update the version by following the steps below.

1. Download jBCrypt from http://www.mindrot.org/projects/jBCrypt/.
2. Compile BCrypt.java to a .class file named BCrypt.class.
3. Package BCrypt.class into a jar file named BCrypt.jar.

#Installing BCrypt.jar
By default, the module uses JavaLoader to load the jar in the /models/lib folder.  You can also place a jar file in your ColdFusion classpath and that jar will be given preference.  

##JavaLoader
1. This option is enabled by default
2. You may override the default module lib location by adding a settings.BCrypt.settings.libPath setting to your parent application.

##To the ColdFusion Classpath
1. Copy BCrypt.jar to a location on the ColdFusion classpath.  The easiest is {coldfusion-home}\lib\.
2. Restart ColdFusion Service.

#Installing BCrypt Module
Download the BCrypt module and place it in your modules folder.  Even easier, is isntall via CommandBox and this will also isntall the required JavaLoader module as well.  "install BCrypt"

The module is designed for ColdBox 4.0 applications and up.  It will automatically register a model called "BCrypt@BCrypt" that you inject via WireBox injection DSL:
property name="BCrypt" inject="BCrypt@BCrypt";
or via getModel() inside your handlers, views, interceptors, etc.
getModel( "BCrypt@BCrypt" )

#Using BCrypt Module

BCrypt is best used to hash passwords only.  It's too slow (the point) to use as a simple digest.  It's not reversible, so it's not suitable for encrypting transmission data.

##Generating a password hash
The hashed password should be persisted so candidate passwords (submitted from login) can be checked against.

    var hashedPassword = getModel( "BCrypt@BCrypt" ).hashPassword( plaintextPassword );
    
##Checking a password hash
The plaintextPasswordCandidate is the password the user submits for authentication.  The hashedPassword is retrieved for the user being authenticated.

    var isSamePassword = getModel( "BCrypt@BCrypt" ).checkPassword( plaintextPasswordCandidate, hashedPassword );

#Configuring WorkFactor
WorkFactor is an input to BCrypt that controls how long (generally) it takes to hash a password.  The module sets a default value of 12.  You should experiment to find the optimal value for your environment.  It should take as long as possible to hash a password without being burdensome to your users on login.  Half a second to a full second is generally a good target to shoot for.

You may override the default module lib location by adding a settings.BCrypt.settings.workFactor setting to your parent application.
You can also set the workFactor on a per-call basis by passing it in as a second parameter like so:

    var hashedPassword = getModel( "BCrypt@BCrypt" ).hashPassword( plaintextPassword, 7 );