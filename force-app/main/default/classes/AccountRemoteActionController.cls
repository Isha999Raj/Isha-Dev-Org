public class AccountRemoteActionController {
    public String accountName { get; set; }
    public static List<Account> accounts { get; set; }
    
    public AccountRemoteActionController(){}
    
    @RemoteAction
    public static List<contact> getAccount(String accountName){
        String updatedAccName = '%'+accountName+'%';
        accounts = [select id, name, phone, type, numberofemployees from Account where name LIKE :updatedAccName];
        list<contact> conList = [select id,name,phone from contact where accountId =: accounts[0].Id];
        System.debug('Account Size : '+accounts.size());
        return conList;
    }
}