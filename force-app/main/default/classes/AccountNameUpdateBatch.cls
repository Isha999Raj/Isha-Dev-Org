global class AccountNameUpdateBatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        string query = 'SELECT Id, Name From Account';
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        
        for(Account accRec : accList){
            accRec.Name = accRec.Name + 'Account';
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext bc){
        
        
    }
    
}