public class DMLClass {
    
    public static void myMethod(){
        
        List<Account> accList = [SELECT Name FROM Account Order by Name LIMIT 3];
        
        Account a = accList[0]; //activity testing
        Account b = accList[1]; //Next
        Account c = accList[2]; //Warner Bros
        
        List<Account> mergeList = New List<Account>();
        mergeList.add(accList[1]);
        mergeList.add(accList[2]);
        
        //merge a b; //for 2 records
        merge a mergeList; //for 3 records
        
    }

}