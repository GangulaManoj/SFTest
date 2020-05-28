({
	saveContact  : function(component, event, helper) {
		var recordLoader=component.find("recordLoader");
        recordLoader.saveRecord($A.getCallback(function(saveResult){
            if(saveResult.state === "ERROR")
            {
            var errMsg="";
            for(var i=0;i<saveResult.error.length; i++)
            {
                errMsg +=saveResult.error[i].message+"\n";
            }
            component.set("v.recordSaveError",errMsg);
            }
            else{
                component.set("v.recordSaveError",errMsg);
            }
        }));
	},
    
})