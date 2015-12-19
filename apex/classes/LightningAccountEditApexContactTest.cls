@isTest
private class LightningAccountEditApexContactTest {

    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * コンストラクタ
     */
    static testMethod void LightningAccountEditApexContactTest1() {
        
        System.runAs(testAdminUser) {

            Test.startTest();
            
            LightningAccountEditApexContact cls = new LightningAccountEditApexContact();
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(cls.contact.Id), true);
            System.assertEquals(cls.isChanged, false);
        }
    }
}