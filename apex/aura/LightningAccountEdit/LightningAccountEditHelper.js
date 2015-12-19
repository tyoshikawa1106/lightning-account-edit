({
  getAccountInfo : function(component, event) {
    // Account ID
    var accountId = component.get("v.recordId");
    
    // Apex
    var action = component.get("c.getAccount");
    action.setParams({
      "accountId": accountId
    });
    action.setCallback(this, function(data) {
      component.set("v.account", data.getReturnValue());
    });
    $A.enqueueAction(action);
  },
  getContactInfo : function(component, event) {
    // Account ID
    var accountId = component.get("v.recordId");
    
    // Apex
    var action = component.get("c.getContacts");
    action.setParams({
      "accountId": accountId
    });
    action.setCallback(this, function(data) {
      component.set("v.contacts", data.getReturnValue());
    });
    $A.enqueueAction(action);
  },
  doSaveBtn : function(component, event) {
    var account = component.get("v.account");
    var apexContacts = component.get("v.contacts");
    
    // Apex
    var action = component.get("c.doSave");
    action.setParams({
      "account": account,
      "apexContactsJSON": JSON.stringify(apexContacts)
    });
    action.setCallback(this, function(data) {
        component.set("v.result", data.getReturnValue());
    });
    $A.enqueueAction(action);
  },
})