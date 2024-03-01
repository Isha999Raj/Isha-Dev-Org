public class APIHelper {
    
    public static string getAccessToken(){
        
        string endpoint = 'https://login.salesforce.com/services/oauth2/token';
        string clientId = '3MVG9pRzvMkjMb6mSFhvaWGM73ZHdGpUAYZ6G59hnRmJKbdAeYxPR9y1OVtn2bhLew6VcGaNgccPZWTD4v1Xi';
        string clientSecret = 'A298B330DE251E216C3202B2252D384F93AAE63C481D6B19422154F13BC00445';
        string username = 'mukeshchawla1991@sfdc.com';
        string password = 'myfamily@1991';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        string reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        request.setBody(reqbody);
        
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200){
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            string access_token = (string) results.get('access_token');
            system.debug('access_token = '+access_token);
            return access_token;
        }
        return null;
    }
    
    public static void getAccount(){
        
       string endpoint =  'https://utilitarianlabspvtltd-dev-ed.my.salesforce.com/services/data/v54.0/query/?q=SELECT+Name+from+Account';
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setHeader('Authorization','Bearer '+getAccessToken());
        
        HttpResponse response = http.send(request);
        system.debug('response'+response.getBody());
        
        if(response.getStatusCode() == 200){
            Map<String,Object> results = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
            system.debug('results'+results);
        }
    }

}