public class PracticingTrigger {
    
    //Ques 1. When ever a case is created with origin as email then set status as new and Priority as Medium.
    
    public static void setCaseFields(List<Case> caseRecord){
        for(case c : caseRecord){
            if(c.Origin == 'Email'){
                c.Status = 'New';
                c.Priority = 'Medium';
            }
        }
    }
    
    //Ques 2. When ever Lead is created with LeadSource as Web then give rating as cold otherwise hot.
    
    public static void setLeadFields(List<Lead> leadRecord){
        for(Lead lead1 : leadRecord){
            if(lead1.LeadSource == 'Web'){
                lead1.Rating = 'Cold';
            }
            else{
                lead1.Rating = 'Hot';
            }
        }
    }
    
    //Ques 3. Whenever New Account Record is created then needs to create associated Contact Record automatically.
    //account name as contact lastname.
    //account phone as contact phone.
    
    public static void setContactsByCreatingAccount(List<Account> accRecord){
        List<Contact> conList = New List<Contact>();
        for(Account acc : accRecord){
            Contact conRec = New Contact();
            conRec.AccountId = acc.id;
            conRec.LastName = acc.Name;
            conRec.Phone = acc.Phone;
            conList.add(conRec);
        }
        insert conList;
    }
    
    //Ques 4. When ever the Account is created with Industry as Banking then create a contact for account,
    //Contact Lastname as Account name and contact phone as account phone.
    
    public static void setContactFieldsByAccount(List<Account> accList){
        List<Contact> conList = New List<Contact>();
        for(Account accRec : accList){
            Contact conRec = New Contact();
            if(accRec.Industry == 'Banking'){
                conRec.AccountId = accRec.Id;
                conRec.LastName = accRec.Name;
                conRec.Phone = accRec.Phone;
                conList.add(conRec);
            }
        }
        insert conList;
    }
    
    //Ques 5. Creates the number of contacts which are equal to the number which we will enter in the,
    //Number of Locations field on the Account Object.
    
    Public static void setAccountFieldByContact(List<Account> accList){
        List<Contact> conList = New List<Contact>();	
        Map<id,decimal> accMap = New Map<id,decimal>();
        for(Account accRec : accList){
            accMap.put(accRec.id,accRec.NumberofLocations__c);
        }
        if(accMap.size()>0 && accMap!=NULL){
            for(Id accId : accMap.keySet()){
                for(integer i=0; i<accMap.get(accId); i++){
                    Contact conRec = New Contact();
                    conRec.AccountId = accId;
                    conRec.LastName = 'contact'+i;
                    conList.add(conRec);
                }
            }
        }
        if(conList.size()>0 && conList!=NULL){
            insert conList;
        }
    }
    
    //Ques 6. When ever Opportunity "Stage" is modified to "Closed Won" then set "Close Date" as "Today Date" and "Type" as "New Customer".
    
    public static void updateOpportunityfield(List<Opportunity> oppList){
        for(Opportunity oppRec : oppList){
            if(oppRec.StageName == 'Closed Won'){
                oppRec.CloseDate = system.today();
                oppRec.Type = 'New Customer';
                
            }
        }
    }
    
    //Ques 7. when a new contact is created for a existing account then set contact otherphone as account phone.
    
    public static void setConOtherPhoneByAccPhone(List<Contact> conList){
        set<id> conId = New set<id>();
        for(Contact conRec : conList){
            conId.add(conRec.AccountId);
        }
        Map<id,Account> accMap = New Map<id,Account>([SELECT id,Name,Phone From Account Where id =: conId]);
        for(Contact con : conList){
            con.OtherPhone= accMap.get(con.AccountId).Phone;
        }
    }
    
    //Ques 8. The following Trigger will fires when we try to create the account with same name i.e. Preventing the users to create Duplicate Accounts.
    
    public static void preventFromDuplicateAcc(List<Account> accList){
        for(Account accRec : accList){
           List<Account> acc = [SELECT id,Name From Account Where Name=:accRec.Name];
            if(acc.size()>1){
                accRec.addError('Duplicate Account !!!!');
            }
        }
    }
    
    //Ques 9. Write a trigger in which if an account that has related contacts and the user tries to delete that account it throws you an error "Account cannot be deleted".
    
    public static void preventAccountFromDeletion(List<Account> accRec){
        List<Account> accList = New List<Account>();
        set<id> ids = New set<id>();
        for(Account acc : accRec){
           ids.add(acc.Id); 
        }
        Map<Id,Account> accMap = New Map<Id,Account>([SELECT Id,(SELECT Id From contacts) From Account Where id =: ids]);
        for(Account acc : accRec){
            if(accMap.get(acc.id).contacts.size()>0){
               acc.addError('The Account that you want to delete cannot be delete !!!'); 
            }
        }  
    }
    
    //Ques 10. Write a trigger on lead to prevent duplicate records based on lead email, if a record already created with the same Email, Or record is Updated. The trigger should throw an error.
    
    public static void preventDuplicateEmailsInLead(List<Lead> leadRec){
        
    }
}