@RestResource(urlMapping='/Opportunities/*')
global class CreateOppApi {
    
    @HttpPost
    global static String OpportunityCreate(){
        OpportunityInformatn oppInfoRec = OpportunityInformatn.parse(RestContext.request.requestBody.tostring());
        
        Opportunity oppRec = New Opportunity();
        oppRec.Name = oppInfoRec.Name;
        oppRec.LeadSource = oppInfoRec.LeadSource;
        oppRec.DeliveryInstallationStatus__c = oppInfoRec.DeliveryInstallationStatus;
        oppRec.OrderNumber__c = oppInfoRec.OrderNumber;
        
        insert oppRec;
        return oppRec.Id;
    }

}