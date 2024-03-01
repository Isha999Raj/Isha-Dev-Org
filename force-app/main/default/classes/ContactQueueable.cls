public class ContactQueueable implements Queueable {
    
    public List<Contact> conList;
    
    public ContactQueueable(List<Contact> conList){
        
        this.conList = conList;
    }
    
    public void execute(QueueableContext context) {
        
        for(Contact con : conList){
            
            con.FirstName = con.FirstName + 'contact';
        }
        update conList;
        system.debug('contactqueueable');
    }
}

//account >> jobid >> contact
//List<Account> accList = [select Id, Name from Account];
//Id jobID = system.enqueueJob(New AccountQueueable(accList));
//system.debug('jobID  ' +jobID);