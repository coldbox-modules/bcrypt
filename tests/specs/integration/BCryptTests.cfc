/**
* My BDD Test
*/
component extends="tests.resources.ModuleIntegrationSpec" appMapping="/app"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		super.afterAll();
	}

/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "BCrypt Module", function(){

			beforeEach(function( currentSpec ){
				BCrypt = getModel( "bcrypt@bcrypt" );
			});

			it( "Can load and hash", function(){
				setup();
				getRequestContext().setValue( "password", "coldbox" );

				var e = execute( event="main.index", renderResults=true );
				expect(	e.getRenderedContent() ).toInclude( '$' );
			});

			it( "can hash password and salt them", function(){
				// BCrypt salts the password each time before hashing it, resulting in a different hash value each time (the point of salting)
				expect( BCrypt.hashPassword('test') ).notToBe( BCrypt.hashPassword('test') );
			});

			it( "can check password equality", function(){
				// this is a BCrypt hash of "test" 
				var bCryptHashOfPasswordTest = '$2a$12$FE2J7ZLWaI2rSqejAu/84uLy7qlSufQsDsSE1lNNKyA05GG30gr8C';
				
				expect(	BCrypt.checkPassword( 'test', bCryptHashOfPasswordTest ) ).toBeTrue();
			});

			it( "can hash in fixed length strings", function(){
				expect(	len( BCrypt.hashPassword('test') ) ).toBe( 60, "Database storage expects a BCrypt hash to be a 60 character string" );
			});

			it( "can hash not too slow or not too fast", function(){
				var start = getTickCount();
				BCrypt.hashPassword( 'test' );
				var end = getTickCount();
				var executionDuration = end - start;
				debug( '#executionDuration# milliseconds' );
		
				// this might fail sometimes locally, we should judge it on a server though (aka the CI server)
				expect( executionDuration ).toBeLT( 750, "#executionDuration#ms - Password hashing must be faster than .75 seconds or it will impact the user experience on logging in too much." );
				expect( executionDuration ).toBeGT( 100, "#executionDuration#ms -Password hashing must be slower than .1 seconds or it will be too easy to brute force in an offline attack" );
			});

			it( "is singleton safe and will not leak with a reasonable number of concurrent iterations", function(){

				for( var i = 1; i <= 30; i++ ){

					var start = getTickCount();
					
					BCrypt.hashPassword( 'test' & i );
					
					var end = getTickCount();
					
					var executionDuration = end - start;
					
					// this might fail sometimes locally, we should judge it on a server though (aka the CI server)
					expect( executionDuration ).toBeLT( 750, "#executionDuration#ms - Password hashing must be faster than .75 seconds or it will impact the user experience on logging in too much." );
					expect( executionDuration ).toBeGT( 100, "#executionDuration#ms - Password hashing must be slower than .1 seconds or it will be too easy to brute force in an offline attack" );
				}

			});

		});
	}
	
}