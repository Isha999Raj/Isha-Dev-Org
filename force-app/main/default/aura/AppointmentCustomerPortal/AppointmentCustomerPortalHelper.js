({
    getAppointment : function(component, event) {
        debugger;
        var selectedDates = component.get("v.selectedDates");
        var action = component.get("c.getAppointments");
        action.setParams({
            'pageSize' : component.get("v.pageSize"),
            'pageNumber' : component.get("v.pageNumber"),
            "contactId": component.get("v.contactId")
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                if(result.length < component.get("v.pageSize") || result.length == 0){
                    component.set("v.isLastPage", true);
                } else{
                    component.set("v.isLastPage", false);
                }
                component.set("v.dataSize", result.length);
                component.set("v.appList", result);
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchTodaysAppointments : function(component) {
        var action = component.get("c.getAppointmentsForToday");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.appointments", response.getReturnValue());
            } else {
                console.log("Error fetching today's appointments: " + response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    
    fetchAppointmentsByDateRange : function(component, startDate, endDate) {
        var action = component.get("c.getAppointmentsByDateRange");
        action.setParams({
            "startDate": startDate,
            "endDate": endDate
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if(state === "SUCCESS") {
                component.set("v.appointments", response.getReturnValue());
            } else {
                console.log("Error fetching appointments by date range: " + response.getError());
            }
        });
        $A.enqueueAction(action);
    },
    
    getAppointments : function(component) {
        var action = component.get("c.fetchAppointments");
        action.setParams({
            startDate: component.get("v.startDate"),
            endDate: component.get("v.endDate")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.appointments", response.getReturnValue());
            } else {
                console.log('Error fetching appointments');
            }
        });
        $A.enqueueAction(action);
    }
})