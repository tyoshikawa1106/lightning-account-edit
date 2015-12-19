public with sharing class LightningAccountEditSelectListItem {

    // LeadSource選択リスト値
    @AuraEnabled
    public Map<String, String> leadSourceMap {get; set;}

    /**
     * コンストラクタ
     */
    public LightningAccountEditSelectListItem() {
        // LeadSource選択リスト値
        this.leadSourceMap = new Map<String, String>();
    }

    /**
     * LeadSource選択リスト値取得
     */
    public Map<String, String> getLeadSourceMap() {
        Schema.DescribeFieldResult F = Contact.LeadSource.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();
        
        Map<String, String> optionMap = new Map<String, String>();
        optionMap.put('', '-- none --');
        for (Schema.PicklistEntry pick : P) {
            optionMap.put(String.valueOf(pick.getValue()), String.valueOf(pick.getLabel()));
        }
        
        return optionMap;
    }
}