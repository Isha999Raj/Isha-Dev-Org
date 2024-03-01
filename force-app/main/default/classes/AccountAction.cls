public class AccountAction
{
    @InvocableMethod
    public static void updateAccountName(List<id> ids)
    {
        
        List<Account> accountToBeUpdated = new List<Account>();
        
        List<Account> accounts = [SELECT Name FROM Account WHERE id in :ids];
        for(Account account : accounts)
        {
            
            account.Name = account.Name+'Test';
            accountToBeUpdated.add(account);
        }
        
        update accountToBeUpdated;
    }
}