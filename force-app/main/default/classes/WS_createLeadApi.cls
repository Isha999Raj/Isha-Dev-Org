@RestResource(urlMapping='/createLead/*')
global class WS_createLeadApi {
    @HttpPost
    global static String leadCreate(){
        system.debug('LeadRequestList::'+RestContext.request.requestBody.tostring());
        LeadInfo leadInfoRec = LeadInfo.parse(RestContext.request.requestBody.tostring());
        system.debug('leadInfoRec::'+leadInfoRec.EmailAddress);
		
        Lead leadRec = new Lead();
        leadRec.Firstname = leadInfoRec.FirstName;
        leadRec.LastName = leadInfoRec.LastName;
        leadRec.Email = leadInfoRec.EmailAddress;
        leadRec.Company = 'DEFAULT';
        leadRec.mx_Class_Course__c = leadInfoRec.mx_Class_Course;
        
        insert leadRec;
        return leadRec.Id;
    }
}