public class changeLeadStage {
    
    public static void leadStageNew(List<lead> leadList){
        
        List<Lead> lead1 = [SELECT Id,Lead_Stage__c From Lead WHERE Lead_Stage__c = 'New'];
        for(Lead leadRec : lead1){
            if(leadRec.IsConverted == True){
                leadRec.Lead_Stage__c = 'Called';
            }
        }
    }
    
    public static void leadStageCalled(List<Lead> leadList){
        
        List<Lead> lead2 = [SELECT Id,Lead_Stage__c From Lead Where Lead_Stage__c = 'Called'];
        for(Lead leadRec : lead2){
            if(leadRec.IsConverted == True){
                leadRec.Lead_Stage__c = 'Nurturing';
            }
        }
    }
    
    public static void leadStageNurturing(List<Lead> leadList){
        
        List<Lead> lead3 = [SELECT Id,Lead_Stage__c From Lead Where Lead_Stage__c = 'Nurturing'];
        for(Lead leadRec : lead3){
            if(leadRec.IsConverted == True){
                leadRec.Lead_Stage__c = 'Closed Won';
            }
        }
    }

}