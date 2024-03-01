/**
 Author:vamsi
**/

global class BatchToDeletePastAvailability implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator([select Id,Query__c from DeleteAvailabilitie__mdt]);
    }
    
    global  void execute(Database.BatchableContext BC, List<Availability__c> listOfAvailabilites){
        if(!listOfAvailabilites.isEmpty()){
            Database.delete(listOfAvailabilites);
        }
        
    }
    
    global void finish(Database.BatchableContext bc) {
        System.debug('successfully Deleted all The Previous month Records...');
    }
    

}