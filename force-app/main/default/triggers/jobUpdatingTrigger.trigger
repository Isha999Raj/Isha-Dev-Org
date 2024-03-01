trigger jobUpdatingTrigger on Job__c (before insert) {
    List<Job__c> job1 = [SELECT Id,Total_Number_Of_Candidates__c,(SELECT Id FROM Application__r) FROM Job__c];
    if(Trigger.isInsert || Trigger.isUpdate && Trigger.isAfter)
    {
        for(Job__c job : job1)
        {
            
            job.Total_Number_Of_Candidates__c = job.Application__r.size();
        }
        update job1;
    }
}