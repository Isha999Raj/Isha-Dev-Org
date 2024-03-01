public class contactOpportunity {
    
    @AuraEnabled
    public static wrapperClass getConOpp(string accId){
        wrapperClass wrapConOpp = new wrapperClass();
        List<Account> acclist = [Select id, name, 
                                 (Select id,LastName, FirstName, Phone, Email From Contacts), 
                                 (Select id, Name, OrderNumber__c, Amount, ExpectedRevenue From Opportunities) 
                                 from Account where Id=:accId];
  
        for(Account acc  : acclist){
            
            wrapConOpp.conRec = acc.contacts;
            wrapConOpp.oppRec = acc.Opportunities;
        }
        system.debug('@@@@@' + wrapConOpp);
        return wrapConOpp;
    }
    
   /* @AuraEnabled
    public static void insertContact(){
        
        List<Account> accList = [SELECT Id, Name,(SELECT Id, FirstName, LastName, Phone, Email From Contacts) From Account Where Id ='0015j00000ZVEiRAAX'];
        List<Contact> conList = New List<Contact>();
        for(Account acc : accList){
            Contact con = New Contact();
            con.AccountId = acc.Id;
            con.FirstName = 'FirstName';
            con.LastName = 'LastName';
            con.Email = 'Email';
            con.Phone = 'Phone';
            conList.add(con);
        }
        insert conList;
    }
    
    @AuraEnabled
    public static void insertOpportunity(){
        
        List<Account> accList = [SELECT Id, Name,(SELECT Id, Name, OrderNumber__c, Amount, ExpectedRevenue From opportunities) From Account Where Id ='0015j00000ZVEiRAAX'];
        List<Opportunity> oppList = New List<Opportunity>();
        for(Account acc : accList){
            Opportunity opp = New Opportunity();
            opp.Name = 'Name';
            opp.OrderNumber__c = 'OrderNumber__c';
            //opp.Amount = 'Amount';
            //opp.ExpectedRevenue = 'ExpectedRevenue';
            oppList.add(opp);
        }
        insert oppList;
    } */
    
    
    public class wrapperClass{
        
        @AuraEnabled public List<Contact> conRec {get;set;}
        @AuraEnabled public List<Opportunity> oppRec {get;set;}
    }
    
}