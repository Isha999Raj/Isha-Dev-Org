@RestResource(urlMapping='/activitymapping/*')
global class WebService_Activity2 {
    
    @HttpPost
    global static void activity(){
        
        ResponseActivityWrapper.ResponseWrapper response = New ResponseActivityWrapper.ResponseWrapper();
        ActivityWrapperClass actWrap = New ActivityWrapperClass();
        actWrap = ActivityWrapperClass.parse(RestContext.request.requestBody.tostring());
        
        set<id> setOfUniqueIdTask = New set<id>();
        Map<String,String> mappingUidByAccountId = New Map<String,String>();
        Map<String,List<ActivityWrapperClass.cls_activity>> mappingUidWithTask = New Map<String,List<ActivityWrapperClass.cls_activity>>();
        
        for(ActivityWrapperClass.cls_activity activityDetails : actWrap.activities){
            setOfUniqueIdTask.add(activityDetails.search_by_value);
        }
        
        List<Account> QueryAccList = New List<Account>();
        List<Task> taskToBeInserted = New List<Task>();
        QueryAccList = [SELECT Id,Uid__c FROM Account WHERE ID IN:setOfUniqueIdTask];
        
        for(Account accRec : QueryAccList){
            mappingUidByAccountId.put(accRec.Uid__c,accRec.Id);
        }
    }

}