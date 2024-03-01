global class LeadUpdateBatch implements Database.Batchable<sObject> {
    
    // Inside start method, we just write the code to fetch records on which we want to execute the particular operation .
    // It executes only one .
    // Database.getQueryLocator return records in batches/records .
    global Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([SELECT AnnualRevenue From Lead]);
    }
    
    // Inside execute method, we write main code that we want to executed on those records .
    // It executes equal to the number of batches/chunks that we have created .
    // leadList get those chunks .
    global void execute(Database.BatchableContext bc, List<Lead> leadList){
        
        for(Lead l1 : leadList){
            if(l1.AnnualRevenue == 1000000){
                l1.AnnualRevenue = 2000000;
            }
        }
        update leadList;
    }
    
    // Inside finish methd, we just write the code for post processing things like - send confirmation email that batch apex has been completed successfully .
    // It executes only once
    global void finish(Database.BatchableContext bc){
        
       Messaging.SingleEmailMessage mail = New Messaging.SingleEmailMessage();
        String[] toAddress = New String[]{'isha999raj@gmail.com'};
        mail.setToAddresses(toAddress);
        mail.setSubject('Batch Job Completed');
        mail.setPlainTextBody('The batch job that you started is successfully completed . ');
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{mail});
    }
}