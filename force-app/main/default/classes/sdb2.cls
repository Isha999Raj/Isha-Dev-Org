public class sdb2 {
    
    public void accdetails()
    {
        Account account1 = new Account();
        account1.Name = 'ss';
        account1.Phone = '11';
        system.debug(account1);
        insert account1;
        
        Account[] accl= [SELECT Name FROM Account];
        system.debug(accl);
        
        
    }
    
    public void contdetails()
    {
        Contact contact1 = new Contact();
        contact1.FirstName = 'Ajeet';
        contact1.LastName = 'Kumar';
        contact1.Phone = '22';
        insert contact1;
        
        Contact[] cont1 = [SELECT FirstName,Phone FROM Contact];
        system.debug(cont1);
    }

}