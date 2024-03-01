trigger ApplicantsUpdatingTrigger on Application__c (before insert, after insert, after update)
{
    if(!ApplicationUpdatingHelper.runOnce){
       ApplicationUpdatingHelper.validateSingleApplication(Trigger.New);
       ApplicationUpdatingHelper.runOnce = True;
    }
    List<Job__c> job1 = [SELECT Id,Total_Number_Of_Candidates__c,Required_Number_Of_Cnadidates__c,(SELECT Id FROM Application__r) FROM Job__c];
    if(Trigger.isInsert || Trigger.isUpdate && Trigger.isAfter)
    {
        for(Job__c job : job1)
        {
            job.Total_Number_Of_Candidates__c = job.Application__r.size();
        }
        update job1;
    }
}