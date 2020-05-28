({
	doInit : function(component, event, helper) {
		var action=component.get("c.hello");
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=="SUCCESS")
            {
                alert(response.getReturnValue());
                
                alert('map'+component.get("v.Hiringmap"));
                var HiringMapdata=JSON.parse(response.getReturnValue());
                component.set("v.Hiringmap",HiringMapdata);
                alert(HiringMapdata[0].skills);
                for(var key in HiringMapdata)
                {
                    if (HiringMapdata.hasOwnProperty(key)) {
                        var val = HiringMapdata[key].skills;
                        alert('value'+val+'key'+key);
                    }
                  //  alert('keys'+component.get("v.HiringMapdata").("skills")));
                }
            }
        });
        $A.enqueueAction(action);
        
	}
})