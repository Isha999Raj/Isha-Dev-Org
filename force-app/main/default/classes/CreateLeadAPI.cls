@RESTResource(urlMapping='/LeadCreate/')
global class CreateLeadAPI
{
    
    @HTTPPost
    global static string doPost()
    {
        return 'Hey';
    }
}