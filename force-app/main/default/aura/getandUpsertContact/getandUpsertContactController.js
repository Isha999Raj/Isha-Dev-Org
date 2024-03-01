({
	doInit : function(component, event, helper) {
		debugger;
        var action = component.get("c.getAllContacts");
        action.setCallback(this, function(a){
            component.set("v.con", a.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})