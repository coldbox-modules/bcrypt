<cfscript>
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
	){
		return getInstance( "@bcrypt" ).hashPassword( argumentCollection=arguments );
	}

	/**
	 * Check if the incoming candidate is the same as a bcrypthash, usually the best check for comparing them.
	 *
	 * @candidate The plain text string to compare against the encrypted hash
	 * @bCryptHash The bCrypt hash to compare it to
	 *
	 * @return True - if the match, false if they dont!
	 */
	boolean function bcryptCheck( required string candidate, required string bCryptHash ){
		return getInstance( "@bcrypt" ).checkPassword( argumentCollection=arguments );
	}

	/**
	 * Generates a salt for you.
	 *
	 * @workFactor The workfactor to use for the salt, by default we use the one in the settings
	 */
	string function bcryptSalt( workFactor ){
		return getInstance( "@bcrypt" ).generateSalt( argumentCollection=arguments );
	}

</cfscript>