({
	doAdd : function(component, event, helper) {
		var number1 = component.get('v.input1');
        var number2 = component.get('v.input2');
        //alert(parseInt(number1) + parseInt(number2));
        component.set('v.output' , parseInt(number1) + parseInt(number2));
	},
    doSubtract : function(component, event, helper) {
        var number1 = component.get('v.input1');
		var number2 = component.get('v.input2');
        component.set('v.output' , (number1) - (number2));
	},
    doMultiply : function(component, event, helper) {
        var number1 = component.get('v.input1');
        var number2 = component.get('v.input2');
        component.set('v.output' , (number1) * (number2));
		
	},
    doDivide : function(component, event, helper) {
		var number1 = component.get('v.input1');
        var number2 = component.get('v.input2');
        component.set('v.output' , (number1) / (number2));
	}
})