({
	doInit : function(component, event, helper) {
		var action =component.get("c.getOpenActvit");
        action.setParams({"recordId":component.get("v.recordId")});
        action.setCallback(this,function(response){
            var state=response.getState();
          
            if(state=="SUCCESS"){
                component.set("v.OpenActivitiesListData",response.getReturnValue());
            }
        });
	}
})