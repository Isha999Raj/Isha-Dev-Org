public without sharing class CustomerPortal_Controller {

    public string tabValues {get;set;}
    public string candidateRecord  {get;set;}
    public string computerSkillList  {get;set;}
    public string crownPickListVal  {get;set;}
    public string xRayProficiencyPickListVal  {get;set;}
    public string pmsKnowledgePickListVal  {get;set;}
    public string imageSoftwarePickListVal  {get;set;}
    
    public CustomerPortal_Controller() {

        list<Customer_Dashboard_Tabs__c> cdTabs = [select name,Tab_Label__c,id,Controller_Name__c,Display_Order__c from Customer_Dashboard_Tabs__c ORDER BY Display_Order__c];
        tabValues = JSON.serialize(cdTabs);
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
            return contactDetails.Id; 
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