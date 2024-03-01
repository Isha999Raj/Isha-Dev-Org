public class sdb3 {
    
    //fetching details from Account
    public void accountDetails()
    {
        Account[] account1 = [SELECT Name,Phone FROM Account];
        system.debug(account1);
    }
    
    //fetching details from Contact
    public void contactDetails()
    {
      Contact[] contact1 = [SELECT FirstName,LastName FROM Contact];
        system.debug(contact1);
    }
    
    //fetching contact wrt all existing account
    public void FetchAllContact()
    {
      List<Account> acclist = [SELECT Name,Phone,(SELECT FirstName,LastName FROM Contacts) FROM Account];
        for(Account acc : acclist)
        {
            if(acc.Contacts.Size() >0)
            {
                List<Contact> ContactList = acc.Contacts;
                system.debug('Yes! Yes! I have ' +ContactList.Size()+ ' Account');
                for(Contact con1 : ContactList)
                {
                    system.debug('First Name = ' +con1.FirstName + 'Last Name = ' +con1.LastName);
                }
            }
            else
            {
                system.debug('SORRY ! There is no Contacts Available in this Account!!!');
            }
        }
    }
}