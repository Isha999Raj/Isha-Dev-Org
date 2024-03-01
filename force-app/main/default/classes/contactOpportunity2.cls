public class contactOpportunity2 {
    
    @AuraEnabled
    public static List<Contact> getAllContacts(string accId){
        List<Contact> conList = [SELECT id, FirstName, LastName, Phone, Email From Contact Where AccountId=: accId];
        return conList;
    }
    
    @AuraEnabled
    public static List<Opportunity> getAllOpportunities(string accId){
        List<Opportunity> oppList = [SELECT ID, Name, OrderNumber__c, Amount, ExpectedRevenue From opportunity Where AccountId=: accId];
        return oppList;
    }
    
    @AuraEnabled
    public static Contact insertContact(string accId , Contact con){
        upsert con;
        return con;
    }
    
    @AuraEnabled
    public static Opportunity insertOpportunity(string accId , Opportunity opportunity){
        upsert opportunity;
        return opportunity;
    }
}