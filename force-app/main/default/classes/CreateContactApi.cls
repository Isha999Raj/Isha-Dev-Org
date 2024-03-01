@RestResource(urlMapping='/Contacts/*')
global class CreateContactApi {
    
    @HttpPost
    global static String ContactCreate(){
        ContactInformatn contactInfoRec = ContactInformatn.parse(RestContext.request.requestBody.tostring());
        
        Contact conRec = New Contact();
        conRec.FirstName = contactInfoRec.FirstName;
        conRec.LastName = contactInfoRec.LastName;
        conRec.Email = contactInfoRec.Email;
        conRec.Job_Title__c = contactInfoRec.Job_Title;
        
        insert conRec;
        return conRec.Id;
    }

}