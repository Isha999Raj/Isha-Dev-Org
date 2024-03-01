({
    FetchContact : function(component, event, helper) {
        
        debugger;
        var action = component.get('c.getAllContacts');				
        action.setParams({
            accId : component.get('v.recordId')
        });
        action.setCallback(this, function(response){			
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                
                console.log("allValues--->>> " + allValues);
                component.set('v.ConList', allValues);
            }
            
        });
        $A.enqueueAction(action);
    },
    
    FetchOpportunity : function(component, event, helper) {
        
        debugger;
        var action = component.get('c.getAllOpportunities');				
        action.setParams({
            accId : component.get('v.recordId')
        })
        action.setCallback(this, function(response){			
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                
                console.log("allValues--->>> " + allValues);
                component.set('v.OppList', allValues);
            }
            
        });
        $A.enqueueAction(action);
    },
    
    showContacts : function(component, event, helper){
        //component.set("v.isTrueCon" , true);
        //component.set("v.isTrueOpp" , false);
        $A.enqueueAction(component.get('c.FetchContact'));
    },
    
    showOpportunity : function(component, event, helper){
       //component.set("v.isTrueOpp" , true);
        //component.set("v.isTrueCon" , false);
        $A.enqueueAction(component.get('c.FetchOpportunity'));
    }
    
})