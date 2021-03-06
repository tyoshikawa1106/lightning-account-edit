@isTest
private class LightningAccountEditControllerTest {

    private static User testAdminUser = LightningAccountEditTester.getLoginUser();

    /**
     * コンストラクタ
     * 値なし
     */
    static testMethod void LightningAccountEditControllerTest1() {

        System.runAs(testAdminUser) {

            Test.startTest();

            LightningAccountEditController cls = new LightningAccountEditController(new ApexPages.StandardController(new Account()));

            Test.stopTest();

            System.assertEquals(String.isEmpty(cls.account.Id), true);
        }
    }

    /**
     * コンストラクタ
     * 値あり
     */
    static testMethod void LightningAccountEditControllerTest2() {

        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);

            Test.startTest();

            LightningAccountEditController cls = new LightningAccountEditController(new ApexPages.StandardController(account));

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(cls.account.Id), true);
        }
    }

    /**
     * 取引先責任者取得
     * 値なし
     */
    static testMethod void getContactsTest1() {

        System.runAs(testAdminUser) {

            String accountId = '';

            Test.startTest();

            List<Contact> results = LightningAccountEditController.getContacts(accountId);

            Test.stopTest();

            System.assertEquals(results.isEmpty(), true);
        }
    }

    /**
     * 取引先責任者取得
     * 値あり
     */
    static testMethod void getContactsTest2() {

        System.runAs(testAdminUser) {

            Account account = LightningAccountEditTester.createAccount(true);
            Contact contact = LightningAccountEditTester.createContact(account, true);

            String accountId = account.Id;

            Test.startTest();

            List<Contact> results = LightningAccountEditController.getContacts(accountId);

            Test.stopTest();

            System.assertEquals(results.size(), 1);
        }
    }

    /**
     * 選択リスト値取得
     */
    static testMethod void getLightningAccountEditSelectListItemTest1() {

        System.runAs(testAdminUser) {

            String accountId = '';

            Test.startTest();

            LightningAccountEditSelectListItem result = LightningAccountEditController.getLightningAccountEditSelectListItem();

            Test.stopTest();

            System.assertEquals(result.leadSourceMap.isEmpty(), false);
        }
    }

    /**
     * 保存ボタン処理
     * 値なし
     */
    static testMethod void doSaveTest1() {

        System.runAs(testAdminUser) {

            Account account = new Account();
            String deleteContactIdsJSON = '';
            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(result.errorMessages.size(), 1);
        }
    }

    /**
     * 保存ボタン処理
     * 取引先保存
     */
    static testMethod void doSaveTest2() {

        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = LightningAccountEditTester.createAccount(false);

            String deleteContactIdsJSON = '';
            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.accountId), true);
            System.assertEquals(result.errorMessages.isEmpty(), true);
        }
    }

    /**
     * 保存ボタン処理
     * 取引先必須エラー
     */
    static testMethod void doSaveTest3() {

        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = LightningAccountEditTester.createAccount(false);
            account.Name = '';

            String deleteContactIdsJSON = '';
            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(String.isEmpty(result.accountId), true);
            System.assertEquals(result.errorMessages.isEmpty(), false);
        }
    }

    /**
     * 保存ボタン処理
     * 取引先責任者保存
     */
    static testMethod void doSaveTest5() {

        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = LightningAccountEditTester.createAccount(false);
            // 削除ID
            String deleteContactIdsJSON = '';
            
            // 取引先責任者
            LightningAccountEditApexContact apexContact = new LightningAccountEditApexContact();
            apexContact.contact = LightningAccountEditTester.createContact(new Account(), false);
            apexContact.isChanged = false;

            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            apexContactMap.put(0, apexContact);

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.accountId), true);
            System.assertEquals(result.errorMessages.isEmpty(), true);
            // 取引先責任者の取得
            Integer resultContactCount = [SELECT COUNT() FROM Contact WHERE AccountId =: result.accountId LIMIT 200];
            System.assertEquals(resultContactCount, 1);
        }
    }

    /**
     * 保存ボタン処理
     * 取引先責任者保存必須エラー
     */
    static testMethod void doSaveTest6() {

        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = LightningAccountEditTester.createAccount(false);
            // 削除ID
            String deleteContactIdsJSON = '';
            // 取引先責任者
            LightningAccountEditApexContact apexContact = new LightningAccountEditApexContact();
            apexContact.contact = LightningAccountEditTester.createContact(new Account(), false);
            apexContact.contact.LastName = '';
            apexContact.isChanged = false;

            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();
            apexContactMap.put(0, apexContact);

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(String.isEmpty(result.accountId), true);
            System.assertEquals(result.errorMessages.isEmpty(), false);
            // 取引先責任者の取得
            Integer resultContactCount = [SELECT COUNT() FROM Contact LIMIT 200];
            System.assertEquals(resultContactCount, 0);
        }
    }

    /**
     * 保存ボタン処理
     * 取引先責任者削除
     */
    static testMethod void doSaveTest7() {

        System.runAs(testAdminUser) {

            // 取引先テストデータ
            Account account = LightningAccountEditTester.createAccount(true);
            // 取引先責任者情報作成
            Contact contact = LightningAccountEditTester.createContact(account, true);
            String deleteContactIdsJSON = '[' + '\"' + contact.Id + '\"' + ']';
            // 取引先責任者
            Map<Integer, LightningAccountEditApexContact> apexContactMap = new Map<Integer, LightningAccountEditApexContact>();

            Test.startTest();

            LightningAccountEditResult result = LightningAccountEditController.doSave(account, deleteContactIdsJSON, apexContactMap);

            Test.stopTest();

            System.assertEquals(String.isNotEmpty(result.accountId), true);
            System.assertEquals(result.errorMessages.isEmpty(), true);
            // 取引先責任者の取得
            Integer resultContactCount = [SELECT COUNT() FROM Contact WHERE AccountId =: result.accountId LIMIT 200];
            System.assertEquals(resultContactCount, 0);
        }
    }
}