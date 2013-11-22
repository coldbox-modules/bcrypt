component displayname="BCrypt" extends="coldbox.system.plugin" hint="hashes and passwords and checks password hashes using BCrypt.jar" {
	
	public BCrypt function init(required Controller, workFactor = 12){
		super.init(arguments.Controller);
		setWorkFactor(arguments.workFactor);
		loadBCrypt();
		
		// Plugin Properties
		setpluginName("BCrypt");
		setpluginVersion("1.0");
		setpluginDescription("BCrypt plugin.  Requires BCrypt.jar and proxies it for ColdBox applications.");
		setpluginAuthor("Seth Feldkamp");
		setpluginAuthorURL("");
		
		return this;
	}
	
	public string function hashPassword(required string password){
		return getBCrypt().hashpw(password, getBCrypt().genSalt(workFactor));
	}
	
	public boolean function checkPassword(required string candidate, required string bCryptHash){
		return getBCrypt().checkpw(candidate, bCryptHash);
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
			setBCrypt(getJavaLoader().create("BCrypt"));
		}
		catch(any error){
			
		}
	}

	private any function getJavaLoader(){
		return getPlugin("JavaLoader");
	}
	
	private void function setWorkFactor(required numeric workFactor){
		variables.workFactor = arguments.workFactor;
	}
	private numeric function getWorkFactor(){
		return variables.workFactor;
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