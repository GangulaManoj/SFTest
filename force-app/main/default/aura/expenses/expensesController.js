({
	clickCreate : function(component, event, helper) {
        var validexpense=component.find("expenseform").reduce(function(validSofar,inputcmp){
            inputcmp.showHelpMessageIfInvalid();
            return validSofar && inputcmp.get('v.validity').valid;
        },true);
        if(validexpense)
        {
            var newExpense =component.get("v.newExpense");
            console.log('create expense:'+JSON.stringify(newExpense));
            helper.createExpense(component,newExpense);
        }
	}
})