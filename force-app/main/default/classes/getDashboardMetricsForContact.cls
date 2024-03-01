public without sharing class getDashboardMetricsForContact {
    
    @AuraEnabled
    public static DashboardMetricsWrapper getDashboardMetricsForContact(Integer pageSize, Integer pageNumber,string contactId,String getData) { 
        system.debug('contactId'+contactId);
        system.debug('getData'+getData);
        system.debug('UserInfo.getOrganizationId()'+UserInfo.getOrganizationId());
        DashboardMetricsWrapper metrics = new DashboardMetricsWrapper(); 
        try {
            Integer offset = (pageNumber - 1) * pageSize;
            List<Appointment__c> appointments = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                 FROM Appointment__c WHERE Contact__c = :contactId  ]; 
            if(appointments.size()>0){
                for (Appointment__c appt : appointments) {
                    metrics.totalAppointments++; 
                    system.debug('metrics.totalAppointments'+metrics.totalAppointments);
                    if (appt.Appointment_Status__c == 'In Progress') metrics.inProgressAppointments++; 
                    if (appt.Appointment_Status__c == 'Upcoming') metrics.upcomingAppointments++; 
                    if (appt.Appointment_Status__c == 'Cancelled' || appt.Appointment_Status__c == 'Rescheduled') metrics.cancelledOrRescheduledAppointments++; 
                } 
            }
            List<Appointment__c> gettotalAppointmentsList =new List<Appointment__c>();
            List<Appointment__c> getInProgressAppointmentsList=new List<Appointment__c> ();
            List<Appointment__c> getUpcomingAppointmentsList=new List<Appointment__c> ();
            List<Appointment__c> getCancelledAppointmentsList=new List<Appointment__c> ();
            if(getData=='AllData' || getData=='TotalAppointment'){
                 gettotalAppointmentsList = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                             FROM Appointment__c WHERE Contact__c = :contactId  ORDER BY Appointment_Date_and_Time__c DESC
                                                             LIMIT :pageSize OFFSET :offset];
            }
            if(getData=='AllData' || getData=='InProgress'){
                getInProgressAppointmentsList = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                                  FROM Appointment__c WHERE Appointment_Status__c = 'In Progress' AND Contact__c = :contactId  ORDER BY Appointment_Date_and_Time__c DESC
                                                                  LIMIT :pageSize OFFSET :offset];  
            }
            
            if(getData=='AllData' || getData=='getUpcomingAppointmentsList'){
                getUpcomingAppointmentsList = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                                FROM Appointment__c WHERE Appointment_Status__c = 'Upcoming' AND Contact__c = :contactId  ORDER BY Appointment_Date_and_Time__c DESC
                                                                LIMIT :pageSize OFFSET :offset];
            }
            
            if(getData=='AllData' || getData=='getCancelledAppointmentsList'){
                 getCancelledAppointmentsList = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                                 FROM Appointment__c WHERE (Appointment_Status__c = 'Cancelled' OR Appointment_Status__c = 'Rescheduled') AND Contact__c = :contactId  ORDER BY Appointment_Date_and_Time__c DESC
                                                                 LIMIT :pageSize OFFSET :offset];
            }
            
            
            system.debug('appointments'+appointments);
            
            
            
            if(gettotalAppointmentsList.size()>0){
                system.debug('gettotalAppointmentsList.size()-->'+gettotalAppointmentsList.size());
                metrics.totalAppointmentsList = gettotalAppointmentsList;
            }
            if(getInProgressAppointmentsList.size()>0){
                system.debug('getInProgressAppointmentsList.size()-->'+getInProgressAppointmentsList.size());
                metrics.inProgressAppointmentsList = getInProgressAppointmentsList;
            }
            if(getUpcomingAppointmentsList.size()>0){
                system.debug('getUpcomingAppointmentsList.size()-->'+getUpcomingAppointmentsList.size());
                metrics.UpcomingAppointmentsList = getUpcomingAppointmentsList;
            }
            if(getCancelledAppointmentsList.size()>0){
                system.debug('getCancelledAppointmentsList.size()-->'+getCancelledAppointmentsList.size());
                metrics.cancelledAppointmentsList = getCancelledAppointmentsList;
            }
            if(metrics !=null){
                return metrics; 
            }
            
            List<Case__c> cases = [SELECT Id, Status__c,Contact__c FROM Case__c WHERE Contact__c = :contactId]; 
            List<Case__c> getTotalcases = [SELECT Id, Status__c,Contact__c FROM Case__c WHERE Contact__c = :contactId]; 
            List<Case__c> getresolvedcasesList = [SELECT Id, Status__c,Contact__c FROM Case__c WHERE Contact__c = :contactId AND Status__c='Resolved']; 
            List<Case__c> getpendingcasesList = [SELECT Id, Status__c,Contact__c FROM Case__c WHERE Contact__c = :contactId AND Status__c='Pending'];
            List<Case__c> getescalatedcasesList = [SELECT Id, Status__c,Contact__c FROM Case__c WHERE Contact__c = :contactId AND Status__c='Escalated'];
            
            if(cases.size()>0){
                for (Case__c cs : cases) { 
                    metrics.totalCases++; 
                    if (cs.Status__c == 'Resolved') metrics.resolvedCases++; 
                    if (cs.Status__c == 'Pending') metrics.pendingCases++; 
                    if (cs.Status__c == 'Escalated') metrics.escalatedCases++; 
                } 
            }
            if(getTotalcases.size()>0){
                system.debug('getTotalcases.size()-->'+getTotalcases.size());
                metrics.totalCasesList = getTotalcases;
            }
            if(getresolvedcasesList.size()>0){
                system.debug('getresolvedcasesList.size()-->'+getresolvedcasesList.size());
                metrics.resolvedcasesList = getresolvedcasesList;
            }
            if(getpendingcasesList.size()>0){
                system.debug('getpendingcasesList.size()-->'+getpendingcasesList.size());
                metrics.pendingcasesList = getpendingcasesList;
            }
            if(getescalatedcasesList.size()>0){
                system.debug('getescalatedcasesList.size()-->'+getescalatedcasesList.size());
                metrics.escalatedcasesList = getescalatedcasesList;
            }
            system.debug('metrics -- ' + metrics);
        }catch (Exception e) {
            System.debug('An error occurred: ' + e.getMessage());
        }
        return metrics; 
        
    } 
    
    @AuraEnabled
    public static DashboardMetricsWrapper getAppointmentByStatusContact(Id contactId) { 
        DashboardMetricsWrapper metrics = new DashboardMetricsWrapper(); 
        try {
            List<Appointment__c> appointments = [SELECT Id, Name,Appointment_Status__c, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                                                             FROM Appointment__c WHERE Contact__c = :contactId];
            if(appointments.size()>0){
                for (Appointment__c appt : appointments) {
                    metrics.totalAppointments++; 
                    system.debug('metrics.totalAppointments'+metrics.totalAppointments);
                    if (appt.Appointment_Status__c == 'In Progress') metrics.inProgressAppointments++; 
                    if (appt.Appointment_Status__c == 'Upcoming') metrics.upcomingAppointments++; 
                    if (appt.Appointment_Status__c == 'Cancelled' || appt.Appointment_Status__c == 'Rescheduled') metrics.cancelledOrRescheduledAppointments++; 
                } 
            }
                        
        }catch (Exception e) {
            System.debug('An error occurred: ' + e.getMessage());
        }
        return metrics; 
    }
    
    @AuraEnabled
    //Appointment Pagination 
    public static List<Appointment__c> getAppointments(Integer pageSize, Integer pageNumber,String contactId) {
        try {
            Integer offset = (pageNumber - 1) * pageSize;
            return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                    FROM Appointment__c WHERE Contact__c = :contactId 
                    ORDER BY Appointment_Date_and_Time__c DESC
                    LIMIT :pageSize OFFSET :offset];
        } catch(Exception e) {
            System.debug('Exception occurred in getAppointments: ' + e.getMessage());
            return new List<Appointment__c>();
        }
    }
    
    @AuraEnabled
    // Help & FAQ 
    public static list<HelpFaqMetadata__mdt> getHelpFaqs(){ 
        try {
            List<HelpFaqMetadata__mdt> questionList = new List<HelpFaqMetadata__mdt>();
            questionList = [SELECT Id, Question__c, Answer__c FROM HelpFaqMetadata__mdt];
            system.debug('questionList ====> '+questionList);
            return questionList;
        } 
        catch (Exception e) {
            System.debug('An error occurred while fetching FAQs: ' + e.getMessage() + ' at Line Number :: ' + e.getLineNumber());
            return null;
        }
    }
    
    @AuraEnabled
    // Contact Us
    public static Contact_Us__mdt getContactUs(){ 
        try {
            /*List<Contact_Us__mdt> contactUsList = new List<Contact_Us__mdt>();
contactUsList = [SELECT Id, Email__c, Phone__c, Address__c FROM Contact_Us__mdt];
system.debug('contactUsList ====> '+contactUsList);
return contactUsList;*/
            Contact_Us__mdt contactUsRecord = [SELECT Id, Email__c, Phone__c, Address__c FROM Contact_Us__mdt LIMIT 1];
            return contactUsRecord;
        } 
        catch (Exception e) {
            System.debug('An error occurred while fetching FAQs: ' + e.getMessage() + ' at Line Number :: ' + e.getLineNumber());
            return null;
        }
    }
    
    @AuraEnabled
    //Join Meeting 
    public static String getMeetingLink(Id appointmentId) {
        Appointment__c appointment = [SELECT Meeting_Link__c FROM Appointment__c WHERE Id = :appointmentId LIMIT 1];
        return appointment.Meeting_Link__c;
    }
}