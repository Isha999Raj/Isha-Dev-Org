public class RecordQuery
{
    public List<sObject> GetRecord(string accid, String RecordName)
    {
        try{
            
            if(accid != NULL)
            {
                if(RecordName == 'CONTACTS')
                {
                    return [SELECT Name,Phone, (SELECT FirstName FROM CONTACTS) FROM Account WHERE ID =: accid].CONTACTS;
                }
                else if(RecordName == 'OPPORTUNITIES')
                {
                    return [SELECT Name,Phone, (SELECT Amount FROM OPPORTUNITIES) FROM Account WHERE ID =: accid].OPPORTUNITIES;
                }
                else
                {
                    return NULL;
                }
            }
            else
            {
                return NULL;
            }
            
        }catch(Exception e)
        {
            return NULL;
        }
            }
}