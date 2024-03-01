public class LoginPage_Controller {
    
    @RemoteAction
    public static contact loginUser(String userName, String password){
        try{
            
            List<Contact> conRec = [Select FirstName,LastName,Id,Email,Phone From Contact Where Email =: userName AND Password__c =: password limit 1];
            if(conRec.size() > 0)
            {
                conRec[0].Login_Hash_Code__c = Utility.generateRandomString();
                update conRec[0];
                return conRec[0];  
            }
            else{
                return null;
            }
            
        }catch(exception e){
            return null;
        }
    }
    
}