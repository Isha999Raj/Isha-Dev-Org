public class ContactBatch implements Database.Batchable<sObject>{

    public Integer total_size = 0;
    public Integer fail_size = 0;
    public Integer success_size = 0;

    public Database.QueryLocator start(Database.BatchableContext bc){

        string Query = 'Select Id, Name, Fax, Email, MobilePhone, Description, Account.Name, ' + 
        'Account.Rating, Account.Phone, Account.Fax, Account.Industry From Contact Where AccountId != NULL';

        return Database.getQueryLocator(Query);
    }

    public void execute(Database.BatchableContext bc, List<Contact> contactList){



        Integer size = contactList.size();
        total_size = total_size + size;

        for(Integer i=0; i<size; i++){
            Contact con = contactList.get(i);

            if(con.Fax == null || con.Fax == ''){
                con.Fax = con.Account.Fax;
            }

            if(con.MobilePhone == null || con.MobilePhone == ''){
                con.MobilePhone = con.Account.Phone;
            }

            con.Email = 'ajeet.kumar@utilitarianLab.com';
            con.Description = con.Account.Name+' '+con.Account.Rating+' '+con.Account.Industry+' '+con.Email;

            Database.SaveResult[] result = Database.update(contactList, false);
            Integer size_result = result.size();
            for(Integer j=0; j<size_result; j++){
                Database.SaveResult saver = result.get(i);
                if(saver.isSuccess()){
                    success_size += 1;
                }
                else {
                    fail_size += 1;
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc){

        Messaging.SingleEmailMessage email = New Messaging.SingleEmailMessage();
        string[] toAddress = New string[]{'isha.raj@utilitarianLab.com','anjali.singh@utilitarianLab.com'};
        email.setToAddresses(toAddress);
        email.setSubject('Your Batch Job is completed');
        email.setPlainTextBody('The batch job that you startted is successfully completed ...');
        Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
    }
}