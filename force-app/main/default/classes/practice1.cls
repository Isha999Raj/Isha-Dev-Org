public class practice1 
{
    public void contact(string lid)
    {
        
        Account acc = [SELECT Name,Phone,(SELECT FirstName,LastName FROM Contacts)FROM Account WHERE id =: lid];
        if(acc.contacts.size() > 0)
        {
            List<contact> contactlist = acc.Contacts;
            system.debug('Contact list size is : '+Contactlist.size());
        }
        else
        {
            system.debug('There is no contact available in this list...');
        }
        
    }
}