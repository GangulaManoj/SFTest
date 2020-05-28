({
	doInit : function(component, event, helper) {
		var mydate=component.get("v.expense.Date__c");
        if(mydate)
        {
            component.set("v.formatdate",new Date(mydate));
        }
	},
    handleUpdateExpense:function(component,event,helper){
    var updatedEvent=event.getparm("expense");
    	helper.updateExpense(component,updatedEvent);
}
})