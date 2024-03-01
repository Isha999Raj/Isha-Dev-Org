public with sharing class AllAccountWithsocialSchedular {
    public AllAccountWithsocialSchedular() {

    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}