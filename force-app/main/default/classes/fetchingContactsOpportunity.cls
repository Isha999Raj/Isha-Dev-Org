public class fetchingContactsOpportunity {
    
    @AuraEnabled
    public static List<contact> getContactList(Id recordId){
        List<contact> conList = [SELECT Id, FirstName, LastName From Contact Where AccountId =: recordId];
        return conList;
    }
    
    @AuraEnabled
    public static List<Opportunity> getOpportunityList(Id recordIdOpp){
        List<Opportunity> oppList = [SELECT Id, Name From Opportunity Where AccountId =: recordIdOpp];
        return oppList;
    }
}