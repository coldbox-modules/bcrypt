component {

	// Module Properties
	this.title 				= "coldbox-bcrypt";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://github.com/coldbox-modules/cbox-bcrypt";
	this.description 		= "A ColdBox module for BCrypt. Creates cryptographically strong (and slow) password hashes.";
	this.version			= "2.5.0";
	this.modelNamespace		= "bcrypt";
	this.cfmapping			= "bcrypt";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "cbjavaloader" ];

	function configure(){
		// Module Settings		
  		settings = {
  			libPath = modulePath & "/models/lib"
  		};
	}
  		
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// parse parent settings
		parseParentSettings();
		// Class load antisamy
		wireBox.getInstance( "loader@cbjavaloader" )
			.appendPaths( settings.libPath );
	}

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var bcryptDSL 		= oConfig.getPropertyMixin( "bCrypt", "variables", structnew() );

		//defaults
		configStruct.bCrypt = {
			workFactor = 12
		};

		// incorporate settings
		structAppend( configStruct.bCrypt, bcryptDSL, true );
	}

}