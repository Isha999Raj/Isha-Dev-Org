public class vFClass2
{
    List<Opportunity> oppRec = [SELECT Name,Amount FROM Opportunity];
    
    public List<Opportunity> getoppRec()
    {
        return oppRec;
    }
}