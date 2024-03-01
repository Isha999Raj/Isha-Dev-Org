public class getandUpsertContact {
    
    @AuraEnabled
    public static List<Contact> getAllContacts(){
        try{
            return [SELECT Id,Name,Phone,Email FROM Contact limit 10];
        }catch(Exception e){
            return null;
        }
    }

}