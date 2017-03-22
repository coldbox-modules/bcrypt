component {

	// Module Properties
	this.modelNamespace		= "bcrypt";
	this.cfmapping			= "bcrypt";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "cbjavaloader" ];

	function configure(){

		//Skip information vars if the box.json file has been removed
		if( fileExists( modulePath & '/box.json' ) ){
			//read in our box.json file for so we don't duplicate the information above
			var moduleInfo = deserializeJSON( fileRead( modulePath & '/box.json' ) );

			this.title 				= moduleInfo.name;
			this.author 			= moduleInfo.author;
			this.webURL 			= moduleInfo.homepage;
			this.description 		= moduleInfo.shortDescription;
			this.version			= moduleInfo.version;
			
		}

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