trigger leadPracticingTrigger on Lead (before insert , after update , before update) {
   // PracticingTrigger.setLeadFields(Trigger.New);
    if(Trigger.isAfter && Trigger.isUpdate){
        LeadCreateTask.setFollowUpTask(Trigger.New,Trigger.OldMap);
    }
    
    if(Trigger.isBefore && Trigger.isUpdate){
        changeLeadStage.leadStageNew(Trigger.New);
        changeLeadStage.leadStageCalled(Trigger.New);
        changeLeadStage.leadStageNurturing(Trigger.New);       
    }
    
}