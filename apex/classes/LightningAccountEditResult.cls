public with sharing class LightningAccountEditResult {

    @AuraEnabled
    public Id accountId {get; set;}
    @AuraEnabled
    public List<String> errorMessages {get; set;}

    /**
     * コンストラクタ
     */
    public LightningAccountEditResult() {
        this.accountId = null;
        this.errorMessages = new List<String>();
    }
}