({
myAction : function(component, event, helper) {
    var action = component.get("c.GetAcc");
    action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            component.set("v.reg",response.getReturnValue());
        }
    });
    $A.enqueueAction(action); 
},
 navigateToNewLead : function(component, event, helper) {
 var evt = $A.get("e.force:navigateToComponent");
 evt.setParams({
      componentDef : "c:LeadCreation"
        
  });
   evt.fire();
}})