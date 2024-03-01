public class ExpandCollapseSectionsHelper {
    @AuraEnabled
    public static string callingApex(string contactName){
        system.debug('contactName--->'+contactName);
        String Name = [Select Name From Contact Limit 1].Name;
        system.debug('Name----->'+Name);
        return Name ;
    }

}