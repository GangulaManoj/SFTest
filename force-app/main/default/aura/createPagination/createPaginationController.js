({
    doInit: function (component, event, helper) {
     		component.set("v.State",false);
         var page = component.get("v.page") || 1;
           var recordToDisply = component.find("recordSize").get("v.value");
        component.set('v.columns', [
            {label: 'Contact Name', fieldName: 'Name', type: 'text', sortable : true},
            {label: 'Title', fieldName: 'Title', type: 'text', sortable : true},
            {label: 'Email', fieldName: 'Email', type: 'email', sortable : true},
            {label: 'Mobile Phone', fieldName: 'MobilePhone', type: 'phone', sortable : true},
        ]);
            helper.doFetchContact(component, page, recordToDisply);
    },
     onSelectChange: function(component, event, helper) {
      // this function call on the select opetion change,	 
      var page = 1
      var recordToDisply = component.find("recordSize").get("v.value");
      helper.doFetchContact(component, page, recordToDisply);
   },
  navigate : function(component, event,helper){
         var page = component.get("v.page") || 1;
        var direction = event.getSource().get("v.label");
         var recordToDisply = component.find("recordSize").get("v.value");
         page = direction === "Previous Page" ? (page - 1) : (page + 1);
            if(component.get("v.State") == false)
            {
            alert("false");
            helper.doFetchContact(component, page, recordToDisply);
			}
            else
            {
                        alert("true");
            helper.SearchHelper(component,event, page, recordToDisply);
            }
        
       
    },
  getSelectedName :function(component,event)
            {
            var selectedRows = event.getParam('selectedRows');
			 var navEvt = $A.get("e.force:navigateToSObject");
    navEvt.setParams({
      "recordId": selectedRows[0].ID,
    });
    navEvt.fire();
            
            },
     Search: function(component, event, helper) {
         component.set("v.State",true);
           var page = 1;
           var recordToDisply = component.find("recordSize").get("v.value");
        var searchKeyFld = component.find("searchId");
        var srcValue = searchKeyFld.get("v.value");
        if (srcValue == '' || srcValue == null) {
            // display error message if input value is blank or null
            searchKeyFld.set("v.errors", [{
                message: "Enter Search Keyword."
            }]);
        } else {
            searchKeyFld.set("v.errors", null);
            // call helper method
            helper.SearchHelper(component, event,page, recordToDisply);
        }
    }
})