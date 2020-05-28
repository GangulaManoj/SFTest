({
    doint :function(component, event, helper) {  
        var str='{"Id":"00Q0K000010lblJUAQ","LastName":"Maccleod"}';
        var obj=JSON.parse(str);
        alert(obj["LastName"]);
    },
 save : function(component, event, helper) {     
     var action = component.get("c.creatLeadRecord");
            action.setParams({"leadObj":component.get("v.leadObj")});
            action.setCallback(this,function(result){
            component.set("v.isShow",false);
            var leadId = result.getReturnValue();
            alert('leadId'+leadId); 
        });
         $A.enqueueAction(action);
 }
})