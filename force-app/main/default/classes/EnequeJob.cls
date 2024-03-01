public class EnequeJob implements Queueable{
    
    public integer startIndex;
    public integer endIndex;
    public EnequeJob(Integer startIndex, integer endIndex){
        this.startIndex = startIndex;
        this.endIndex = endIndex;
    }
    
    public void Execute(QueueableContext bc){
        List<Account> accListToBeInserted = new List<Account>();
        for(Integer i=startIndex; i<endIndex;i++){
            Account acc = new Account();
            acc.Name = 'Test Account'+i;
            accListToBeInserted.add(acc);
        }
        System.debug('accListToBeInserted--->'+accListToBeInserted);
        System.debug('accListToBeInserted Size---->'+accListToBeInserted.size());
        
        if(!accListToBeInserted.isEmpty()){
            insert accListToBeInserted;
        }
        if(endIndex < 2000){
            startIndex = endIndex;
            endIndex = endIndex + 500;
            System.enqueueJob(new EnequeJob(startIndex,endIndex));
        }
    }
    
    // Using the Future Method
    @future
    public static void FutureMethod(Integer startIndex, Integer endIndex){
        List<Account> accListToBeInserted = [SELECT Id FROM Account LIMIT 2];
        System.debug('the accListToBeInserted--->'+accListToBeInserted);
        for(integer i = startIndex;i<endIndex;i++){
            account acc = new account();
            acc.Name = 'testing'+i;
            accListToBeInserted.add(acc);
        }
        System.debug('The accListToBeInserted---->'+accListToBeInserted);
        System.debug('the accListToBeInserted Size--->'+accListToBeInserted.size());
        
        if(!accListToBeInserted.isEmpty()){
            insert accListToBeInserted;
        }
    }
}