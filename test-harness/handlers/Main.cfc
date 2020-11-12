component{

	property name="bcrypt" inject="@bcrypt";

	function index( event, rc, prc ){
		return {
			"hash"        : bcrypt.hashPassword( rc.input ?: "test" ),
			"salt"        : bcrypt.generateSalt(),
			"mixin-hash"  : bcryptHash( rc.input ?: "test" ),
			"mixin-salt"  : bcryptSalt( 12 ),
			"mixin-check" : bcryptCheck( "test", bcryptHash( rc.input ?: "test" ) )
		};
	}

}