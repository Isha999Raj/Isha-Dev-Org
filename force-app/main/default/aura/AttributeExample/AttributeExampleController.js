({
	doClick : function(component, event, helper) {
        alert(component.isValid());
        alert(component.getName());
		alert(component.get('v.Name'));
        alert(component.get('v.Age'));
        
        //for set value 2 parameters : 
        // 1. key - Attribute and 1. Value -  That we want to be set in the attribute.
        alert(component.set('v.Name', "Raaz"));
        alert(component.get('v.Name'));
        
        var ageComp = component.find('testInput');
        alert(ageComp.get('v.value'));
        ageComp.set('v.value', 25);
        
        /*alert(component.find('testInput'));
        alert(component.get('v.value'));
        alert(component.set('v.value', 30)); */
        
    }
})