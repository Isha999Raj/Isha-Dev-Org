trigger TriggerOnAppointment on Appointment__c (before insert,after insert) {

    if(trigger.isAfter && trigger.isInsert){
        LeadDocumentViewr.createDocscategoryforAppointment(trigger.new);
    }
}