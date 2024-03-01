public class ChildAccount {
    
    @AuraEnabled
    public static List<accountWrapper> QueryAccount(){
        
        List<accountWrapper> accWrapList = New List<accountWrapper>();
        
        List<Account> accList = [SELECT Name,Account__r.Name FROM Account Where Account__c !=NULL];
        
        Map<String, List<Account>> childAccMap = New Map<String, List<Account>>();
        for(Account acc : accList){
            
            if(childAccMap.containsKey(acc.Account__r.Name)){
                
              List<Account> accountList = childAccMap.get(acc.Account__r.Name);
              accountList.add(acc); 
                
            }else{
                
                List<Account> accountList = New List<Account>();
                accountList.add(acc);
                childAccMap.put(acc.Account__r.Name,accountList);
            } 
        }
        
        for(String parentAccName : childAccMap.keySet()){
            system.debug('parentAccName :: ' +parentAccName);
           accountWrapper childAccWrap = New accountWrapper();
           childAccWrap.childAcc = parentAccName;
           childAccWrap.childAccount = childAccMap.get(parentAccName);
           accWrapList.add(childAccWrap); 
        }
        return accWrapList;
    }
    
    public class accountWrapper{
        
        @AuraEnabled public String childAcc{get;set;}
        @AuraEnabled public List<Account> childAccount{get;set;} 
    }
    
}