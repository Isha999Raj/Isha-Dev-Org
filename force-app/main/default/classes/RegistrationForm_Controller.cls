public without sharing class RegistrationForm_Controller {
    
    public string candidateRecord  {get;set;}
    public string computerSkillList  {get;set;}
    public string crownPickListVal  {get;set;}
    public string xRayProficiencyPickListVal  {get;set;}
    public string pmsKnowledgePickListVal  {get;set;}
    public string imageSoftwarePickListVal  {get;set;}
    
    public RegistrationForm_Controller(){
        //string candidateId = Apexpages.currentPage().getParameters().get('id');
            
           // candidateRecord = JSON.serialize([SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE RecordType.Name = 'Candidate' AND Id =: candidateId]);
            computerSkillList = JSON.serialize(Utility.getPicklistValues('Contact' , 'Computer_Skills__c'));
            crownPickListVal = JSON.serialize(Utility.getPicklistValues('Contact' , 'Types_of_Crowns__c'));
            xRayProficiencyPickListVal = JSON.serialize(Utility.getPicklistValues('Contact' , 'X_ray_Proficiency__c'));
            pmsKnowledgePickListVal = JSON.serialize(Utility.getPicklistValues('Contact' , 'PMS_Knowledge__c'));
            imageSoftwarePickListVal = JSON.serialize(Utility.getPicklistValues('Contact' , 'Image_X_ray_Software__c'));
    }
    
    @RemoteAction
    public static String insertContact(Contact contactDetails){
        try{
            insert contactDetails;
            return 'SUCCESS'; 
        }catch(exception e){
            return 'ERROR';
        }
    }
    
    @RemoteAction
    public static String updateMutiPicListVal(contact contactDetails, List<String> listOfString){
        
        system.debug('listOfString :: ' +listOfString);
        String str = String.join(listOfString,';');
        system.debug('str :: ' +str);
        contactDetails.Computer_Skills__c = str;
        insert contactDetails;
        return contactDetails.Id;
    } 
}