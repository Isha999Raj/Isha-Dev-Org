public class vFClass
{
    List<Account> accRec = [SELECT Name,id,Industry FROM Account WHERE Industry=:'Energy'];
    List<Account> accRec2 = [SELECT Name,Id,Industry FROM Account WHERE Industry=:'Electronics'];
    public List<Account> getaccRec()
    {
        return accRec;
    }
    
    public List<Account> getaccRec2()
    {
        return accRec2;
    }
    
}