public without sharing class CalenderController {
    
    @AuraEnabled
    public static Map<String,Object> getUserEvents(String userId){
        try {
            Map<String,Object> responseMap = new Map<String,Object>();

            List<Availability__c> avList = [Select Id,Name From Availability__c Where OwnerId=:userId];
            User u = [Select Id,Name,Email From User Where Id=:userId];

            responseMap.put('events',avList);
            responseMap.put('user',u);

            return responseMap;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getUserEvents', e, null);
            throw new AuraHandledException(e.getMessage());
            
        }
    }


    @AuraEnabled
    public static Map<String,Object> getCalendarType(String userId, String searchString){
        try {
            system.debug('userId =====> '+userId);
            System.debug('searchString-->'+searchString);
            String searchFinalString = '%' + searchString + '%';
            System.debug('searchFinalString-->' + searchFinalString);
            Map<String,Object> responseMap = new Map<String,Object>();

            List<Calender_Type__c> avList = [Select Id,Name,Calendar_Link__c,Slot_Duration__c,Start_Time__c,End_Time__c,Occurence__c  From Calender_Type__c Where OwnerId=:userId AND NAME LIKE :searchFinalString];
            system.debug('avList ----> '+avList);
            List<User> u = [Select Id,Name,Email,Appointment_Type__c From User Where Id=:userId LIMIT 1];
            
            system.debug('u =====> '+u);
            
            responseMap.put('events',avList);
            if(u != null && !u.isEmpty())
                responseMap.put('user',u[0]);
            
            return responseMap;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getCalendarType', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Map<String,Object> getCalendarType2(String usId){
        try {
            system.debug('userId =====> '+usId);
            Map<String,Object> responseMap = new Map<String,Object>();
            
            List<Calender_Type__c> avList = [Select Id,Name,Calendar_Link__c,Slot_Duration__c,Start_Time__c,End_Time__c,Occurence__c,Event_Start_Date__c,Event_End_Date__c,OwnerId  From Calender_Type__c Where OwnerId=:usId];
            system.debug('avList =====> '+avList);
            List<User> u = [Select Id,Name,ProfileId From User Where Id=:usId LIMIT 1];
            system.debug('u =====> '+u);
            
            responseMap.put('events',avList);
            responseMap.put('user',u[0]);
            system.debug('responseMap =====> '+responseMap);
            return responseMap;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getCalendarType', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }
    

    @AuraEnabled(cacheable=true)
    public static Map<String,Object> getCalendarsUserInfo(String userId, String searchString){
        try {
            return getCalendarType(userId, searchString);
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getCalendarsUserInfo', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static Map<String,Object> checkAvailibility(String cId){
        try {
            Map<String,Object> respMap = new Map<String,Object>();

            Calender_Type__c cType = [Select Id,Name,Start_Time__c,End_Time__c,Calendar_Link__c,Slot_Duration__c,Before_Gap__c,After_Gap__c,Owner.Name,OwnerId From Calender_Type__c Where Id=:cId];
            System.debug('cType====>'+cType);
            System.debug('cType====>'+cType.OwnerId);
            List<Availability__c> avList = [Select Id,Name,Date__c,Start_Time__c,End_Time__c From Availability__c Where OwnerId=:cType.OwnerId];
            System.debug('avList====>'+avList);
            System.debug('avList.size()====>'+avList.size());
            User user = [Select Id,Name From User Where Id=:cType.OwnerId];
            System.debug('user====>'+user);

            respMap.put('availibility',avList);
            respMap.put('cdetails',cType);
            respMap.put('user',user);
            respMap.put('startTime',String.valueOf(cType.Start_Time__c));
            respMap.put('endTime',String.valueOf(cType.End_Time__c));
            System.debug('respMap===>'+respMap);
            return respMap;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','checkAvailibility', e, null);

            throw new AuraHandledException(e.getMessage());
        }
    }


    // @AuraEnabled
    // public static string createBookSlot(Booked_Slot__c bookedSlot, Long sLongTime, Long eLongTime){
    //     try {

    //         System.debug('sLongTime----'+sLongTime);
    //         System.debug('eLongTime----'+eLongTime);
            
    //         Availability__c av = [Select Id,Date__c From Availability__c Where Id=:bookedSlot.Availability__c];

    //         Time startTime = createTime(sLongTime);
    //         Time endTime = createTime(eLongTime);

    //         bookedSlot.Start_Time__c = startTime;
    //         bookedSlot.End_Time__c = endTime;
    //         bookedSlot.Date__c = av.Date__c;

    //         insert bookedSlot;

    //        GMeetAPIHandler.generateMeetLink_V2(bookedSlot.Id);
    //         return 'Success';

    //     } catch (Exception e) {
    //         System.debug(' the Error has occured due to =====> ' + e.getMessage());
    //         System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
    //         HandleBusinessException.captureError('CalenderController','createBookSlot', e, null);
    //         throw new AuraHandledException(e.getMessage());
    //     }
    // }

    @AuraEnabled
    public static Map<Integer,String> checkEventAvailibilityDays(String cId){
        System.debug('cId===>'+cId);
        try {            
            Calender_Type__c cType = [Select Id,Name,Start_Time__c,Event_Start_Date__c,Event_End_Date__c,End_Time__c,Calendar_Link__c,Slot_Duration__c,Before_Gap__c,After_Gap__c,Occurence__c,Owner.Name,OwnerId From Calender_Type__c Where Id=:cId LIMIT 1];
            System.debug('cType====>'+cType);
            List<String> occurenceDays = cType.Occurence__c.split(';');
            System.debug('occurenceDays===>'+occurenceDays);
            Set<Integer> occurenceDaysNumber = new Set<Integer>();
            Map<Integer,String> occDayNumberByDayName = new Map<Integer,String>();
            for(String occStr : occurenceDays){
                if(occStr == 'Daily'){
                    occurenceDaysNumber.add(6);
                    occDayNumberByDayName.put(6,occStr);
                    occDayNumberByDayName.put(5,occStr);
                    occDayNumberByDayName.put(4,occStr);
                    occDayNumberByDayName.put(3,occStr);
                    occDayNumberByDayName.put(2,occStr);
                    occDayNumberByDayName.put(1,occStr);
                    occDayNumberByDayName.put(0,occStr);
                }
                else if(occStr == 'Sunday'){
                    occurenceDaysNumber.add(0);
                    occDayNumberByDayName.put(0,occStr);
                }else if(occStr == 'Monday'){
                    occurenceDaysNumber.add(1);
                    occDayNumberByDayName.put(1,occStr);
                }else if(occStr == 'Tuesday'){
                    occurenceDaysNumber.add(2);
                    occDayNumberByDayName.put(2,occStr);
                }
                else if(occStr == 'Wednesday'){
                    occurenceDaysNumber.add(3);
                    occDayNumberByDayName.put(3,occStr);
                }
                else if(occStr == 'Thursday'){
                    occurenceDaysNumber.add(4);
                    occDayNumberByDayName.put(4,occStr);
                }
                else if(occStr == 'Friday'){
                    occurenceDaysNumber.add(5);
                    occDayNumberByDayName.put(5,occStr);
                }
                else if(occStr == 'Saturday'){
                    occurenceDaysNumber.add(6);
                    occDayNumberByDayName.put(6,occStr);
                }
            }    
            System.debug('occurenceDaysNumber======>'+occurenceDaysNumber);
            System.debug('occDayNumberByDayName==> ' + occDayNumberByDayName);        
            return occDayNumberByDayName;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','checkEventAvailibilityDays', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string createBookSlot(Booked_Slot__c bookedSlot, Long sLongTime, Long eLongTime, String hashValue){
        try {
            system.debug('hashValue ====> '+hashValue);
            List<Calender_Type__c> conList = [SELECT Id,Name,OwnerId FROM Calender_Type__c WHERE Id =: hashValue];
            system.debug('conList ====> '+conList);
            System.debug('sLongTime----'+sLongTime);
            System.debug('eLongTime----'+eLongTime);
            
            Availability__c av = [Select Id,Date__c From Availability__c Where Id=:bookedSlot.Availability__c];
            
            Time startTime = createTime(sLongTime);
            Time endTime = createTime(eLongTime);
            
            bookedSlot.Start_Time__c = startTime;
            bookedSlot.End_Time__c = endTime;
            bookedSlot.Date__c = av.Date__c;
            bookedSlot.OwnerId = conList[0].OwnerId;
            bookedSlot.Calender_Type__c = conList[0].Id;
            
            insert bookedSlot;
            system.debug('bookedSlot--->'+bookedSlot);
            // GMeetAPIHandler.generateMeetLink_V2(bookedSlot.Id);
            return 'Success';
            
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','createBookSlot', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static Time createTime(Long lTime){
        Long milliseconds = lTime;
        Long mins = milliseconds / 60000;
        Long hours = mins / 60;
        Long remainingMins = mins - (hours * 60);

        return Time.newInstance(hours.intValue(),remainingMins.intValue(),0,0);
        //String totalTime = String.valueOf(hours) + ' hrs ' +  String.valueOf(remainingMins) +' mins';
    }



    @AuraEnabled
    public static List<Booked_Slot__c> getBookedSlotForParticularDate(String cId, integer year, integer month, integer day){
        try {
            Date lookingOn = Date.newInstance(year, month, day);

            Calender_Type__c cType = [Select Id,Name,Start_Time__c,End_Time__c,Calendar_Link__c,Slot_Duration__c,Before_Gap__c,After_Gap__c,Owner.Name,OwnerId From Calender_Type__c Where Id=:cId];
            return [Select Id,Name,Date__c,Start_Time__c,End_Time__c From Booked_Slot__c Where OwnerId=:cType.OwnerId And Date__c =: lookingOn];
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getBookedSlotForParticularDate', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string createEvent(Calender_Type__c ct, String startTime, String endTime, String userId){
        try {
            Integer sHours = Integer.valueOf(startTime.split(':')[0]);
            Integer sMins = Integer.valueOf(startTime.split(':')[1]);

            Integer eHours = Integer.valueOf(endTime.split(':')[0]);
            Integer eMins = Integer.valueOf(endTime.split(':')[1]);

            ct.Start_Time__c = Time.newInstance(sHours,sMins,0,0);
            ct.End_Time__c = Time.newInstance(eHours,eMins,0,0);
            insert ct;

            BatchToInsertAvailabilitiesRecords batchClass = new BatchToInsertAvailabilitiesRecords(ct);
            Database.executeBatch(batchClass);

            return 'Success';
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','createEvent', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static eventTypeWrapper getUserAppointmentType(String userId) {
        User userRecord = [SELECT Id, Appointment_Type__c FROM User WHERE Id = :userId LIMIT 1];
        system.debug('userRecord ====> '+userRecord);

        BusinessHours businessHoursRecord = [SELECT FridayEndTime,FridayStartTime,Id,IsActive,IsDefault,LastModifiedById,LastModifiedDate,
        LastViewedDate,MondayEndTime,MondayStartTime,Name,SaturdayEndTime,SaturdayStartTime,SundayEndTime,SundayStartTime,SystemModstamp,ThursdayEndTime,
        ThursdayStartTime,TimeZoneSidKey,TuesdayEndTime,TuesdayStartTime,WednesdayEndTime,WednesdayStartTime FROM BusinessHours];
        system.debug('businessHoursRecord ===> '+businessHoursRecord);
        
        eventTypeWrapper etWrap = New eventTypeWrapper();
        etWrap.userRecord = userRecord;
        etWrap.bhRecord = businessHoursRecord;
        system.debug('etWrap 12 ====> '+etWrap);
        return etWrap;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String,List<String>> getPicklistFieldsValues(String objName, List<String> fieldList){
        try {
            Map<String,List<String>> fieldMap = new Map<String,List<String>>();

            for(String f : fieldList){
                List<String> fList = getPicklistValues(objName,f);
                fieldMap.put(f,fList);
            }
            return fieldMap;
        } catch (Exception e) {
            System.debug(' the Error has occured due to =====> ' + e.getMessage());
            System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
            HandleBusinessException.captureError('CalenderController','getPicklistFieldsValues', e, null);
            throw new AuraHandledException(e.getMessage());
        }
    }


    public static List<String> getPicklistValues(String ObjectApi_name,String Field_name){ 
        try{
        
        List<String> lstPickvals                        = new List<String>();
        Schema.SObjectType targetType                   = Schema.getGlobalDescribe().get(ObjectApi_name);
        Sobject Object_name                             = targetType.newSObject();
        Schema.sObjectType sobject_type                 = Object_name.getSObjectType(); 
        Schema.DescribeSObjectResult sobject_describe   = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map      = sobject_describe.fields.getMap();
        List<Schema.PicklistEntry> pick_list_values     = field_map.get(Field_name).getDescribe().getPickListValues();
        
        for (Schema.PicklistEntry a : pick_list_values) {
            
            lstPickvals.add(String.ValueOf(a.getValue()));  
        }
        return lstPickvals;
    }catch (Exception e) {
        System.debug(' the Error has occured due to =====> ' + e.getMessage());
        System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
        HandleBusinessException.captureError('CalenderController','getPicklistValues', e, null);
         return null;
    }
}

public class eventTypeWrapper{
    @AuraEnabled
    public User userRecord;
    @AuraEnabled
    public BusinessHours bhRecord;
}
}