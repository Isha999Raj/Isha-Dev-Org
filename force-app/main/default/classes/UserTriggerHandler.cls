public without sharing class UserTriggerHandler {
    static UserTriggerHandler handlerInstance;
    
    public static UserTriggerHandler getInstance(){
        if (handlerInstance == null)
            handlerInstance = new UserTriggerHandler();
        return handlerInstance;
    }
    
    public Static Void CreateAvailibility(Map<Id,User> UserMap){
        try{
        System.debug('UserMap----'+UserMap);
        BatchToInsertAvailabilitiesRecords batchClass = new BatchToInsertAvailabilitiesRecords(UserMap);
        Database.executeBatch(batchClass);
    } catch(Exception e){
        System.debug(' the Error has occured due to =====> ' + e.getMessage());
        System.debug(' the Error has occured at  =====> ' + e.getLineNumber());
        HandleBusinessException.captureError('UserTriggerHandler','CreateAvailibility', e, null);
        
    }
}
    
}