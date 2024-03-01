public class AngularExample2Controller 
{
    @RemoteAction
    public static contact createContact(string fn, string ln, string em)
    {
        try{
            contact conRec = new contact(FirstName=fn, LastName=ln, Email=em);
            insert conRec;
            return conRec;
        }catch(exception e)
        {
            return NULL;
        }
    }
    @RemoteAction
    public static List<contact> getAllContacts()
    {
        return [SELECT FirstName,LastName,Email FROM Contact];
    }
}