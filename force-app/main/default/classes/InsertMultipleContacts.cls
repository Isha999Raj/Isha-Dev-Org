public with sharing class InsertMultipleContacts {
    
    public static String insertContacts(Contact contactDetails){ 
        try{

            insert contactDetails;
            return 'SUCCESS';  
            
        }catch(exception e){
            
            return 'ERROR'; 
        }
    }
}