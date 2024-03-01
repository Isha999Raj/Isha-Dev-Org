public class sdb {
    
    public static string accID;
    public static string accID2;
    public void accDetails()
    {
        Account a1 = new Account();
        a1.Name = 'Isha chadda';
        a1.Phone = '1230987654';
        system.debug(a1);
        insert a1;
        accID = a1.ID;
        system.debug(a1.ID);
        
        Account a2 = new Account();
        a2.Name = 'Swati';
        a2.Phone = '7279020790';
        system.debug(a2);
        insert a2;
        accID2 = a2.ID;
        system.debug(a2.ID);
        
    }
    
    public void contactDetails()
    {
        Contact con1 = new Contact();
        con1.FirstName='Kisshan';
        con1.LastName='Panchall';
        con1.Phone='959983';
        con1.Department='Marketing';
        system.debug(con1);
        con1.AccountId = accID;
        insert con1;
        
        Contact con2 = new Contact();
        con2.FirstName='cid';
        con2.LastName='c';
        con2.Phone='9876';
        con2.Department='Sale';
        system.debug(con2);
        con2.AccountId = accID2;
        insert con2;
        
    }

}







//Account accRecord = new Account(name='Relevel');
//insert accRecord;
//insert new Contact(FirstName='Ajeet',LastName='Kumar',AccountId=accRecord.Id);
//insert new Contact(FirstName='Prithvi',LastName='Shiroor',AccountId=accRecord.Id);
//insert new Contact(FirstName='Mukesh',LastName='Chawla',Phone='12',AccountId=accRecord.Id);