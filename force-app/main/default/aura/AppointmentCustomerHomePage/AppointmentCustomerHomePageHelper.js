({
    getMetricsData: function(component, event, helper,getDatavalue) {
        debugger;
        
        var contactId = component.get("v.recordId"); // Assuming you're retrieving the contact ID from the record ID
        contactId = '0035j00001OUToEAAX';
        var action = component.get("c.getDashboardMetricsForContact");
        action.setParams({
            'pageSize' : component.get("v.pageSize"),
            'pageNumber' : component.get("v.pageNumber"),
            "contactId": contactId,
            "getData":getDatavalue
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.metrics", response.getReturnValue());
                var result = response.getReturnValue();
                /*if(result.length < component.get("v.pageSize") || result.length == 0){
                    component.set("v.isLastPage", true);
                } else{
                    component.set("v.isLastPage", false);
                }*/
                if(result.totalAppointmentsList!=null && result.totalAppointmentsList!=undefined){
                     component.set("v.dataSize", result.totalAppointmentsList.length);
                     component.set("v.TotalAppList", result.totalAppointmentsList);
                }
                if(result.UpcomingAppointmentsList!=null && result.UpcomingAppointmentsList!=undefined && result.UpcomingAppointmentsList.length>0){
                    component.set("v.upComingAppList", result.UpcomingAppointmentsList);
                }
                if(result.inProgressAppointmentsList!=null && result.inProgressAppointmentsList!=undefined){
                    component.set("v.inProgressAppList", result.inProgressAppointmentsList); 
                }
                if(result.cancelledAppointmentsList!=null && result.cancelledAppointmentsList!=undefined){
                     component.set("v.cancelledAppList", result.cancelledAppointmentsList);
                }
                if((getDatavalue=='AllData' || getDatavalue=='TotalAppointment') && result.totalAppointmentsList!=null && result.totalAppointmentsList!=undefined && result.totalAppointmentsList.length>0){
                    component.set("v.appList", result.totalAppointmentsList);
                    
                }
                if(getDatavalue=='InProgress' && result.inProgressAppointmentsList!=null && result.inProgressAppointmentsList!=undefined && result.inProgressAppointmentsList.length>0){
                       component.set("v.appList", result.inProgressAppointmentsList);
                }
                if(getDatavalue=='Upcoming' && result.UpcomingAppointmentsList!=null && result.UpcomingAppointmentsList!=undefined && result.UpcomingAppointmentsList.length>0){
                       component.set("v.appList", result.UpcomingAppointmentsList);
                }
                if(getDatavalue=='CancelledOrRescheduled' && result.cancelledAppointmentsList!=null && result.cancelledAppointmentsList!=undefined && result.cancelledAppointmentsList.length>0){
                       component.set("v.appList", result.cancelledAppointmentsList);
                }
                
               
            } else {
                console.log("Failed with state: " + state);
            }
            this.checkIsLastPage(component, event, helper);
        });
        
        $A.enqueueAction(action);
    },
    getAppointment : function(component, event) {
        debugger;
        var action = component.get("c.getAppointments");
        action.setParams({
            'pageSize' : component.get("v.pageSize"),
            'pageNumber' : component.get("v.pageNumber"),
            "contactId": component.get("v.recordId")
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
    myHelperFunction: function(component) {
        debugger;
        var action = component.get("c.getHelpFaqs");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.questionsAndAnswers", response.getReturnValue());
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
                // Handle error or display a message to the user
            }
        });
        $A.enqueueAction(action);
    },
    contactUsInfo: function(component) {
        debugger;
        var action = component.get("c.getContactUs");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contactUs", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    checkIsLastPage:function(component, event, helper) {
        debugger;
        var pagesize = component.get("v.pageSize");
        var appList = component.get("v.appList");
        if(appList.length < pagesize || appList.length == 0){
            component.set("v.isLastPage", true);
        } else{
            component.set("v.isLastPage", false);
        }
    }
})