({
	doInit : function(component, event, helper) {
		component.set("v.myColumns", [
            {label:'SNo',fieldName:'sno',type:'number'},
            {label:'Name of Source',fieldName:'source',type:'text'},
            {label:'Amount',fieldName:'amount',type:'number'}
        ]);
        component.set("v.incomes",[{
            sno:1,
            source:'Regular Job Income',
            amount:10000
            },
            {
            sno:2,
            source:'part-Time Job Income',
            amount:10000
            }
                                   
        ]);
	}
})