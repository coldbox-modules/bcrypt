/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * ---
 * Hashes and passwords and checks password hashes using BCrypt.jar
 */
component singleton threadsafe {

	// DI
	property name="javaLoader" inject="loader@cbjavaloader";
	property name="settings"   inject="box:modulesettings:bcrypt";

	/**
	 * Constructor
	 */
	BCrypt function init(){
		return this;
	}

	/**
	 * On DI Complete load library
	 */
	function onDIComplete(){
		loadBCrypt();
	}

	/**
	 * Hashes an incoming input string according to work factor and salt
	 *
	 * @password   The input password to encrypt
	 * @workFactor Optional work factor
	 *
	 * @return The bcrypted password
	 */
	string function hashPassword(
		required string password,
		workFactor = variables.settings.workFactor,
		salt       = generateSalt( arguments.workFactor )
	){
		return variables.bcrypt.hashpw( arguments.password, arguments.salt );
	}

	/**
	 * Check if the incoming candidate is the same as a bcrypthash, usually the best check for comparing them.
	 *
	 * @candidate  The plain text string to compare against the encrypted hash
	 * @bCryptHash The bCrypt hash to compare it to
	 *
	 * @return True - if the match, false if they dont!
	 */
	boolean function checkPassword( required string candidate, required string bCryptHash ){
		return variables.bcrypt.checkpw( arguments.candidate, arguments.bCryptHash );
	}

	/**
	 * Generates a salt for you.
	 *
	 * @workFactor The workfactor to use for the salt, by default we use the one in the settings
	 */
	string function generateSalt( workFactor = variables.settings.workFactor ){
		return variables.bcrypt.genSalt( javacast( "int", arguments.workFactor ) );
	}

	/**
	 * Load the library
	 *
	 * @throws ClassNotFoundException - When bcrypt can't be classloaded
	 */
	private void function loadBCrypt(){
		tryToLoadBCryptFromClassPath();

		if ( !isBCryptLoaded() ) {
			tryToLoadBCryptWithJavaLoader();
		}

		if ( !isBCryptLoaded() ) {
			throw(
				type   : "ClassNotFoundException",
				message: "BCrypt not successfully loaded.  BCrypt.jar must be present in the ColdFusion classpath or at the setting javaloader_libpath.  No operations are available."
			);
		}
	}

	/**
	 * Try to load if java lib in CF Path
	 */
	private void function tryToLoadBCryptFromClassPath(){
		try {
			variables.bcrypt = createObject( "java", "org.mindrot.jbcrypt.BCrypt" );
		} catch ( any error ) {
		}
	}

	/**
	 * Load via module
	 */
	private void function tryToLoadBCryptWithJavaLoader(){
		try {
			variables.bcrypt = variables.javaLoader.create( "org.mindrot.jbcrypt.BCrypt" );
		} catch ( any error ) {
		}
	}

	/**
	 * Is BCrypt loaded
	 */
	private boolean function isBCryptLoaded(){
		return !isNull( variables.bcrypt );
	}

}
