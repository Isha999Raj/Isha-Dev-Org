public class objectController {
    
    //relationshipName
    public void createField(String objectapiname,String fieldapiname,String fieldlabel,String fielddescription,String fieldType, String referenceTo, String relationshipName){
        
        Http http = new Http();
        HttpRequest requestinside = new HttpRequest();
        requestinside.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        requestinside.setHeader('Content-Type', 'application/json');
        requestinside.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v41.0/tooling/sobjects/CustomField/');
        requestinside.setMethod('POST');
        String fieldDef = '{"Metadata" : ';
        String metadef = '"type" : "'+fieldType+'","description" : "'+fielddescription+'", "inlineHelpText" : "","precision" : null,"label" : "'+fieldlabel+'","referenceTo" : "'+referenceTo+'","relationshipName" : "'+relationshipName+'"';
        fieldDef += '{'+metadef+'},';
        fieldDef += '"FullName" : "'+objectapiname+'.'+fieldapiname+'__c"}';
        system.debug(fieldDef);
        requestinside.setBody(fieldDef);
        HTTPResponse res = http.send(requestinside);
        System.debug(res.getBody());
        
    }
    
    public static void fetchPhoneType(String objectAPIName){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectAPIName).getDescribe().fields.getMap();
        for (String fieldName : fieldMap.keySet()) {
            DescribeFieldResult descFieldRes = fieldMap.get(fieldName).getDescribe();
            
            if (descFieldRes.getType() == Schema.DisplayType.Phone) {
                System.debug(fieldName);
            }
        }
    }
    
}