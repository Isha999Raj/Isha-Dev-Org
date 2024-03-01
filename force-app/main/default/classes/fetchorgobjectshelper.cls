public with sharing class fetchorgobjectshelper {
    
    @RemoteAction
    public static Map<String,String> getSelectedobjnames()
    {
        Map<String,String> allObjectNameByAPI = new Map<String,String>();
        List<Schema.SObjectType> obj = Schema.getGlobalDescribe().Values();
        for(Schema.SObjectType st : obj)
        {
            allObjectNameByAPI.put(st.getDescribe().getName(),st.getDescribe().getLabel());
        }
        return allObjectNameByAPI;
    }
    
    @RemoteAction
    public static Map<String,String> allFieldByAPI(String ObjectName)
    {
        Map<String,String> allFieldByAPI = new Map<String,String>();
        
        SObjectType objTyp = Schema.getGlobalDescribe().get(ObjectName);
        DescribeSObjectResult objDef = objTyp.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();
        
        Set<String> fieldSet = fields.keySet();
        List<SelectOption> options = new List<SelectOption>();
        for(String s:fieldSet)
        {  
            SObjectField Sobjfields = fields.get(s);
            DescribeFieldResult selectedField = Sobjfields.getDescribe();  
            if(selectedField.isUpdateable() || selectedField.isIdLookup())
            allFieldByAPI.put(selectedField.getName(),selectedField.getLabel());
        }
        return allFieldByAPI;
    }
    
    @RemoteAction
    public static list<sObject> queryFields(string SobjectField)
    {
        List<sObject> RecordList = Database.query(SobjectField);
        return RecordList;
    }
    
    
    @RemoteAction
    public static string getAccessToken(){
        
        string endpoint = 'https://login.salesforce.com/services/oauth2/token';
        string clientId = '3MVG9pRzvMkjMb6k.Ka41BwgSg7U90n.gfj81Kax3QkoJiI_dC07kuYh0E9UclILgtx2M8r.DKxMKHKbNvWyl';
        string clientSecret = '10A00D5037C737804DD7065BC5863C3FA457F607F5ACC657EFBABF8367C74DD4';
        string username = 'dineshb@utilitarianlab.com';
        string password = 'sfdc@2022';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        string reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        request.setBody(reqbody);
        
        HttpResponse response = http.send(request);
        system.debug(response);
        if(response.getStatusCode() == 200){
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            string access_token = (string) results.get('access_token');
            system.debug('access_token = '+access_token);
            return access_token;
        }
        return null;
    }
    
    
    @RemoteAction
    public static List<Object> getRecords(string Query){
        
        string endpoint =  'https://utilitarianlabsprivatelimit-dev-ed.my.salesforce.com/services/data/v54.0/query/?q='+Query;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Authorization','Bearer '+getAccessToken());
        
        HttpResponse response = http.send(request);
        system.debug('response'+response.getBody());
        Map<String,Object> results;
        List<Object> accountRecordsList;
        if(response.getStatusCode() == 200){
            results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('results'+results);
            if(results != null && results.containsKey('records'))
            {
                accountRecordsList = (List<Object>) results.get('records');
                System.debug('--- accList'+accountRecordsList);
            }
        }
        return accountRecordsList;
    }
    
    @RemoteAction
    public static  string deleteRecords(string idtoDelete, string selectedObjectRowData){
        
        system.debug('id : '+idtoDelete);
        system.debug('object : '+selectedObjectRowData);
        string endpoint =  'https://utilitarianlabsprivatelimit-dev-ed.my.salesforce.com/services/data/v25.0/sobjects/'+selectedObjectRowData+'/'+idtoDelete;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('DELETE');
        request.setHeader('Authorization','Bearer '+getAccessToken());
        
        HttpResponse response = http.send(request);
        Map<string,Object> result = (Map<string,Object>) JSON.deserializeUntyped(response.getBody());
        if(response.getStatusCode() == 200) {
            System.debug('results=>'+result);
            return 'success';
        } 
        return null;
    }
    
    @RemoteAction
    public static void updateRecords(Lead conRec,String recid,String Obj){
        System.debug('@@@@ Conrec'+conRec);
        //idtoUpdate = '00Q5j000007KNE7EAO';
        string endpoint = 'https://utilitarianlabsprivatelimit-dev-ed.my.salesforce.com/services/data/v25.0/sobjects/'+Obj+'/'+recid;
        Http http = New Http();
        HttpRequest request = New HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('PATCH');
        request.setHeader('Authorization','Bearer ' +getAccessToken());
        request.setHeader('Content-Type','application/JSON');

        request.setBody(JSON.serialize(conRec));
        HttpResponse response = http.send(request);
        system.debug('response :-' +response);
        if(response.getStatusCode() == 200){
            Map<String,Object> getResult = (Map<String,Object>) JSON.deserializeUntyped(response.getBody()); 
            system.debug('Result =>' +getResult);
        }
    }
}