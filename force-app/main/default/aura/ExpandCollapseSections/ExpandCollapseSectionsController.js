({
    doInit : function(component, event, helper) {
        debugger;
    },
    getContactName : function(component, event, helper) {
        debugger;
        
        var action = component.get("c.callingApex"); 
        action.setParams({
            "contactName" : "Aakash"
        })    
        action.setCallback(this, function(response){ 
            component.set("v.conatactName", response.getReturnValue()); 
        }); 
        $A.enqueueAction(action); 
    }
})