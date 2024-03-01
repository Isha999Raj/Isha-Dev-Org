trigger OpportunityTrigger4 on Opportunity (after insert, after update){
    List<Account> accList = New List<Account>();
    Map<Id, Boolean> isGoldByAccId = New Map<Id, Boolean>();
    if(Trigger.isInsert && Trigger.isAfter){
        for(Opportunity oppRec : Trigger.New){
            if(oppRec.Amount >= 20000){
                if(!isGoldByAccId.containsKey(oppRec.AccountId))
                    isGoldByAccId.put(oppRec.AccountId,True);
            }
        }
    }
    for(string accId : isGoldByAccId.keySet()){
        accList.add(New Account(Id=accId,is_gold__c=isGoldByAccId.get(accId)));
    }
    update accList;
}