@RestResource(urlMapping='/activity_mapping/*')
global class WebService_Activity {
    
    @HttpPost
    global static ResponseActivityWrapper.ResponseWrapper activity(){
        
        set<string> setOfUniqueIdTask = New set<string>();
        Map<String,String> mappingUidByAccountId = New Map<String,String>();
        
        
        ResponseActivityWrapper.ResponseWrapper response = New ResponseActivityWrapper.ResponseWrapper();
        ActivityWrapperClass activityWrap = New ActivityWrapperClass();
        activityWrap = ActivityWrapperClass.parse(RestContext.request.requestBody.tostring());
        
        response.failed_activity_list = New List<ResponseActivityWrapper.failure_activity>();
        
        for(ActivityWrapperClass.cls_activity activityDetails : activityWrap.Activity){
            setOfUniqueIdTask.add(activityDetails.search_by_value); 
        }
        
        List<Account> queryAccList = New List<Account>();
        List<Task> taskToBeInserted = New List<Task>();
        queryAccList = [SELECT Id,Uid__c From Account Where Uid__c IN:setOfUniqueIdTask];
        system.debug('queryAccList::'+queryAccList);
        
        for(Account accRec : queryAccList){
            mappingUidByAccountId.put(accRec.Uid__c,accRec.Id);
        }
        
        if(!queryAccList.isEmpty() && activityWrap.Activity != NULL && !activityWrap.Activity.isEmpty()){
            for(ActivityWrapperClass.cls_activity activityDetails : activityWrap.Activity){
                system.debug('activityDetails::'+activityDetails);
                if(mappingUidByAccountId.containsKey(activityDetails.search_by_value)){
                    
                    Task taskRecord = New Task();
                    
                    taskRecord.Activity_Type__c = activityDetails.activity_type;
                    taskRecord.Search_By_Value__c = activityDetails.search_by_value;
                    taskRecord.Exam_Date__c = Date.valueOf(activityDetails.exam_date);
                    taskRecord.Activity_Note__c = activityDetails.activity_note;
                    taskRecord.Exam_Name__c = activityDetails.exam_name;
                    taskRecord.Exam_Slug__c = activityDetails.exam_slug;
                    taskRecord.Subject__c = activityDetails.subject;
                    taskRecord.Skill_Based_Exam_Score__c = activityDetails.exam_score;
                    taskRecord.Is_Qualified_In_Exam__c = activityDetails.is_qualified_in_exam;
                    taskRecord.WhatId = mappingUidByAccountId.get(taskRecord.Search_By_Value__c);
                    taskToBeInserted.add(taskRecord);
                    system.debug('taskToBeInserted => ' +taskToBeInserted);
                    system.debug('taskToBeInserted.sizeee => ' +taskToBeInserted.size());   
                }
                
                else{
                    ResponseActivityWrapper.failure_activity failedResponse = New ResponseActivityWrapper.failure_activity();
                    failedResponse.activity_details = activityDetails;
                    failedResponse.error_msg = 'Account not found';
                    response.failed_activity_list.add(failedResponse);
                    system.debug('response.failed_activity_list => '+response.failed_activity_list);
                }
            }
            system.debug('taskToBeInserted::'+taskToBeInserted);
            if(!taskToBeInserted.isEmpty()){
                Database.SaveResult[] result = database.insert(taskToBeInserted, false);
                system.debug('Result ::' +result);
                system.debug('result.sizeee => ' +result.size());   
                
                response.success_activity_list = New List<Task>();
                for(Integer index = 0; index < result.size(); index++){
                    if(result[index].isSuccess())
                    {
                        response.success_activity_list.add(taskToBeInserted[index]);
                        system.debug('response.success_activity_list ::' +response.success_activity_list);
                    }else{
                        
                    }
                }
            }
        }
        return response;
    }
    
}