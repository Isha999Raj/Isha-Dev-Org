/*public class accountWrapperClass
{
    
    public List<Account> acclist {get;set;}
    public List<wrapperClass> lstwrap {get;set;}
    
    public accountWrapperClass()
    {
 
       acclist = [SELECT ID,Name,(SELECT FirstName FROM Contacts) FROM Account];
       lstwrap = New List<wrapperClass>();
       for(Account acc1 : acclist)
       { 
           
         lstwrap.add(New wrapperClass(acc1));
         system.debug(acc1.Contacts);
         //system.debug(lstwrap);
       
       }
    }
    public class wrapperClass
    {
        public Account accRec {get;set;}
        
        public wrapperClass(Account acc)
        {
            accRec = acc;
       
        }
    }
}*/

public class accountWrapperClass
{
    public accountWrapperClass()
    {
        
    }
    public class wrapperClass
    {
        public List<Account> accRec;
    }
}