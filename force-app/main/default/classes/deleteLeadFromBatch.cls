global class deleteLeadFromBatch implements Database.Batchable<sObject>{
    
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        string query = 'SELECT Id, Phone From Lead where Phone != Null';
        return Database.getQueryLocator(query);
        
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> ph){
        for(lead leadRec : ph){
            delete leadRec;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        
        system.debug('FINISH BATCH CLASS');
    }

}