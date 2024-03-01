global without sharing class BatchToInsertAvailabilitiesRecords implements Database.Batchable<sObject>{
 

    private Calender_Type__c calenderType;
    public BatchToInsertAvailabilitiesRecords(Calender_Type__c calenderType){
        this.calenderType = calenderType;
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        Calender_Type__c cType = calenderType;
        return Database.getQueryLocator([SELECT Id,Name,Event_Start_Date__c,Event_End_Date__c,Start_Time__c,End_Time__c,Before_Gap__c,After_Gap__c,Slot_Duration__c,OwnerId,Owner.Name FROM Calender_Type__c WHERE Id =:cType.Id]);
    }
 

    global void execute(Database.BatchableContext BC, List<Calender_Type__c> listOfCalendarTypes){
		System.debug('listOfCalendarTypes===>'+listOfCalendarTypes);
        List<Availability__c> Av=new List<Availability__c>();
        set<Id> allAvlIds = new set<Id>();
        List<Available_Slots__c> allAvailableSlots = new List<Available_Slots__c>();
        Map<Id,Availability__c>  allAvailabilites = new Map<Id,Availability__c>();
       
            Date startdate = listOfCalendarTypes[0].Event_Start_Date__c;
            Date enddate =  listOfCalendarTypes[0].Event_End_Date__c;
            System.debug('startdate====>'+startdate);
            System.debug('enddate====>'+enddate);
            
        for (Date currentDate = startDate; currentDate <= endDate; currentDate = currentDate.addDays(1)) {
                Availability__c avlRecord = new Availability__c();
                avlRecord.Name = listOfCalendarTypes[0].Owner.Name+'-'+currentDate.format();
                avlRecord.Date__c = currentDate;
                avlRecord.Start_Time__c = listOfCalendarTypes[0].Start_Time__c;
                avlRecord.End_Time__c = listOfCalendarTypes[0].End_Time__c;
                avlRecord.OwnerId = listOfCalendarTypes[0].OwnerId;
                avlRecord.Calender_Type__c = listOfCalendarTypes[0].Id; 
                Av.add(avlRecord);
                  
        }
        System.debug('Av====>'+Av);
        insert Av;
        
        List<Availability__c> ListOfAvailabilities = [select Id,Name,Calender_Type__c,Date__c,Start_Time__c,End_Time__c,Month__c from Availability__c where Calender_Type__c =: listOfCalendarTypes[0].Id];
        
        for(Availability__c avli: ListOfAvailabilities){
            allAvailabilites.put(avli.Id,avli);
        }
        System.debug(allAvailabilites);
        
        for (Id avlId : allAvailabilites.keySet()) {
            Availability__c availabilityRecord = allAvailabilites.get(avlId);
            System.debug('Record Id: ' + avlId);
            System.debug('Availability Record: ' + availabilityRecord);
            
            Time startD = listOfCalendarTypes[0].Start_Time__c; //10:00:00Am
            Integer startMinutes;
            System.debug('startD===>'+startD);
            
          
            
            String startTime = String.valueOf(startD);
            String check;
            String[] timeParts = startTime.split(':');
            String hourString = timeParts[0].replaceAll('[^0-9]', '');
            String minuteString =  timeParts[1].replaceAll('[^0-9]', '');

            Integer hour = Integer.valueOf(hourString);
            Integer min = Integer.valueOf(minuteString);
            System.debug('hour ===> ' + hour);
            System.debug('min ===> ' + min);
            if(hour < 12){
                check = 'AM';
            }else if(hour == 12){
                 check = 'PM';       
            }else{
                 check = 'PM';       
            }
            System.debug('check ===> ' + check);
            if(check!='AM'){
                if(hour == 12){
                    startMinutes = hour*60 + min;
                }else{
                     startMinutes = hour*60 + min + 12*60;
                    System.debug('startMinutes===>'+startMinutes);
                }
                
            }else{
                 startMinutes = hour*60 + min;
                System.debug('startMinutes===>'+startMinutes);   
            }
             Integer slotstarting = startMinutes;
             
            Time EndD = listOfCalendarTypes[0].End_Time__c;
           
            Integer EndMinutes2;
            System.debug('EndD===>'+EndD);
            String endTime = String.valueOf(EndD);
            
            String[] timeParts2 = endTime.split(':');
            String check2;
            String hourString2 = timeParts2[0].replaceAll('[^0-9]', '');
            String minuteString2 =  timeParts2[1].replaceAll('[^0-9]', '');
           
            Integer hour2 = Integer.valueOf(hourString2);
            Integer min2 = Integer.valueOf(minuteString2);
            System.debug('hour2 ===> ' + hour2);
            System.debug('min2 ===> ' + min2);
            if(hour2 < 12){
                check2 = 'AM';
            }else if(hour == 12){
                 check2 = 'PM';       
            }else{
                 check2 = 'PM';       
            }
            System.debug('check2 ===> ' + check2);
            if(check2!='AM'){
                if(hour2 == 12){
                     EndMinutes2 = hour2*60 + min2;
                }else{
                     EndMinutes2 = hour2*60 + min2;
                    System.debug('EndMinutes2===>'+EndMinutes2);
                }
                
            }else{
                 EndMinutes2 = hour2*60 + min2;
                System.debug('EndMinutes2===>'+EndMinutes2);   
            }
            
            
 
            
             Integer slotEnding = EndMinutes2;
             String slotDurationString = listOfCalendarTypes[0].Slot_Duration__c;
            
             String slotDuration1 = slotDurationString.replaceAll('[^0-9]', '');
            Integer slotDuration = Integer.valueOf(slotDuration1);
             System.debug('slotDuration====>'+slotDuration);
            
            
             String beforeGapString = listOfCalendarTypes[0].Before_Gap__c;
            
            String beforeGap1 = beforeGapString.replaceAll('[^0-9]', '');
            Integer beforeGap = Integer.valueOf(beforeGap1);
             System.debug('beforeGap====>'+beforeGap);
            
            

             String afterGapString = listOfCalendarTypes[0].After_Gap__c;
            
            String afterGap1 = beforeGapString.replaceAll('[^0-9]', '');
            Integer afterGap = Integer.valueOf(afterGap1);
             System.debug('afterGap====>'+afterGap);

            System.debug('slotstarting====>'+slotstarting);
            System.debug('slotEnding====>'+slotEnding);
            
             while(slotstarting < slotEnding && slotEnding - slotstarting >= slotDuration +beforeGap ){
            if(slotEnding - slotstarting >= slotDuration +beforeGap){
                    slotstarting = slotstarting+beforeGap;
                	System.debug('slotstartingafterAddingGap===>'+slotstarting);
                	String slotstart;
                    Integer starthours = slotstarting/60;
                	System.debug('starthours====>'+starthours);
                    Integer startminutesmodule =  slotstarting -(starthours*60); 
                	System.debug('startminutesmodule===>'+startminutesmodule);
                	Time slotstartTime = Time.newInstance(starthours, startminutesmodule, 00,00);
                    Integer temp = slotstarting+slotDuration;
                    String slotend;
                    Integer endhours = temp/60;
                	//System.debug('endhours====>'+endhours);
                    Integer endminutesmodule =    temp-(endhours*60);       
                    //System.debug('endminutesmodule====>'+endminutesmodule);     
                    Time slotendTime = Time.newInstance(endhours, endminutesmodule, 00, 00);
                	//System.debug('slotendTime======>'+slotendTime);
                    Available_Slots__c avslot = new Available_Slots__c();
                    avslot.Availability__c = availabilityRecord.Id;
                    avslot.Start_Date__c = availabilityRecord.Date__c;
                    avslot.End_Date__c = availabilityRecord.Date__c;
                    avslot.Start_Time__c =  slotstartTime;
                    avslot.End_Time__c = slotendTime;
                    avslot.Slot_Duration__c = slotDurationString;
                    allAvailableSlots.add(avslot);
                	//System.debug('allAvailableSlots====>'+allAvailableSlots);
                    slotstarting = temp+afterGap;
                	//System.debug('slotstarting==>'+slotstarting);
             }
             else{
                   //System.debug('for new slot time is not sufficient..');  
             }
        }
        System.debug('allAvailableSlots====>'+allAvailableSlots);
        }
        System.debug('allAvailableSlots=====>'+allAvailableSlots);
        insert allAvailableSlots;
    }
 
    global void finish(Database.BatchableContext BC) {
        system.debug('Batch executed successfully....');
    }
}