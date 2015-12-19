@isTest
private class LightningAccountEditSelectListItemTest {

    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * コンストラクタ
     */
    static testMethod void LightningAccountEditSelectListItemTest1() {

        System.runAs(testAdminUser) {

            Test.startTest();

            LightningAccountEditSelectListItem cls = new LightningAccountEditSelectListItem();

            Test.stopTest();

            System.assertEquals(cls.leadSourceMap.isEmpty(), true);
        }
    }

    /**
     * LeadSource選択リスト値取得
     */
    static testMethod void getLeadSourceMapTest1() {

        System.runAs(testAdminUser) {

            Test.startTest();

            LightningAccountEditSelectListItem cls = new LightningAccountEditSelectListItem();
            cls.leadSourceMap = cls.getLeadSourceMap();

            Test.stopTest();

            System.assertEquals(cls.leadSourceMap.isEmpty(), false);
        }
    }
}