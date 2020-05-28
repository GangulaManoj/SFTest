({
    myAction : function(component, event, helper) {
        var action = component.get("c.getContacts");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this, function(data) {
            component.set("v.Contacts", data.getReturnValue());
        });
        alert(component.get("v.Contacts"));
        $A.enqueueAction(action);
        
    }
})