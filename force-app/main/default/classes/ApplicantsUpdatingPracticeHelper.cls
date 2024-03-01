public class ApplicantsUpdatingPracticeHelper{
    public static boolean runOnce = false;
    public static void validateSinglrApplicants(List<Application__c> appList){
        set<Id> jobIds = New set<Id>();
        Map<id,List<id>> allContactsByJobId = New Map<id,List<id>>();
        
        //Fetch All Unique Jobs And Store It Into JobIds :
        for(Application__c appRec : appList){
            jobIds.add(appRec.Job__c);
        }
        
        //Fetch All ExistingContacts And Store It Into existiingContacts :
        List<Application__c> existingApplicants = [SELECT ID,Name,Job__c,Contact_Name__c From Application__c Where Job__c In : jobIds];
        
        //Put Data Into Map<Id>List<id>> : 
        if(!existingApplicants.isEmpty()){
            for(Application__c appRec : existingApplicants){
                if(allContactsByJobId.containsKey(appRec.Job__c)){
                    allContactsByJobId.get(appRec.Job__c).add(appRec.Contact_Name__c);
                }
                else{
                    allContactsByJobId.put(appRec.Job__c,New List<id>{appRec.Contact_Name__c});
                }
            } 
        }
        
        //Validate New Entries With Existing Entries :
        for(Application__c app : appList){
            if(allContactsByJobId.containsKey(app.Job__c)){
                List<Id> existingContacts = allContactsByJobId.get(app.Job__c);
                if(existingContacts.contains(app.Contact_Name__c)){
                    app.addError('This contact is already a part of this job...');
                }
            }
        }
    }
}