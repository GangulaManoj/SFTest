({
	doInit : function(component, event, helper) {
      // alert(component.get("v.recordId"));
		var action=component.get("c.getContacts");
        action.setParams({"accid" : component.get("v.recordId")});
        action.setCallback(this,function(response){
           if(response.getState() == "SUCCESS")
           {
               component.set("v.RealtedContacs",response.getReturnValue());
           }
        });
        $A.enqueueAction(action);
	}
})