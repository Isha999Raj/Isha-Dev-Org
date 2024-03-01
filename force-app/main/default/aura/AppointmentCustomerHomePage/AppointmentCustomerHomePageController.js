({
    doinit: function(component, event, helper) {
        debugger;
        component.set("v.showMainHome",true);
        var loggedInUserId = $A.get("$SObjectType.CurrentUser.Id");
        console.log('loggedInUserId', loggedInUserId);
        
        helper.getMetricsData(component, event, helper,'AllData');
        helper.myHelperFunction(component);
        helper.contactUsInfo(component);
        
        var baseURL = $A.get("$Label.c.orgBaseURLforVFPages");
        debugger;
        baseURL = baseURL + 'apex/LeadDocumentViewrPage?id=';
        component.set("v.siteURL", baseURL);
    },
    handleNext : function(component, event, helper) { 
        debugger;
        var CurrentDataStatusvalue=component.get("v.CurrentDataStatusvalue");
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.getMetricsData(component, event, helper,CurrentDataStatusvalue);
    },
    
    handlePrev : function(component, event, helper) {   
        debugger;
        var CurrentDataStatusvalue=component.get("v.CurrentDataStatusvalue");
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.getMetricsData(component, event, helper,CurrentDataStatusvalue);
    },
    navigateToComponent: function(component, event, helper) { 
        debugger;
        var appList = [];
        component.set("v.showTotalAppointment",true);
        component.set("v.showMainHome",false);
        var status = event.target.getAttribute('data-status');
        component.set("v.CurrentDataStatusvalue",status)
        if(status == 'TotalAppointment'){
            var totalAppList = component.get("v.TotalAppList");
            component.set("v.appList",totalAppList);
            component.set("v.dataSize", progressAppList.length);
            component.set("v.CurrentDataStatusvalue",status);
            component.set("v.pageSize",10);
            component.set("v.pageNumber",1);
        }
        else if(status == 'InProgress'){
            var progressAppList = component.get("v.inProgressAppList");
            component.set("v.appList",progressAppList);
            component.set("v.dataSize", progressAppList.length);
            component.set("v.CurrentDataStatusvalue",status);
            component.set("v.pageSize",10);
            component.set("v.pageNumber",1);
            
        }
            else if(status == 'Upcoming'){
                var upcomingAppList = component.get("v.upComingAppList");
                component.set("v.appList",upcomingAppList);
                component.set("v.dataSize", upcomingAppList.length);
                component.set("v.CurrentDataStatusvalue",status);
                component.set("v.pageSize",10);
                component.set("v.pageNumber",1);
            }
                else if(status == 'CancelledOrRescheduled'){
                    var cancellAppList = component.get("v.cancelledAppList");
                    component.set("v.appList",cancellAppList);
                    component.set("v.dataSize", cancellAppList.length);
                    component.set("v.CurrentDataStatusvalue",status);
                    component.set("v.pageSize",10);
                    component.set("v.pageNumber",1);
                }
        helper.checkIsLastPage(component, event, helper);
        
    },
    backButton : function(component, event, helper) {
        debugger;
        component.set("v.showMainHome",true);
        component.set("v.showTotalAppointment",false);
        
        var totalAppList = component.get("v.TotalAppList");
        component.set("v.appList",totalAppList);
        component.set("v.dataSize", totalAppList.length);
        component.set("v.CurrentDataStatusvalue",'AllData');
        component.set("v.pageSize",10);
        component.set("v.pageNumber",1);
        helper.getMetricsData(component, event, helper,'AllData');
        helper.checkIsLastPage(component, event, helper);
    }
})