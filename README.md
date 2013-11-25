coldbox-plugin-BCrypt
=====================

A ColdBox plugin for BCrypt.

You can ready more about BCrypt here:

http://en.wikipedia.org/wiki/Bcrypt

http://codahale.com/how-to-safely-store-a-password/

# Getting BCrypt.jar
This plugin depends on a BCrypt.jar file which is not packaged with this plugin.

1. Download jBCrypt from http://www.mindrot.org/projects/jBCrypt/.
2. Compile BCrypt.java to a .class file named BCrypt.class.
3. Package BCrypt.class into a jar file named BCrypt.jar.

#Installing BCrypt.jar
The plugin can load BCrypt.jar from either the ColdFusion classpath or from another location (in your application).  Either location will work but the plugin checks in the classpath first.

##To the ColdFusion Classpath
1. Copy BCrypt.jar to a location on the ColdFusion classpath.  The easiest is {coldfusion-home}\lib\.
2. Restart ColdFusion Service.

##To a Location in you ColdBox application
1. Copy BCrypt.jar to the location you prefer.
2. Add a ColdBox setting named "javaloader_libpath" with a value of an absolute path to the folder where you copied the jar.

#Installing BCrypt Plugin
Download BCrypt.cfc and save to your ColdBox application custom plugins location.  By default that is {app}/plugins.

#Using BCrypt Plugin

BCrypt is best used to hash passwords only.  It's too slow (the point) to use as a simple digest.  It's not reversible, so it's not suitable for encrypting transmission data.

##Generating a password hash
The hashed password should be persisted so candidate passwords (submitted from login) can be checked against.

    var hashedPassword = getMyPlugin('BCrypt').hashPassword(plaintextPassword);
    
##Checking a password hash
The plaintextPasswordCandidate is the password the user submits for authentication.  The hashedPassword is retrieved for the user being authenticated.

    var isSamePassword = getMyPlugin('BCrypt').checkPassword(plaintextPasswordCandidate, hashedPassword);

#Configuring WorkFactor
WorkFactor is an input to BCrypt that controls how long (generally) it takes to hash a password.  The plugin sets a default value of 12.  You should experiment to find the optimal value for your environment.  It should take as long as possible to hash a password without being burdensome to your users on login.  Half a second to a full second is generally a good target to shoot for.
