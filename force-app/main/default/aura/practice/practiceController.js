({
	save : function(component, event, helper) {
		var action=component.get("c.creatCampaignRecord");
        action.setParams({"CampaignObj":component.get("v.CampaignObj")});
        action.setCallback(this,function(result)){
      		component.set("v.isShow",false);
        var campid=result.getReturnValue();
        alert('leadId'+leadId);
        });
    $A.enqueueAction(action);
	}
})