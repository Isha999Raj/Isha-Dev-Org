public class parentClass     //ParentClass.
{
 
    MyWrapperClass lst = New MyWrapperClass();
    
    public void method1(string accId)    //Method1.
    {
        
      system.debug(method2(accId));
        
    }
    
    public MyWrapperClass method2(string accId)    //Method2.
    {
        
        //MyWrapperClass lst = New MyWrapperClass(); 
        //List<contact> con1 = New List<contact>();
        //List<Opportunity> opp1 = New List<Opportunity>();
        //List<Case> case1 = New List<Case>();
        
       lst.conList = [SELECT FirstName,id,Phone FROM Contact WHERE AccountId =: accId];
       //lst.conList = con1;
        
       lst.oppList = [SELECT Name,id FROM Opportunity WHERE AccountId =: accId];
       //lst.oppList = opp1;
        
       lst.caseList = [SELECT Status FROM Case WHERE AccountId =: accId];
       //lst.caseList = case1;
       //
       return lst;
       
        
    }
    
    public class MyWrapperClass    //WrapperClass.
    {
        
        public List<Contact> conList;
        public List<Opportunity> oppList;
        public List<Case> caseList;
    }
}