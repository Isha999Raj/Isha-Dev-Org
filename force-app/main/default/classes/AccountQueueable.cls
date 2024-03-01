public class AccountQueueable implements Queueable {
    
    public List<Account> accList;
    public List<contact> conList = [select Id,FirstName from contact];
    
    public AccountQueueable(List<Account> accList){
        
        this.accList = accList;
    }
    
    public void execute(QueueableContext context) {
        
        for(Account acc : accList){
            
            acc.Name = acc.Name + 'account';
        }
        
        update accList;
        system.debug('account Queueable');
        system.enqueueJob(New ContactQueueable(conList));
    }
}