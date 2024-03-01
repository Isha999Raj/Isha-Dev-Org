public class testingCpuLimit {
    
    public static void method(){
        List<Account> accList = [SELECT Id,Name FROM Account limit 2000];
        for(Account acc:accList){
            acc.Name = acc.Name + '##';
            update accList;
        }
    }
}