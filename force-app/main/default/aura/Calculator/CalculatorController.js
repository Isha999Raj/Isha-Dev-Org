({
	Calculate : function(component, event, helper) {
        
        //1. With the help of aura id finding values :
        
		/*var firstNumber = component.find("firstNumber").get("v.value");
        alert(firstNumber);
        var secondNumber = component.find("secondNumber").get("v.value");
        alert(secondNumber);
        var Result = component.find("Result");
        Result.set("v.value",firstNumber + secondNumber);*/
        
        //2. With the help of attribute finding values :
        
        /*var fnumber = component.get("v.FirstNumber");
        var snumber = component.get("v.SecondNumber");
        component.set("v.RESULT",fnumber + snumber);*/
        
        //3. With the help of Apex method/controller finding values :
        
        var fnumber = component.get("v.FirstNumber");
        var snumber = component.get("v.SecondNumber");
        var action = component.get("c.calculateValues");
        action.setParams({
            "firstNumber":fnumber,
            "secondNumber":snumber
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            //var valueFromResp = response.getReturnValue();
            if(state==="SUCCESS"){
                component.set("v.RESULT",response.getReturnValue());
            }
                
            });
        $A.enqueueAction(action);
        }
})