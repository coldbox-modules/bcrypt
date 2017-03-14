component extends="coldbox.system.testing.BaseTestCase" {

    /**
    * @beforeAll
    **/
    function registerModuleUnderTest() {
        getController().getModuleService()
            .registerAndActivateModule( "cbox-bcrypt", "testingModuleRoot" );
    }

    /**
    * @beforeEach
    */
    function setupIntegrationTest() {
        setup();
    }

}