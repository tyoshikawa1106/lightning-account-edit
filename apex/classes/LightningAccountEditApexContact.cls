public with sharing class LightningAccountEditApexContact {

    @AuraEnabled
    public Contact contact {get; set;}
    @AuraEnabled
    public Boolean isChanged {get; set;}

    /**
     * コンストラクタ
     */
    public LightningAccountEditApexContact() {
        this.contact = new Contact();
        this.isChanged = false;
    }

    /**
     * コンストラクタ
     */
    public LightningAccountEditApexContact(Contact c) {
        this.contact = c;
        this.isChanged = false;
    }
}