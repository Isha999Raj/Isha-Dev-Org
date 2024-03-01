@RestResource(urlMapping='/account_mapping/*')
global class Webservice_AccountMapping {
    
    @HttpPost
    global static ResponseWrapperClass.ResponseWrapper accountMapping(){
        ResponseWrapperClass.ResponseWrapper response = new ResponseWrapperClass.ResponseWrapper();
        AccountMappingWrapper accWrap = new AccountMappingWrapper();
        accWrap = AccountMappingWrapper.parse(RestContext.request.requestBody.tostring());
        
        List<account> accountListtobeInsert = New List<account>();
        List<opportunity> opportunityListTobeInsert = New List<opportunity>();
        List<contact> contactListTobeInsert = New List<Contact>();
        List<Account> childAccountTobeInsert = New List<Account>();
        List<Case> caseListTobeInsert = New List<Case>();
        
        
        system.debug('accWrap:::'+accWrap);
        system.debug('accWrap number::'+accWrap.mobile_number);
        system.debug('Opportunity list::'+accWrap.subscriptions);
        
        Account acc = new Account();
        acc.Name =accWrap.name;
        acc.Phone = accWrap.mobile_number;
        acc.Website = accWrap.email;
        accountListtobeInsert.add(acc);
        
        if(accWrap.subscriptions != null && !accWrap.subscriptions.isEmpty()){
            for(AccountMappingWrapper.cls_subscriptions oppDetails : accWrap.subscriptions){
                
                opportunity opp = new opportunity();
                opp.Name = acc.Name + oppDetails.subscription_type;
                opp.Amount = Decimal.ValueOf(oppDetails.amount);
                opp.CloseDate = Date.valueOf(oppDetails.expired_at);
                opp.StageName = 'Prospecting';
                opportunityListTobeInsert.add(opp);
            }
        }
        
        if(accWrap.Contacts!=null && !accWrap.Contacts.isEmpty()){
            for(AccountMappingWrapper.cls_Contacts contactDetails : accWrap.Contacts){
                
                Contact con = New Contact();
                con.FirstName = contactDetails.FirstName;
                con.LastName = contactDetails.LastName;
                con.Email = contactDetails.Email;
                con.Level__c = contactDetails.Level;
                contactListTobeInsert.add(con);
            }
        }
        
        if(accWrap.companies!=null && !accWrap.companies.isEmpty()){
            for(AccountMappingWrapper.cls_companies companyDetails : accWrap.companies){
                if(companyDetails != null){
                    Account childAcc = New Account();
                    childAcc.Name = companyDetails.Name;
                    childAcc.Phone = companyDetails.mobile_number;
                    childAcc.Industry = companyDetails.Industry_Type;
                    childAccountTobeInsert.add(childAcc); 
                }
                
            }
        }
        
        if(accWrap.Cases!=Null && !accWrap.Cases.isEmpty()){
            for(AccountMappingWrapper.cls_Cases caseDetails : accWrap.Cases){
                
                Case caseRec = New Case();
                caseRec.Origin = caseDetails.Case_Origin;
                caseRec.PotentialLiability__c = caseDetails.Potential_Liability;
                caseRec.Status = caseDetails.Status;
                caseListTobeInsert.add(caseRec);
            } 
        }
        
        if(!accountListtobeInsert.isEmpty()){
            response.success_account_list = new list<account>();
            response.failed_account_list = new list<ResponseWrapperClass.failure_account>();
            Database.SaveResult[] result = database.insert(accountListtobeInsert,false);
            for(integer index = 0; index < result.size(); index++){
                if(result[index].isSuccess()){
                    response.success_account_list.add(accountListtobeInsert[index]);
                    
                    
                   if(!contactListTobeInsert.isEmpty()){
                        for(Contact conRec : contactListTobeInsert){
                            conRec.AccountId = accountListtobeInsert[index].Id;
                        }
                    }
                    
                    if(!opportunityListTobeInsert.isEmpty()){
                        for(opportunity opps : opportunityListTobeInsert){
                            opps.AccountId = accountListtobeInsert[index].Id;
                        }
                        
                    }
                    
                    if(!childAccountTobeInsert.isEmpty()){
                        for(Account accs : childAccountTobeInsert){
                            accs.ParentId = accountListtobeInsert[index].Id;
                        }
                    }
                    
                    if(!caseListTobeInsert.isEmpty()){
                        for(Case cases : caseListTobeInsert){
                            cases.AccountId = accountListtobeInsert[index].id;
                        }
                    }
                }else{
                    system.debug('failure account');
                    for(Database.Error err : result[index].getErrors()){
                        ResponseWrapperClass.failure_account failedAccount = New ResponseWrapperClass.failure_account();
                        failedAccount.account_details = accountListtobeInsert[index];
                        failedAccount.error_msg = err.getMessage();
                        response.failed_account_list.add(failedAccount);
                    }
                }  
            }
            
            if(!childAccountTobeInsert.isEmpty()){
                response.success_child_account = new list<account>();
                response.failed_child_account_list = new list<ResponseWrapperClass.failure_child_account>();
                Database.SaveResult[] childAccRes = database.insert(childAccountTobeInsert,false);
                for(integer index = 0; index < childAccRes.size(); index++){
                    if(childAccRes[index].isSuccess()){
                        response.success_child_account.add(childAccountTobeInsert[index]);
                    }else{
                        system.debug('Failure child account');
                        for(Database.Error err : childAccRes[index].getErrors()){
                           ResponseWrapperClass.failure_child_account failedChildAccount = New ResponseWrapperClass.failure_child_account();
                           failedChildAccount.child_account_details = childAccountTobeInsert[index];
                           failedChildAccount.error_msg = err.getMessage();
                           response.failed_child_account_list.add(failedChildAccount);
                        }
                    }
                }
            }
            
            if(!contactListTobeInsert.isEmpty()){
                response.success_contact_list = new list<contact>();
                response.failed_contact_list = new list<ResponseWrapperClass.failure_contact>();
                Database.SaveResult[] conRes = database.insert(contactListTobeInsert,false);
                for(integer index = 0; index < conRes.size(); index++){
                    if(conRes[index].isSuccess()){
                       response.success_contact_list.add(contactListTobeInsert[index]); 
                    }else{
                        system.debug('contact failure');
                        system.debug('contactListTobeInsert[index].getErrors()::'+contactListTobeInsert[index].getErrors());
                        for(Database.Error err : conRes[index].getErrors()){
                            ResponseWrapperClass.failure_contact failedContact = new ResponseWrapperClass.failure_contact();
                            system.debug('inside  error block');
                            //RestApexResponseWrapper.failure_account failedAccountDetail = new RestApexResponseWrapper.failure_account();
                            failedContact.contact_details = contactListTobeInsert[index];
                            failedContact.error_msg = err.getMessage();
                            response.failed_contact_list.add(failedContact);
                            //response.failed_contact_list.add(contactListTobeInsert[index]);
                            //failedAccountDetail.error_msg = err.getMessage();
                            //response.failed_account_list.add(failedAccountDetail);
                        }
                    }
                }
            }
            
            if(!opportunityListTobeInsert.isEmpty()){
                response.success_opportunity_list = new list<opportunity>();
                response.failed_subscription_list = new list<ResponseWrapperClass.failure_subscription>();
                Database.SaveResult[] oppRes = database.insert(opportunityListTobeInsert,false);
                for(integer index = 0; index < oppRes.size(); index++){
                    if(oppRes[index].isSuccess()){
                       response.success_opportunity_list.add(opportunityListTobeInsert[index]); 
                    }else{
                        system.debug('Subscription failure');
                        for(Database.Error err : oppRes[index].getErrors()){
                            ResponseWrapperClass.failure_subscription failedSubscription = new ResponseWrapperClass.failure_subscription();
                            failedSubscription.subscription_details = opportunityListTobeInsert[index];
                            failedSubscription.error_msg = err.getMessage();
                            response.failed_subscription_list.add(failedSubscription);
                        }
                    }
                }
            }
            
            if(!caseListTobeInsert.isEmpty()){
                response.success_case_list = new List<Case>();
                response.failed_case_list = new List<ResponseWrapperClass.failure_case>();
                Database.SaveResult[] caseRes = database.insert(caseListTobeInsert,false);
                for(integer index = 0; index < caseRes.size(); index++){
                    if(caseRes[index].isSuccess()){
                        system.debug('Case success' + caseRes[index]);
                        response.success_case_list.add(caseListTobeInsert[index]);
                        system.debug('Case success List' + response.success_case_list);
                    }else{
                        for(Database.Error err : caseRes[index].getErrors()){
                            ResponseWrapperClass.failure_case failedCase = new ResponseWrapperClass.failure_case();
                            failedCase.case_Details = caseListTobeInsert[index];
                            failedCase.error_msg = err.getMessage();
                            system.debug('Case Failure ' + failedCase);
                            response.failed_case_list.add(failedCase);
                            system.debug('Case Failure List ' + response.failed_case_list);
                        }
                    }
                }
            }
        }
        
        return response;
    }
}