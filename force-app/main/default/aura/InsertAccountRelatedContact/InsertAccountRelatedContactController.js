({
	handleClick : function(component, event, helper) {
		var action=component.get("c.InsertContacts");
        action.setParams({"Con":component.get("v.Contacts")});
        action.setCallback(this,function(response){
           if(response.getState() == "SUCCESS")
           {
               $A.get("e.force:refreshView").fire();
           }
        });
        $A.enqueueAction(action);
	}
})