public class GetAppointmentController {

    @AuraEnabled()
    //Appointment Pagination 
    public static List<Appointment__c> getAppointments(Integer pageSize, Integer pageNumber,String contactId) {
        try {
            Integer offset = (pageNumber - 1) * pageSize;
            return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                    FROM Appointment__c WHERE Contact__c = :contactId 
                    LIMIT :pageSize OFFSET :offset];
        } catch(Exception e) {
            System.debug('Exception occurred in getAppointments: ' + e.getMessage());
            return new List<Appointment__c>();
        }
    }

    @AuraEnabled
    //Appointment Details 
    public static Appointment__c getAppointmentById(String appointmentId) {
        try {
            return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c ,Contact__c,Type__c
                    FROM Appointment__c 
                    WHERE Id = :appointmentId 
                    LIMIT 1];
        } catch(Exception e) {
            System.debug('Exception occurred in getAppointmentById: ' + e.getMessage());
            return null;
        }
        
    }

    @AuraEnabled
    public static List<Appointment__c> getAppointmentsByDate(Date selectedDate) {
        try {
            return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c
                    FROM Appointment__c 
                    WHERE DAY_ONLY(Appointment_Date_and_Time__c) = :selectedDate];
        } catch(Exception e) {
            System.debug('Exception occurred in getAppointmentsByDate: ' + e.getMessage());
            return new List<Appointment__c>();
        }
    }
    /*@AuraEnabled
    public static List<Appointment__c> getAppointmentss(String option, Date startDate, Date endDate) {
        if(option == 'Today') {
            startDate = Date.today();
            endDate = Date.today().addDays(1);
        }
        return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c FROM Appointment__c WHERE Appointment_Date_and_Time__c >= :startDate AND Appointment_Date_and_Time__c < :endDate];
    }*/
    @AuraEnabled
    public static List<Appointment__c> fetchAppointments(Date startDate, Date endDate) {
        if(startDate == null && endDate == null) {
            startDate = Date.today();
            endDate = Date.today();
        }
        // Query appointments based on startDate and endDate
        return [SELECT Id, Name, Appointment_Date_and_Time__c FROM Appointment__c WHERE Appointment_Date_and_Time__c >= :startDate AND Appointment_Date_and_Time__c <= :endDate];
    }
    
     @AuraEnabled
    public static void createAppointment(Appointment__c appointment, String contactId) {
       
            
            try {
                 /*if(appointment != null && contactId != null) {
            appointment.Contact__c = contactId;
                insert appointment;
                 }*/
                
            } catch(Exception e) {
                System.debug('Error inserting appointment: ' + e.getMessage());
                throw new AuraHandledException('Error inserting appointment: ' + e.getMessage());
            }
         
    }
    @AuraEnabled
    public static List<Appointment__c> getAppointmentsForToday() {
        Date today = Date.today();
        return [SELECT  Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c FROM Appointment__c WHERE Appointment_Date_and_Time__c = :today];
    }
    
    @AuraEnabled
    public static List<Appointment__c> getAppointmentsByDateRange(Date startDate, Date endDate) {
        return [SELECT Id, Name, Appointment_Date_and_Time__c, Subject__c, Description__c,Contact__c,Type__c FROM Appointment__c WHERE Appointment_Date_and_Time__c >= :startDate AND Appointment_Date_and_Time__c <= :endDate];
    }

}