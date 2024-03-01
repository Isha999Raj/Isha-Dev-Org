public class AngularCreateAccountController
{
    @RemoteAction
    public static string createAccount(string accnm, string webs, string fx, string bici, string bist, string bico, string indname, integer noe, integer anrev)
    {
        try{
            Account accRec = new Account(Name=accnm, Website=webs, Fax=fx, BillingCity=bici, BillingState=bist, BillingCountry=bico, Industry=indname, NumberOfEmployees=noe, AnnualRevenue=anrev);
            insert accRec;
            system.debug('accRec.id::'+accRec.id);
            return accRec.id;
            
        }catch(Exception e)
        {
            system.debug('Exception trace::'+e.getStackTraceString());
            return e.getStackTraceString();
        }
    }
    
    @RemoteAction
    public static string createContact(string fn, string ln, string em, string accountId)
    {
        try{
            Contact conRec = New Contact(FirstName=fn, LastName=ln, Email=em, AccountId=accountId);
             insert conRec;
             return conRec.id;
        }catch(Exception e)
        {
            return NULL;
        }
    }
    
}