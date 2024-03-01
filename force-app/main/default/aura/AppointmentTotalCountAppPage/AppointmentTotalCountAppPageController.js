({
	doinit: function(component, event, helper) {
        debugger;
        var contactId = component.get("v.recordId"); // Assuming you're retrieving the contact ID from the record ID
        contactId = '0035j00001OUToEAAX';
        var action = component.get("c.getAppointmentByStatusContact");
        action.setParams({
            "contactId": contactId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.metrics", response.getReturnValue());
            }else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
})