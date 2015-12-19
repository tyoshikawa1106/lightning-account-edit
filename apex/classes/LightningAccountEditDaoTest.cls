@isTest
private class LightningAccountEditDaoTest {

    private static LightningAccountEditDao dao = new LightningAccountEditDao();
    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * 取引先を取得
     * テストデータなし
     */
    static testMethod void getAccountTest1() {
        
        System.runAs(testAdminUser) {

            String accountId = '';

            Test.startTest();
            
            Account result = dao.getAccount(accountId);
            
            Test.stopTest();

            System.assertEquals(String.isEmpty(result.Id), true);
        }
    }

    /**
     * 取引先を取得
     * テストデータあり
     */
    static testMethod void getAccountTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            String accountId = account.Id;

            Test.startTest();
            
            Account result = dao.getAccount(accountId);
            
            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.Id), true);
        }
    }

    /**
     * 取引先に紐付く取引先責任者を取得
     * テストデータなし
     */
    static testMethod void getContactsTest1() {
        
        System.runAs(testAdminUser) {

            String accountId = '';

            Test.startTest();
            
            List<Contact> results = dao.getContacts(accountId);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先に紐付く取引先責任者を取得
     * テストデータあり
     */
    static testMethod void getContactsTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            String accountId = account.Id;

            Test.startTest();
            
            List<Contact> results = dao.getContacts(accountId);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 削除対象の取引先責任者を取得
     * テストデータなし
     */
    static testMethod void getDeleteContactsTest1() {
        
        System.runAs(testAdminUser) {

            Set<Id> contactIds = new Set<Id>();

            Test.startTest();
            
            List<Contact> results = dao.getDeleteContacts(contactIds);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 削除対象の取引先責任者を取得
     * テストデータあり
     */
    static testMethod void getDeleteContactsTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            Set<Id> contactIds = new Set<Id>{contact.Id};

            Test.startTest();
            
            List<Contact> results = dao.getDeleteContacts(contactIds);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }
}