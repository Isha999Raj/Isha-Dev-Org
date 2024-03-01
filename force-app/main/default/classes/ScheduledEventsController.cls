public without sharing class ScheduledEventsController {

@AuraEnabled
public static List<Booked_Slot__c> getAllBookingSlots(string userId){
try{
    system.debug('userIdsss ===> '+userId);
    List<Booked_Slot__c> listOfAllBookingSlots = [SELECT Id,Name,Start_Time__c,End_Time__c,Meeting_Description__c,Availability__c,Email__c,Status__c,Meeting_Link__c,Date__c FROM Booked_Slot__c WHERE OwnerId =: userId];
    system.debug('listOfAllBookingSlots ==> '+listOfAllBookingSlots);
    return listOfAllBookingSlots;
}catch(Exception e){
    return null;
}
}

@AuraEnabled(cacheable=true)
public static List<Booked_Slot__c> getFilteredBookedSlots(string startTime, string endTime, string startDate, string endDate, string userId) {

String queryString = 'SELECT Id,Name,Start_Time__c,End_Time__c,Meeting_Description__c,Availability__c,Email__c,Status__c,Meeting_Link__c,Date__c FROM Booked_Slot__c WHERE OwnerId =: userId ';
Time startTime1 = null;
Time endTime1 = null;
Date startDate1 = null;
Date endDate1 = null;
if(startTime != null && startTime != ''){
    Integer sHours = Integer.valueOf(startTime.split(':')[0]);
Integer sMins = Integer.valueOf(startTime.split(':')[1]);
startTime1 = Time.newInstance(sHours,sMins,0,0);
system.debug('startTime1 ===> '+startTime1);
}
if(endTime != null && endTime != ''){
    Integer eHours = Integer.valueOf(endTime.split(':')[0]);
Integer eMins = Integer.valueOf(endTime.split(':')[1]); 
endTime1 = Time.newInstance(eHours,eMins,0,0);
system.debug('endTime1 ===> '+endTime1);
}
if(startDate != null && startDate != ''){
    startDate1 = Date.valueOf(startDate);
    system.debug('startDate1 ===> '+startDate1);
}
if(endDate != null && endDate != ''){
endDate1 = Date.valueOf(endDate);
system.debug('endDate1 ===> '+endDate1);
}

if(startDate1 != null && endDate1 != null && startTime1 != null && endTime1 != null){
    queryString += 'AND Date__c >=: startDate1 AND Date__c <=: endDate1 AND Start_Time__c>=: startTime1 AND End_Time__c <=: endTime1';
}else if(startDate1 != null && endDate1 == null && startTime1 != null && endTime1 != null){
    queryString += 'AND Date__c =: startDate1 AND Start_Time__c>=: startTime1 AND End_Time__c <=: endTime1';
}else if(startDate1 != null && endDate1 != null && startTime1 == null && endTime1 == null){
    queryString += 'AND Date__c >=: startDate1 AND Date__c <=: endDate1';
}
System.debug('queryString==> ' + queryString);

    //List<Booked_Slot__c> listOfBookingSlots = [SELECT Id,Name,Start_Time__c,End_Time__c,Meeting_Description__c,Availability__c,Email__c,Status__c,Meeting_Link__c,Date__c FROM Booked_Slot__c WHERE Start_Time__c >= :startTime1 AND End_Time__c <= :endTime1 ORDER BY Start_Time__c];
    List<Booked_Slot__c> listOfBookingSlots = Database.Query(queryString);
    system.debug('listOfBookingSlots ===> '+listOfBookingSlots);
    return listOfBookingSlots;
}

@AuraEnabled
public static string updateStatus(String bookedSlotId , String statusVal){
    try{
        system.debug('bookedSlotId ====> '+bookedSlotId);
        List<Booked_Slot__c> listOfBookedSlot = [SELECT Id,Name,Start_Time__c,End_Time__c,Meeting_Description__c,Availability__c,Email__c,Status__c,Meeting_Link__c,Date__c FROM Booked_Slot__c WHERE Id =: bookedSlotId];
        if(!listOfBookedSlot.isEmpty()){
            listOfBookedSlot[0].Status__c = statusVal;
            update listOfBookedSlot[0];
        }
        return 'SUCCESS';
    }catch(Exception e){
        return 'ERROR';
    }
}

@AuraEnabled
public static string rescheduleMeeting(Booked_Slot__c ct, String startTime, String endTime, String bsId){
    try{
        System.debug('ct ====> '+ct);
        System.debug(' ct.Date__c ====> '+ ct.Date__c);
            System.debug('startTime ====> '+startTime);
        System.debug('endTime ====> '+endTime);
        System.debug('bsId ====> '+bsId);
        Booked_Slot__c bookedSlotRec = [SELECT Id, Date__c, OwnerId FROM Booked_Slot__c WHERE Id=:bsId];
        User userRec = [SELECT Id, Name, CreatedDate FROM User WHERE Id =: bookedSlotRec.OwnerId LIMIT 1];

        Date startDate = Date.valueOf(userRec.CreatedDate);
        Date endDate = startDate.addYears(1);

        if(startDate != null && endDate != null){
            if(startDate > ct.Date__c || endDate < ct.Date__c ){
                return 'Availability Error';
            }else{
                ct.Id = bsId;
            Integer sHours = Integer.valueOf(startTime.split(':')[0]);
            Integer sMins = Integer.valueOf(startTime.split(':')[1]);

            Integer eHours = Integer.valueOf(endTime.split(':')[0]);
            Integer eMins = Integer.valueOf(endTime.split(':')[1]);

            ct.Start_Time__c = Time.newInstance(sHours,sMins,0,0);
            ct.End_Time__c = Time.newInstance(eHours,eMins,0,0);

            system.debug('Updated ct ====> '+ct);
            update ct;

            Booked_Slot__c bsRecord = [SELECT Id,Name,Start_Time__c,End_Time__c,Meeting_Description__c,Availability__c,Email__c,Status__c,Meeting_Link__c,Date__c FROM Booked_Slot__c WHERE Id =: ct.Id];
            Emailtemplate emailTempRec =  [Select Id,HtmlValue,Subject from EmailTemplate where Name ='Reschedule Email Template'];
            List<Messaging.SingleEmailMessage> emailsList = new List<Messaging.SingleEmailMessage>();
            Id orgWideEmailAddressId = [SELECT Id FROM OrgWideEmailAddress ].Id;

            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setOrgWideEmailAddressId(orgWideEmailAddressId);
            mail.setToAddresses(new String[] {bsRecord.Email__c});
            mail.setSubject(emailTempRec.Subject);
            string emailHtmlValue = emailTempRec.HtmlValue;

            if(!string.isBlank(bsRecord.Name)){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.Name}', bsRecord.Name);
            }
            if(bsRecord.Date__c != null){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.Date__c}', String.valueOf(bsRecord.Date__c));
            }
            if(bsRecord.Start_Time__c != null){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.Start_Time__c}', String.valueOf(bsRecord.Start_Time__c));
            }
            if(bsRecord.End_Time__c != null){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.End_Time__c}', String.valueOf(bsRecord.End_Time__c));
            }
            if(!string.isBlank(bsRecord.Meeting_Description__c)){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.Meeting_Description__c}', bsRecord.Meeting_Description__c);
            }
            if(!string.isBlank(bsRecord.Meeting_Link__c)){
                emailHtmlValue = emailHtmlValue.replace('{!Booked_Slot__c.Meeting_Link__c}', bsRecord.Meeting_Link__c);
            }

            mail.setHtmlBody(emailHtmlValue);//Set HTML Body
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

            return 'SUCCESS';
            }
        }else{
            return 'No availability Found';
        }
            
    }catch(Exception e){
        System.debug('Error Message --> ' + e.getMessage() + 'At Line Number-->' + e.getLineNumber());
        return 'ERROR';
    }
}
}