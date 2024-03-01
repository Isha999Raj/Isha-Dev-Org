({
    fetchChildAccData : function(component, event, helper) {
        
        var action = component.get('c.QueryAccount');
        debugger;
        
        action.setCallback(this, function(response){
            
            var state = response.getState();
            if(state === "SUCCESS"){
                component.set('v.childAccount', response.getReturnValue()); 
            }
            
        });
        $A.enqueueAction(action);
    },
    
    submitChanges : function(component, event, helper){
        
        var allAccData = component.get('v.checkListAccount');
        var updatedAccData = [];
        
        for(var i=0; i<allAccData.length; i++){
            for(var j=0;j<allAccData[i].childAccount.length;j++){
                for(var k=0;k<allAccData[i].childAccount[j].Name.length;k++);
                updatedAccData.push(allAccData[i].childAccount[j].Name[k]);
            }
        }
        
        var action = component.get('c.updatedAccData');
        action.setParams
    }
})