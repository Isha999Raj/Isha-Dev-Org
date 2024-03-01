public class LeadCreateTask {
    
    public static void setFollowUpTask(List<Lead> newLead , Map<Id,Lead> oldLeadMap){
        
        List<Lead> leadToBeUpdated = New List<Lead>();
        
        for(Lead l1 : newLead){
            
            if(l1.Follow_up_Date__c != oldLeadMap.get(l1.id).Follow_up_Date__c && l1.Follow_up_Date__c >= System.Now()){
                leadToBeUpdated.add(l1);
            }
            else{
                l1.addError('Past Date is not supported by system, Please select either today date or future date ...');
            }
        }
        List<Task> taskList = New List<Task>();
        for(Lead l2 : leadToBeUpdated)
        {
            
            Task createTask = New Task();
            createTask.whoId = l2.id;
            createTask.OwnerId = l2.OwnerId;
            createTask.Subject = 'Follow-up with Customer';
            taskList.add(createTask);
        }
        insert taskList;
        
    }
}