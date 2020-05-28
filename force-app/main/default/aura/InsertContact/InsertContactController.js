({
	create : function(component, event, helper) {
		var contactInfo=component.get("v.ContactDetails");
        if($A.util.isEmpty(contactInfo.LastName) || $A.util.isUndefined(contactInfo.LastName)){
            
            
            
            
            
            
            
            alert('First Name is Required');
            return;
        }            
        if($A.util.isEmpty(contactInfo.Email) || $A.util.isUndefined(contactInfo.Email)){
            alert('Email is Rqquired');
            return;
        }
         var action = component.get("c.CreateRecord");
        action.setParams({
            con : contactInfo
        });
        alert('Test Response'+action);
        action.setCallback(this,function(response){
            alert('call back'+response.getState());
            var state=response.getState();
            if(state=="SUCCESS"){
               var newContact={'sobjectType': 'Contact',
                                    'Name': '',	
                                    'Email': '', 
              						'Age__c':''
                                   };
               component.set("v.ContactDetails",newContact);
           	 	alert('Record is Created Successfully');
            }
               else if(state=="ERROR")
               {
                    alert('Error in calling server side action');
               }
        });
    $A.enqueueAction(action);
      }
})