trigger accountPracticingTrigger on Account (after insert, before insert, before update, before delete) {
    // PracticingTrigger.setContactsByCreatingAccount(Trigger.New);
    //PracticingTrigger.setContactFieldsByAccount(Trigger.New);
    //PracticingTrigger.setAccountFieldByContact(Trigger.New);
    /*if(Trigger.isInsert || Trigger.isUpdate && Trigger.isBefore){
        PracticingTrigger.preventFromDuplicateAcc(Trigger.New);
    }*/
     if(Trigger.isDelete && Trigger.isBefore){
        PracticingTrigger.preventAccountFromDeletion(Trigger.old);
    }
}