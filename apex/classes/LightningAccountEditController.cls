public with sharing class LightningAccountEditController {

    private static LightningAccountEditHelper helper = new LightningAccountEditHelper();
    private static LightningAccountEditDao dao = new LightningAccountEditDao();

    /**
     * コンストラクタ
     */
    public LightningAccountEditController() {

    }

    /**
     * 取引先取得
     */
    @AuraEnabled
    public static Account getAccount(String accountId) {
        return dao.getAccount(accountId);
    }
    
    /**
     * 取引先責任者取得
     */
    @AuraEnabled
    public static List<LightningAccountEditApexContact> getContacts(String accountId) {
        // 取引先責任者取得
        List<Contact> contacts = dao.getContacts(accountId);
        // クラスにセット
        List<LightningAccountEditApexContact> apexContacts = helper.getLightningAccountEditApexContact(contacts);

        return apexContacts;
    }

    /**
     * 選択リスト値取得
     */
    @AuraEnabled
    public static LightningAccountEditSelectListItem getLightningAccountEditSelectListItem() {
        LightningAccountEditSelectListItem result = new LightningAccountEditSelectListItem();
        // LeadSource選択リスト値取得
        result.leadSourceMap = result.getLeadSourceMap();

        return result;
    }

    /**
     * 保存処理実行
     */
    @AuraEnabled
    public static LightningAccountEditResult doSave(Account account, String apexContactsJSON) {
        Savepoint sp = Database.setSavepoint();
        LightningAccountEditResult result = new LightningAccountEditResult();

        //for (LightningAccountEditApexContact apexContact : apexContacts) {
        //    System.debug(apexContact);
        //}
        
        try {
            /*
            // 取引先責任者の削除
            if (String.isNotEmpty(deleteContactIdsJSON)) {
                // JSON → Map
                List<Object> jsonDelContactIdList = (List<Object>) JSON.deserializeUntyped(deleteContactIdsJSON);
                // 削除対象の取引先責任者ID取得
                Set<Id> delContactIds = helper.getDelContactIdsByJson(jsonDelContactIdList);
                // 削除対象の取引先責任者を取得
                List<Contact> deleteContacts = dao.getDeleteContacts(delContactIds);
                // 取引先責任者の削除
                delete deleteContacts;
            }
            */
            // 取引先値チェック
            result = helper.isAccountValidation(account, result);
            // エラーがある場合は処理終了
            if (!result.errorMessages.isEmpty()) {
                Database.rollback(sp);
                return result;
            }
            // 取引先登録
            upsert account;
            /*
            // 取引先責任者の登録
            if (!apexContactMap.KeySet().isEmpty()) {
                // 取引先責任者取得
                List<Contact> contacts = helper.getContactsByApexMap(apexContactMap, account.Id);
                // 取引先責任者値チェック
                result = helper.isContactValidation(contacts, result);
                // エラーがある場合は処理終了
                if (!result.errorMessages.isEmpty()) {
                    Database.rollback(sp);
                    return result;
                }
                // 取引先責任者登録
                upsert contacts;
            }
            */
            // 取引先IDを返す
            result.accountId = account.Id;

        } catch(DmlException e) {
            Database.rollback(sp);
            result.errorMessages.add(e.getDmlMessage(0));
            return result;
        } catch(Exception e) {
            Database.rollback(sp);
            result.errorMessages.add(e.getMessage());
            return result;
        }
        
        return result;
    }
}