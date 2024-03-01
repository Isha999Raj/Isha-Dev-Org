({
    
    insertContact : function(component, event, helper) {
        
        debugger;
        var action = component.get('c.insertContact');				
        action.setParams({
            accId : component.get('v.recordId')
        })
        action.setCallback(this, function(response){			
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                
                console.log("allValues--->>> " + allValues);
                component.set('v.contact', allValues);
            }
            
        });
        $A.enqueueAction(action);
    }
    
})