component displayname="BCrypt" hint="hashes and passwords and checks password hashes using BCrypt.jar" singleton {
	property name="javaLoader" inject="loader@cbjavaloader";
	property name="workFactor" inject="coldbox:setting:workFactor@BCrypt";
	
	public BCrypt function init(){
		return this;
	}
	
	public function onDIComplete(){
		loadBCrypt();
	}
	
	public string function hashPassword( required string password, workFactor=variables.workFactor ){
		// TODO, add Java Cast Here
		var salt = getBCrypt().genSalt( javaCast( "int", arguments.workFactor ) );
		return getBCrypt().hashpw( password, salt );
	}
	
	public boolean function checkPassword(required string candidate, required string bCryptHash){
		return getBCrypt().checkpw( candidate, bCryptHash );
	}
	
	
	private void function loadBCrypt(){
		tryToLoadBCryptFromClassPath();
		
		if(NOT isBCryptLoaded()){
			tryToLoadBCryptWithJavaLoader();
		}
		
		if(NOT isBCryptLoaded()){
			throw("BCrypt not successfully loaded.  BCrypt.jar must be present in the ColdFusion classpath or at the setting javaloader_libpath.  No operations are available.");
		}
	}
	private void function tryToLoadBCryptFromClassPath(){
		try{
			setBCrypt(createObject("java","BCrypt"));
		}
		catch(any error){
			
		}
	}
	private void function tryToLoadBCryptWithJavaLoader(){
		try{
			setBCrypt( javaLoader.create( "BCrypt" ) );
		}
		catch(any error){
			
		}
	}

	private void function setBCrypt(required BCrypt){
		variables.BCrypt = arguments.BCrypt;
	}
	private any function getBCrypt(){
		return variables.BCrypt;
	}
	private boolean function isBCryptLoaded(){
		return structKeyExists(variables, "BCrypt");
	}
}