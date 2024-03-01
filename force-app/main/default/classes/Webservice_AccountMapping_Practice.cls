@RestResource(urlMapping='/accountmapping/*')

global class Webservice_AccountMapping_Practice {
    
    @HttpPost
    global static void accountMapping(){
        
        ResponseWrapperClassPractice.ResponseWrapper response = New ResponseWrapperClassPractice.ResponseWrapper();
        AccountMappingWrapperPractice accWrap = New AccountMappingWrapperPractice();
        accWrap = AccountMappingWrapperPractice.parse(RestContext.request.requestBody.tostring());
        
        List<Account> accountToBeInserted = New List<Account>();
        List<Account> companyToBeInserted = New List<Account>();
        List<Contact> contactToBeInserted = New List<Contact>();
        List<Opportunity> opportunityToBeInserted = New List<Opportunity>();
        List<Case> caseToBeInserted = New List<Case>();
        
        Account accRec = New Account();
        accRec.Phone = accWrap.mobile_number;
        accRec.Name = accWrap.name;
        accRec.Website = accWrap.email;
        accountToBeInserted.add(accRec);
        
        if(accWrap.companies != NULL && !accWrap.companies.isEmpty()){
            for(AccountMappingWrapperPractice.cls_companies companyDetails : accWrap.companies){
                Account childAccRec = New Account();
                childAccRec.Phone = companyDetails.mobile_number;
                childAccRec.Website = companyDetails.email;
                childAccRec.Industry = companyDetails.Industry_type;
                companyToBeInserted.add(childAccRec);
            }
        }
        
        if(accWrap.contacts != NULL && !accWrap.contacts.isEmpty()){
            for(AccountMappingWrapperPractice.cls_contact contactDetails : accWrap.contacts){
                Contact conRec = New Contact();
                conRec.FirstName = contactDetails.FirstName;
                conRec.LastName = contactDetails.LastName;
                conRec.Email = contactDetails.email;
                conRec.Level__c = contactDetails.Level;
                contactToBeInserted.add(conRec);
            }
        }
        
        if(accWrap.subscriptions != NULL && !accWrap.subscriptions.isEmpty()){
            for(AccountMappingWrapperPractice.cls_subscription subscriptionDetails : accWrap.subscriptions){
                Opportunity oppRec = New Opportunity();
                oppRec.Name = subscriptionDetails.subscription_type;
                oppRec.Amount = Decimal.valueOf(subscriptionDetails.amount);
                oppRec.CloseDate = Date.valueOf(subscriptionDetails.expired_at);
                opportunityToBeInserted.add(oppRec);
            }
        }
        
        if(accWrap.cases != NULL && !accWrap.cases.isEmpty()){
            for(AccountMappingWrapperPractice.cls_case caseDetails : accWrap.cases){
                Case caseRec = New Case();
                caseRec.Origin = caseDetails.Case_Origin;
                caseRec.PotentialLiability__c = caseDetails.Potential_Liability;
                caseRec.Status = caseDetails.Status;
                caseToBeInserted.add(caseRec);
            }
        }
    }
}