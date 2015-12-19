({
	init: function(component, event, helper) {
        helper.getAccountInfo(component, event);
        helper.getContactInfo(component, event);
    },
    doSaveBtn: function(component, event, helper) {
       helper.doSaveBtn(component, event);
    },
})