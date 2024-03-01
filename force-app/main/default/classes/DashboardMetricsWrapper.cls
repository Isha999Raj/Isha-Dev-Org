public without sharing class DashboardMetricsWrapper {
    @AuraEnabled
    public Integer totalAppointments {get; set;} 
    @AuraEnabled
    public Integer inProgressAppointments {get; set;}
    @AuraEnabled
    public Integer upcomingAppointments {get; set;} 
    @AuraEnabled
    public Integer cancelledOrRescheduledAppointments {get; set;} 
    @AuraEnabled
    public Integer totalCases {get; set;} 
    @AuraEnabled
    public Integer resolvedCases {get; set;} 
    @AuraEnabled
    public Integer pendingCases {get; set;} 
    @AuraEnabled
    public Integer escalatedCases {get; set;} 
    @AuraEnabled
    public List<Appointment__c> totalAppointmentsList {get;set;}
    @AuraEnabled
    public List<Appointment__c> inProgressAppointmentsList {get;set;}
    @AuraEnabled
    public List<Appointment__c> UpcomingAppointmentsList {get;set;}
    @AuraEnabled
    public List<Appointment__c> cancelledAppointmentsList {get;set;}
    @AuraEnabled
    public List<Case__c> totalCasesList {get;set;}
    @AuraEnabled
    public List<Case__c> resolvedcasesList {get;set;}
    @AuraEnabled
    public List<Case__c> pendingcasesList {get;set;}
    @AuraEnabled
    public List<Case__c> escalatedcasesList {get;set;}
        
    public DashboardMetricsWrapper() { 
        totalAppointments = 0; 
        inProgressAppointments = 0; 
        upcomingAppointments = 0; 
        cancelledOrRescheduledAppointments = 0; 
        totalCases = 0; 
        resolvedCases = 0; 
        pendingCases = 0; 
        escalatedCases = 0; 
    } 
}