component {

	// Module Properties
	this.title 				= "CryptBox";
	this.author 			= "Seth Feldkamp";
	this.webURL 			= "https://github.com/sfeldkamp/coldbox-plugin-BCrypt";
	this.description 		= "A ColdBox library for BCrypt for creating cryptographically strong (and slow) password hashes.";
	this.version			= "1.0.0";
	this.modelNamespace		= "BCrypt";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "cbjavaloader" ];

	function configure(){
		
		/*
		Defaults.  Overwride these in the parent app's /config/ColdBox.cfc like so:
  				
		settings = {
			BCrypt = {
				settings = {
					libPath = '/some/other/path',
					workFactor = 5
				}
			}
		};
		
		*/
		
  		settings = {
  			libPath = modulePath & "/models/lib",
  			// Must be greater than 4 and less than 31
  			workFactor = 12
  		};
	
		// Look for module setting overrides in parent app and override them.
		var coldBoxSettings = controller.getSettingStructure();
		if( structKeyExists( coldBoxSettings, 'BCrypt' ) 
			&& structKeyExists( coldBoxSettings[ 'BCrypt' ], 'settings' ) ) {
			structAppend( settings, coldBoxSettings[ 'BCrypt' ][ 'settings' ], true );
		}
		
	}
  		
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Class load antisamy
		controller.getWireBox().getInstance( "loader@cbjavaloader" ).appendPaths( settings.libPath );
	}

}