/*Ques. Create a field on Account called “need_intel”, checkbox, default off
        Create a field on Contact called “Dead”, checkbox, default off
        If 70% or less of the Contacts on an Account are Dead, mark the need_intel field to TRUE */

trigger ContactTrigger5 on Contact (after insert){
   
    set<id> accIds = New set<id>();
    List<Account> accList = New List<Account>();
    Map<id,integer> deadContacts = New Map<id,integer>();
    Map<id,integer> totalContactsByAccount = New Map<id,integer>();
    
    if(Trigger.isInsert && Trigger.isAfter){
        
        for(Contact conRec : Trigger.new){
            accIds.add(conRec.Accountid);    
        }
        List<Account> acc = [SELECT ID,need_intel__c,(SELECT accountId,Dead__c From Contacts) From Account Where Id IN : accIds];
        for(Account accRec : acc){
            totalContactsByAccount.put(accRec.Id,accRec.contacts.size());    
        }
        
        List<Account> acc2 = [SELECT ID,need_intel__c,(SELECT ID,Dead__c From Contacts Where Dead__c = True) From Account Where Id IN : accIds];
        for(Account accRec2 : acc2){
            List<Contact> conList2 = accRec2.contacts;
            deadContacts.put(accRec2.Id,conList2.size()); 
        }
        

        // % of Dead Calculation
        // Total Contacts
        // allContactforPercentagecalByAccount
        Map<Id,Boolean> NeedIntelByAccountId = new Map<Id,Boolean>();
            for(Id accId:totalContactsByAccount.keySet()){
                Decimal deadPercentage = (deadContacts.get(accId)/totalContactsByAccount.get(accId))*100;
                if( deadPercentage==100){
                    NeedIntelByAccountId.put(accId,TRUE);
                }else if(deadPercentage<=70){
                    NeedIntelByAccountId.put(accId,false);
                }else{
                    NeedIntelByAccountId.put(accId,TRUE);
                }
            }
        //STEP 7. Update Account
        List<Account> accListToBeUpdated = new List<Account>();
        for(Id accId:NeedIntelByAccountId.keySet()){
             accListToBeUpdated.add(new Account(Id=accId,Need_Intel__c=true));
        }
        system.debug('accListToBeUpdated::'+accListToBeUpdated);
        update accListToBeUpdated;
    }
    
    //update accList;
}