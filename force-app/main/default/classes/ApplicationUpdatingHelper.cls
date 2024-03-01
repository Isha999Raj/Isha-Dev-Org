public class ApplicationUpdatingHelper {
    public static Boolean runOnce = False;
    public static void validateSingleApplication(List<Application__c> appList){
        set<Id> JobIds = New set<Id>();
        
        //Fetch All Unique Jobs :
        Map<Id,List<Id>> allContactsByJobId = New Map<Id,List<Id>>();
        for(Application__c appRecord : appList){
            JobIds.add(appRecord.Job__c);
        }
        
        //Fetch All Contacts Under Job :
        List<Application__c> existingApplicants = [SELECT Id,Name,Job__c,Contact_Name__c From Application__c Where Job__c IN : JobIds];
        
        //Put Data In Map<JobId,List<contactId>> :
        if(!existingApplicants.isEmpty()){
            for(Application__c appRecord : existingApplicants){
                if(allContactsByJobId.containsKey(appRecord.Job__c)){
                    allContactsByJobId.get(appRecord.Job__c).add(appRecord.Contact_Name__c);
                }
                else{
                    allContactsByJobId.put(appRecord.Job__c,New List<id>{appRecord.Contact_Name__c});
                }
            }
        }
        //Validate New Entries With Existing Entries :
        for(Application__c appRecord : appList){
            if(allContactsByJobId.containsKey(appRecord.Job__c)){
                List<Id> existingContacts = allContactsByJobId.get(appRecord.Job__c);
                if(existingContacts.contains(appRecord.Contact_Name__c)){
                    appRecord.addError('The Candidate that you have selected is already a part of this job...');
                }
            }
        }
    }
}