public with sharing class FutureMethod {


@Future
public static void countContacts(string accId){

    Account acc = [select id,Number_Of_Contacts__c,(select id from contacts) from Account where id =: accId];

        acc.Number_Of_Contacts__c = acc.Contacts.size();
    update acc;
}
}