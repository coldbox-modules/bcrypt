/**
* My BDD Test
*/
component extends="coldbox.system.testing.BaseTestCase" appMapping="/root"{
	
/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();

		variables.passwordTestString = "F}766dVr7XzdEa2<>!%&^%$##@!)( * )/|\"
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

			it( "Hashes and salts a password", function(){
				// BCrypt salts the password each time before hashing it, resulting in a different hash value each time (the point of salting)
				expect( BCrypt.hashPassword( variables.passwordTestString ) ).notToBe( BCrypt.hashPassword( variables.passwordTestString ) );
			});

			it( "Demonstrates the ability to verify password equality", function(){
				// this is a BCrypt hash of our password test string
				var bCryptHashOfPasswordTest = '$2a$12$whxAYoS9Myu3dXokd/mlPOke6lJGlMA87kkCjK7v2bg9Pdcw/So1q';
				
				expect(	BCrypt.checkPassword( variables.passwordTestString, bCryptHashOfPasswordTest ) ).toBeTrue();
			});

			it( "Will produce a fixed length string", function(){
				expect(	len( BCrypt.hashPassword( variables.passwordTestString ) ) ).toBe( 60, "Database storage expects a BCrypt hash to be a 60 character string" );
			});

			it( "Performs at a consistent high/low speed threshold", function(){
				var start = getTickCount();
				BCrypt.hashPassword( variables.passwordTestString );
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
						
					//we're using a new instance each time in this loop to ensure singleton scope
					getModel( "bcrypt@bcrypt" ).hashPassword( variables.passwordTestString & i );
					
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