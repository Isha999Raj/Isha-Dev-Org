public class lead1 {
    
    //inserting lead
    public void insertlead(string fn, String ln, String cn)
    {
        Lead l1 = new Lead();
        l1.FirstName = fn;
        l1.LastName = ln;
        l1.Company = cn;
        insert l1;
        
    }
    
    //fetching lead
    public void fetchLead(string Lid)
        
    {
        Lead l1 = new Lead();
        l1 = [SELECT Firstname, lastName, company from lead where id =: Lid];
        system.debug('@@@' + l1);
        
    }
    
    //updating lead
    public void updateLead(string Lid, String cn)
        
    {
        Lead l1 = new Lead();
        l1 = [SELECT Company from Lead where id =: Lid];
        l1.Company = cn;
        update l1;
        system.debug('After Updation : ' +cn);
    }
    
}