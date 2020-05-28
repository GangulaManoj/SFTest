({
	doInit : function(component, event, helper) {
		var action = component.get("c.getExpenses");
        action.setcallback(this,function(){
            var state=response.getState();
            if(state=="SUUCESS")
            {
                component.set("v.expenses",response.getreturnValue());
            }
            else
            {
                console.log("Failed with state"+state);
            }
        });
        $A.enqueueAction(action);
	}
})