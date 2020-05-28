({
    init : function(component, event, helper) {
        console.log('init');
        var action2 = component.get("c.getLead");  
        console.log(action2);
        action2.setCallback(this, function(response) {
            console.log(response.getReturnValue());
            component.set("v.lead", response.getReturnValue());
        });
        $A.enqueueAction(action2);
    }, 
    save : function(component, event, helper) {
        console.log('save:1');
       var action = component.get("c.EditLead");
		var account = component.get("v.lead");
		action.setParams({"lead": account});
        action.setCallback(this, function() {  console.log('SAVED.');  } );
        $A.enqueueAction(action);
        console.log('save:end');
    }
})