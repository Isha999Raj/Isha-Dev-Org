trigger leadOpenTaskCheck on Task (after update) {
    
    leadOpentaskCheckController.checkTask(Trigger.Old);

}