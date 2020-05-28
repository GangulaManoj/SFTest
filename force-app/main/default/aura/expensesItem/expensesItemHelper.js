({
    
    saveExpense:function(component,expense,callback)
    {
        var action=component.get("c.saveExpense");
        action.setParms({
            "expense" :expense
        });
        if(callback)
        {
            action.setCallback(this,callback);
        }
        $A.enqueueAction(action);
    },
	updateExpense : function(component,expense) {
		this.saveExpense(component,expense);
	},
    createExpense:function(component,expense)
    {
        this.saveExpense(component,expense,function(response){
            var state=response.getState();
            if(state === "SUCCESS"){
                var expneses=component.get("v.expenses");
                expneses.push(response.getReturnvalue());
                component.set("v.expenses",expneses);
            }
        });
    }
})