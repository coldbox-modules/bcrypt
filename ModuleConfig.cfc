/**
 * Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * ---
 * Module Configuration
 */
component {

	// Module Properties
	this.title             = "bcrypt";
	this.author            = "Ortus Solutions, Corp";
	this.webURL            = "https://www.ortussolutions.com";
	this.description       = "This module provides a way to do bcrypt encryption in ColdBox apps";
	this.modelNamespace    = "bcrypt";
	this.cfmapping         = "bcrypt";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies      = [ "cbjavaloader" ];
	// Helpers
	this.applicationHelper = [ "helpers/mixins.cfm" ];

	/**
	 * Module Config
	 */
	function configure(){
		// Module Settings
		settings = { libPath : modulePath & "/models/lib", workFactor : 12 };
	}

	/**
	 * Fired when the module is registered and activated.
	 */
	function onLoad(){
		// Class load bcrypt
		wireBox.getInstance( "loader@cbjavaloader" ).appendPaths( settings.libPath );
	}

}
