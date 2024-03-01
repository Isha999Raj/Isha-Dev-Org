public with sharing class contactController {
    
    @AuraEnabled
    public static List<contact> findAll(){
        return [SELECT Id, FirstName, LastName From Contact limit 15];
    }
    
    @AuraEnabled
    public static List<contact> findByName(string searchKey){
        string name = '%' + searchKey + '%';
        return [SELECT Id, FirstName, LastName From contact Where Name like : name limit 15];
    }
    
    @AuraEnabled
    public static contact findById(string searchId){
        return [SELECT Id, FirstName, LastName, Account.Name From contact where Id =: searchId limit 15];
    }
    
}