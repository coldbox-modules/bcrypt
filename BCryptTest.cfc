component extends="common.coldbox.system.testing.BasePluginTest" plugin="common.plugins.BCrypt" {
	
	function beforeTests(){
		
	}
	function setup(){
		super.setup();
		BCrypt = Plugin;
		
		mockControllerWithJavaLoader_libPathSetting();
				
		BCrypt.init(mockController);
	}
	function tearDown(){
		deleteJavaLoaderFromScope();
	}
	function afterTests(){
		
	}
	
	function testLoadsBCryptFromClassPath(){
		mockControllerWithOutJavaLoader_libPathSetting();
		BCrypt.$("tryToLoadBCryptFromClassPath");
		BCrypt.init(mockController);
		
		assert(BCrypt.$once('tryToLoadBCryptFromClassPath'));
	}
	
	function testLoadsBCryptFromJavaLoader_libPath(){
		mockControllerWithJavaLoader_libPathSetting();
		BCrypt.$("isBCryptLoaded").$results(false,true);
		BCrypt.$("tryToLoadBCryptWithJavaLoader");
		BCrypt.init(mockController);
		
		assert(BCrypt.$once('tryToLoadBCryptWithJavaLoader'));
	}
	
	function testBCryptExceptionWhenNotLoaded(){
		mockControllerWithJavaLoader_libPathSetting();
		BCrypt.$("isBCryptLoaded").$results(false,false);
		expectException("any");
		BCrypt.init(mockController);
	}
	
	function testHashIsFixedLengthString(){
		assertTrue(len(BCrypt.hashPassword('test')) eq 60, "Database storage expects a BCrypt hash to be a 60 character string");
	}
	
	function testHashIsNotTooSlowNotTooFast(){
		var start = getTickCount();
		BCrypt.hashPassword('test');
		var end = getTickCount();
		var executionDuration = end - start;
		debug('#executionDuration# milliseconds');
		
		// this might fail sometimes locally, we should judge it on a server though (aka the CI server)
		assertTrue(executionDuration lt 750, "Password hashing must be faster than .75 seconds or it will impact the user experience on logging in too much.");
		
		assertTrue(executionDuration gt 100, "Password hashing must be slower than .1 seconds or it will be too easy to brute force in an offline attack");
	}
	
	function testPasswordSaltedOnEachHash(){
		// BCrypt salts the password each time before hashing it, resulting in a different hash value each time (the point of salting)
		assertTrue(BCrypt.hashPassword('test') neq BCrypt.hashPassword('test'));
	}
	
	function testCheckPassword(){
		// this is a BCrypt hash of "test" 
		var bCryptHashOfPasswordTest = '$2a$12$FE2J7ZLWaI2rSqejAu/84uLy7qlSufQsDsSE1lNNKyA05GG30gr8C';
		
		assertTrue(BCrypt.checkPassword('test', bCryptHashOfPasswordTest));
	}
	
	private function mockControllerWithJavaLoader_LibPathSetting(){
		mockController.$("getAppHash").$results(hash(now()));
		mockController.$("settingExists").$results("true");
		mockController.$("getSetting").$results(expandPath("/common/java"));
		mockController.$("getPlugin").$results(
			createObject("component","coldbox.system.plugins.JavaLoader").init(mockController)
		);
	}
	
	private function mockControllerWithoutJavaLoader_LibPathSetting(){
		mockController.$("getAppHash").$results(hash(now()));
		mockController.$("settingExists").$results("false");
		mockController.$("getPlugin").$results(
			createObject("component","coldbox.system.plugins.JavaLoader").init(mockController)
		);
	}
	
	private void function deleteJavaLoaderFromScope(){
		structDelete(server, mockController.getPlugin("JavaLoader").getStaticIDKey());
	}
}