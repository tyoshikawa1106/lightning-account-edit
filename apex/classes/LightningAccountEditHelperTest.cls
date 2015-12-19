@isTest
private class LightningAccountEditHelperTest {

    private static LightningAccountEditHelper helper = new LightningAccountEditHelper();
    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * 取引先責任者クラス取得
     * テストデータなし
     */
    static testMethod void getLightningAccountEditApexContactTest1() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();

            Test.startTest();
            
            List<LightningAccountEditApexContact> results = helper.getLightningAccountEditApexContact(contacts);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先責任者クラス取得
     * テストデータあり
     */
    static testMethod void getLightningAccountEditApexContactTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            List<Contact> contacts = new List<Contact>();
            contacts.add(contact);

            Test.startTest();
            
            List<LightningAccountEditApexContact> results = helper.getLightningAccountEditApexContact(contacts);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 削除対象取引先責任者ID取得
     * テストデータなし
     */
    static testMethod void getDelContactIdsByJsonTest1() {
        
        System.runAs(testAdminUser) {

            List<Object> jsonDelContactIdList = new List<Object>();

            Test.startTest();
            
            Set<Id> results = helper.getDelContactIdsByJson(jsonDelContactIdList);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 削除対象取引先責任者ID取得
     * テストデータあり
     */
    static testMethod void getDelContactIdsByJsonTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            // JSON文字列の生成
            String deleteContactIdJSON = '[' + '\"' + contact.Id + '\"' + ']';
            List<Object> jsonDelContactIdList = (List<Object>) JSON.deserializeUntyped(deleteContactIdJSON);

            Test.startTest();
            
            Set<Id> results = helper.getDelContactIdsByJson(jsonDelContactIdList);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 取引先値判定
     * テストデータなし
     */
    static testMethod void isAccountValidationTest1() {
        
        System.runAs(testAdminUser) {

            Account account = new Account();
            LightningAccountEditResult result = new LightningAccountEditResult();

            Test.startTest();
            
            result = helper.isAccountValidation(account, result);
            
            Test.stopTest();

            System.assertEquals(result.errorMessages.isEmpty(), false);
        }
    }

    /**
     * 取引先値判定
     * テストデータあり
     */
    static testMethod void isAccountValidationTest2() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            LightningAccountEditResult result = new LightningAccountEditResult();

            Test.startTest();
            
            result = helper.isAccountValidation(account, result);
            
            Test.stopTest();

            System.assertEquals(result.errorMessages.isEmpty(), true);
        }
    }

    /**
     * 取引先責任者取得
     * テストデータなし
     */
    static testMethod void getContactsByApexMapTest1() {
        
        System.runAs(testAdminUser) {

            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            Id accountId = null;

            Test.startTest();
            
            List<Contact> results = helper.getContactsByApexMap(apexContactMap, accountId);
            
            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先責任者取得
     * テストデータあり
     */
    static testMethod void getContactsByApexMapTest2() {
        
        System.runAs(testAdminUser) {
            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            apexContactMap.put(0, new LightningAccountEditApexContact());
            Id accountId = null;

            Test.startTest();
            
            List<Contact> results = helper.getContactsByApexMap(apexContactMap, accountId);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 取引先責任者取得
     * テストデータあり
     */
    static testMethod void getContactsByApexMapTest3() {
        
        System.runAs(testAdminUser) {
            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            LightningAccountEditApexContact apexContact = new LightningAccountEditApexContact();
            apexContact.contact = contact;

            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            apexContactMap.put(0, apexContact);
            Id accountId = account.Id;

            Test.startTest();
            
            List<Contact> results = helper.getContactsByApexMap(apexContactMap, accountId);
            
            Test.stopTest();

            System.assertEquals(results.size(), 0);
        }
    }

    /**
     * 取引先責任者取得
     * テストデータあり
     */
    static testMethod void getContactsByApexMapTest4() {
        
        System.runAs(testAdminUser) {
            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            LightningAccountEditApexContact apexContact = new LightningAccountEditApexContact();
            apexContact.contact = contact;
            apexContact.isChanged = true;

            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            apexContactMap.put(0, apexContact);
            Id accountId = account.Id;

            Test.startTest();
            
            List<Contact> results = helper.getContactsByApexMap(apexContactMap, accountId);
            
            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 取引先責任者値判定
     * テストデータなし
     */
    static testMethod void isContactValidationTest1() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();
            LightningAccountEditResult result = new LightningAccountEditResult();

            Test.startTest();
            
            result = helper.isContactValidation(contacts, result);
            
            Test.stopTest();

            System.assertEquals(result.errorMessages.size(), 0);
        }
    }

    /**
     * 取引先責任者値判定
     * テストデータなし
     */
    static testMethod void isContactValidationTest2() {
        
        System.runAs(testAdminUser) {

            List<Contact> contacts = new List<Contact>();
            contacts.add(new Contact());
            LightningAccountEditResult result = new LightningAccountEditResult();

            Test.startTest();
            
            result = helper.isContactValidation(contacts, result);
            
            Test.stopTest();

            System.assertEquals(result.errorMessages.size(), 2);
        }
    }

    /**
     * 取引先責任者値判定
     * テストデータあり
     */
    static testMethod void isContactValidationTest3() {
        
        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            List<Contact> contacts = new List<Contact>{contact};
            LightningAccountEditResult result = new LightningAccountEditResult();

            Test.startTest();
            
            result = helper.isContactValidation(contacts, result);
            
            Test.stopTest();

            System.assertEquals(result.errorMessages.size(), 0);
        }
    }
}