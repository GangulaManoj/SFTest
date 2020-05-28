({
    
	doFetchContact : function(component, page, recordToDisply) {
		var action = component.get('c.showContacts');
        action.setParams({
         "pageNumber": page,
         "recordToDisply": recordToDisply
      });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' && component.isValid()){
                            
                component.set('v.PaginationList', response.getReturnValue().contacts);
                 component.set("v.page", response.getReturnValue().page);
         	component.set("v.total", response.getReturnValue().total);
        	 component.set("v.pages", Math.ceil(response.getReturnValue().total / recordToDisply));
                
           }else{
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
	},
     SearchHelper: function(component, event, page, recordToDisply) {
        var action = component.get("c.SearchAccount");
        action.setParams({
            "pageNumber": page,
         "recordToDisply": recordToDisply,
            'searchKeyWord': component.get("v.searchKeyword")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue().contacts;
                // if storeResponse size is 0 ,display no record found message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                }
                // set numberOfRecord attribute value with length of return value from server
                //component.set("v.numberOfRecord", storeResponse.length);
                // set searchResult list with return value from server.
                component.set("v.PaginationList", storeResponse);
                component.set("v.page", response.getReturnValue().page);
         	component.set("v.total", response.getReturnValue().total);
        	 component.set("v.pages", Math.ceil(response.getReturnValue().total / recordToDisply));
            }
 
        });
        $A.enqueueAction(action);
 
    }
})