public class AccountUtils {

    public static List<Account> accountsByState(string state){
       List<Account> accList = [Select Id,Name From Account WHERE BillingState =: state]; 
        return accList;
    }
}