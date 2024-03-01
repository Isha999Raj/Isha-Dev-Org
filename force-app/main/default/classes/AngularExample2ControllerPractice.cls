public class AngularExample2ControllerPractice
{
    @RemoteAction
    public static Account createAccount(string fx, string nm)
    {
        try{
            Account accRec = new Account(Fax=fx, Name=nm);
            insert accRec;
            return accRec;
            
        }catch(Exception e)
        {
            return NULL;
        }
    }
    @RemoteAction
    public static List<Account> getAllAccounts()
    {
        return [SELECT Fax,Name FROM Account];
    }
}