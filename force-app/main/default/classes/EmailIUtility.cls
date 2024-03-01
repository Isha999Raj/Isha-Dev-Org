public without sharing class EmailIUtility{
    
    public static void sendExceptions(Exceptions__c exceps){
        //Error Template
        try{
            EmailTemplate ErrorEmailtemplate = [Select id, Name, DeveloperName, Subject, Body, HtmlValue
                                                from EmailTemplate
                                                where name = 'Error Template'];
            String Email = 'isha.raj@utilitarianlabs.com';
            
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> recipients = new List<String>();
            recipients.add(Email);
            System.debug('recipients ====> ' + recipients);
            mail.setToAddresses(recipients);
            mail.setReplyTo('Excelr@info.com');
            mail.setSenderDisplayName('Excelr');
            String subject = ErrorEmailtemplate.Subject;
            String htmlBody = ErrorEmailtemplate.HtmlValue;
            //System.debug('htmlBody ====> ' + htmlBody);
            //System.debug('referrar Name ===>' + ReferrarNameWithEmail.get(Email));
            
            if (htmlBody.contains('{!Exceptions__c.Class_Name__c}')){
                htmlBody = htmlBody.replace('{!Exceptions__c.Class_Name__c}', exceps.Class_Name__c);
            }
            if (htmlBody.contains('{!Exceptions__c.Error_Message__c}')){
                htmlBody = htmlBody.replace('{!Exceptions__c.Error_Message__c}', exceps.Error_Message__c);
            }
            if (htmlBody.contains('{!Exceptions__c.Error_Line_No__c}')){
                htmlBody = htmlBody.replace('{!Exceptions__c.Error_Line_No__c}', String.valueof(exceps.Error_Line_No__c));
            }
            mail.setSubject(subject);
            mail.setHtmlBody(htmlBody);
            mails.add(mail);
            System.debug('mails =====> ' + mails);
            
            if (!mails.isEmpty()){
                Messaging.sendEmail(mails);
            }
        }catch (Exception e){
            system.debug('ERROR :: ' + e.getMessage() + 'AT LINE NUMBER :: ' + e.getLineNumber());
            HandleBusinessException.captureError('EmailIUtility', 'sendExceptions', e , null);
            
        }
    }
}