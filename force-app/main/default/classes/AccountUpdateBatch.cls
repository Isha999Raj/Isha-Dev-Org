global class AccountUpdateBatch implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        string query = 'SELECT Id, Name From Account';
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        
        for(Account accRec : accList){
            accRec.Name = accRec.Name + 'acc';
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext bc){
        
        system.debug('isha');
    }
}