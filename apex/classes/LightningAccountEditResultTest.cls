@isTest
private class LightningAccountEditResultTest {

    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * コンストラクタ
     */
    static testMethod void LightningAccountEditResultTest1() {

        System.runAs(testAdminUser) {

            Test.startTest();

            LightningAccountEditResult cls = new LightningAccountEditResult();

            Test.stopTest();

            System.assertEquals(String.isEmpty(cls.accountId), true);
            System.assertEquals(cls.errorMessages.isEmpty(), true);
        }
    }
}