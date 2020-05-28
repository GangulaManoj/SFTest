({
	handelClick : function(component, event, helper) {
        var btnClicked=event.getSource();
        var btnmsg=btnClicked.get("v.label");
        component.set("v.message",btnmsg);
		
	}
})