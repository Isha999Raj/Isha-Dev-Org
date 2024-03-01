({
    doInit : function(component, event, helper) { 
        debugger;
        helper.getAppointment(component, event);
        
    },
    
    handleNext : function(component, event, helper) { 
        debugger;
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getAppointment(component, helper);
    },
    
    handlePrev : function(component, event, helper) {   
        debugger;
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getAppointment(component, helper);
    },
    
    openModal: function(component, event, helper) {
        debugger;
        var appointmentId = event.currentTarget.dataset.id;
        var action = component.get("c.getAppointmentById");
        action.setParams({
            "appointmentId": appointmentId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.selectedAppointment", response.getReturnValue());
                
                component.set("v.isModalOpen", true);
            } else {
                console.log("Failed to retrieve appointment record");
            }
        });
        $A.enqueueAction(action);
    },
    
    closeModal: function(component, event, helper) {
        debugger;
        component.set("v.isModalOpen", false);
        component.set("v.showModal", false);
    },
    
    handleDateChange: function(component, event, helper) {
        debugger;
        var selectedDate = component.find("datePicker").get("v.value");
        
        var action = component.get("c.getAppointmentsByDate");
        action.setParams({
            "selectedDate": selectedDate // Make sure this parameter name matches your Apex controller
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.appList", response.getReturnValue());
            } else {
                console.log("Failed to retrieve appointments by date");
            }
        });
        
        $A.enqueueAction(action);
    },
 
    handleFilterChange : function(component, event, helper) {
        var selectedFilter = component.find("filterType").get("v.value");
        
        if(selectedFilter === 'Today') {
            helper.fetchTodaysAppointments(component);
        } else if(selectedFilter === 'Custom Date') {
            component.set("!v.filterType", 'Custom Date');
            var startDate = component.get("v.startDate");
            var endDate = component.get("v.endDate");
            helper.fetchAppointmentsByDateRange(component, startDate, endDate);
        }
    },
    
    saveAppointment : function(component, event, helper) {
        debugger;
        var newAppointment = component.get("v.newAppointment");
        var action = component.get("c.createAppointment");
        action.setParams({
            "appointment": newAppointment,
            "contactId": component.get("v.contactId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.showModal", false);
                helper.getAppointment(component);
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    openBookingAppo : function(component, event, helper) {
        debugger;
    component.set("v.showModal", true);
}

})