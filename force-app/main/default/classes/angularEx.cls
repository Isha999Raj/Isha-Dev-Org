public class angularEx 
{
    @RemoteAction
    public static string createContact(string fn, string ln, string email)
    {
    try{
       insert New contact(FirstName=fn, LastName=ln, Email=email);
       return 'Success';
    }catch(Exception e){
        System.debug('Error :'+e.getMessage()+' AT '+e.getLineNumber());
        return 'Error :'+e.getMessage()+' AT '+e.getLineNumber();
    }
    }
    @RemoteAction
    /*public static List<contact> fetchAllContacts()
    {
        return [select id,FirstName,LastName,Email from contact order by CreatedDate DESC LIMIT 10];
    }*/
    
    List<Contact> conRec = [SELECT FirstName,LastName,email FROM Contact];
    public List<contact> getconRec()
    {
        return conRec;
    }
}