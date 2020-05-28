({
	 addItem : function(component, campaign) {
        var createEvent = component.getEvent("addItem");
     createEvent.setParams({ "item": campaign });
     createEvent.fire();
  component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c',
                    'Name': '',
                    'Quantity__c': 0,
                    'Price__c': 0,
                    'Packed__c': false });
 },	
    validateItemForm:function(component){
        var validItem=true;
        var nameField=component.find("itemName");
        var itemName=nameField.get("v.value");
        if($A.util.isEmpty(itemName)){
            validItem=false;
            nameField.set("v.errors",[{message:"Item Name can't be blank"}]);
        }
        else
        {
            nameField.set("v.errors",null);
        }
        
        var  quantityField =component.find("quantity");
        var quantity=quantityField.get("v.value");
        if($A.util.isEmpty(quantity)){
            validItem=false;
            quantityField.set("v.errors",[{message:"Quantity can't be blank"}]);         
        }
        else
        {
            quantityField.set("v.errors",null);
        }
        
        var priceField=component.find("price");
        var price=priceField.get("v.value");
        if($A.util.isEmpty(price)){
            validItem=false;
            priceField.set("v.errors",[{message:"Price can't be Blank"}]);
        }
        else{
            priceField.set("v.errors",null);
        }
        return validItem;
    }
})