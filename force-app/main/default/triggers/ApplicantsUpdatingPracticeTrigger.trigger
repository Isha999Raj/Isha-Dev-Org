trigger ApplicantsUpdatingPracticeTrigger on Application__c (before insert, after insert, after update, after delete) {
    if(!ApplicantsUpdatingPracticeHelper.runOnce){
        ApplicantsUpdatingPracticeHelper.validateSinglrApplicants(Trigger.New);
        ApplicantsUpdatingPracticeHelper.runOnce = True;
    }
    
    List<Job__c> job1 = [SELECT Id, Name,Required_Number_Of_Cnadidates__c,Total_Number_Of_Candidates__c,(SELECT Id From Application__r) From Job__c];
    if(Trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isAfter){
            for(Job__c job : job1){
                job.Total_Number_Of_Candidates__c = job.Application__r.size();
            }
            update job1;
        }
    }
}