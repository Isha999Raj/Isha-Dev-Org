({
    doinit : function(component, event, helper) {
        var action = component.get("c.getMeetingLink");
        action.setParams({
            appointmentId: component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var meetingLink = response.getReturnValue();
                if (meetingLink) {
                    
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title : 'Success',
                        message: 'You have successfully joined the meeting.',
                        duration:' 5000',
                        key: 'info_alt',
                        type: 'success',
                        mode: 'pester'
                    });
                    toastEvent.fire();
                    window.open(meetingLink);
                    $A.get("e.force:closeQuickAction").fire();
                } else {
                    console.error('Meeting link is not available');
                }
            } else {
                console.error('Error fetching meeting link');
            }
        });
        $A.enqueueAction(action);
    }
})