public class MyUserController {
    
    @AuraEnabled
    public static List<User> getUsers(List<Id> userIds){
        List<User> userList = [SELECT Id, Name From User Where Id IN :userIds];
        return userList;
    }

}