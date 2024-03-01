trigger triggerOnUser on User (before insert, before update, before delete, after insert, after delete, after update) {

    SObject_Trigger_Control__mdt triggerConfig = SObject_Trigger_Control__mdt.getInstance('User');
    system.debug('triggerConfig:: ' + triggerConfig);
    
    if (triggerConfig != null && triggerConfig.Trigger_Status__c){
        UserTriggerHandler handlerInstance = UserTriggerHandler.getInstance();
        
        // if((Trigger.isInsert || trigger.isUpdate)&& Trigger.isAfter){
        //     UserTriggerHandler.CreateAvailibility(Trigger.newMap);
        // }
    }

}