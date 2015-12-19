@isTest
private class LightningAccountEditTesterTest {

    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * テスト実行ユーザ取得
     */
    static testMethod void getLoginUserTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            User result = LightningAccountEditTester.getLoginUser();
            System.assertEquals(result.Id, UserInfo.getUserId());
            
            Test.stopTest();
        }
    }

    /**
     * テスト実行ページ取得
     */
    static testMethod void getPageReferenceTest() {
        
        System.runAs(testAdminUser) {
            Test.startTest();
            
            PageReference result = LightningAccountEditTester.getPageReference();
            System.assertEquals(result.getUrl(), new PageReference('PageReference').getUrl());
            
            Test.stopTest();
        }
    }
    
    /**
     * 取引先
     */
    static testMethod void createAccountTest() {

        System.runAs(testAdminUser) {
            Test.startTest();
            
            // Insertなし
            Account account = LightningAccountEditTester.createAccount(false);
            System.assertEquals(String.isEmpty(account.Id), true);
            
            // Insertあり
            account = LightningAccountEditTester.createAccount(true);
            System.assertEquals(String.isNotEmpty(account.Id), true);
            
            Test.stopTest();
        }
    }

    /**
     * 取引先責任者
     */
    static testMethod void createContactTest() {

        System.runAs(testAdminUser) {
            Account account = LightningAccountEditTester.createAccount(true);
            
            Test.startTest();
            
            // Insertなし
            Contact contact = LightningAccountEditTester.createContact(account, false);
            System.assertEquals(String.isEmpty(contact.Id), true);
            
            // Insertあり
            contact = LightningAccountEditTester.createContact(account, true);
            System.assertEquals(String.isNotEmpty(contact.Id), true);
            
            Test.stopTest();
        }
    }
}