public class s_ns_block {
    public static integer id=0;
    public static string name;
    
    //non static block
    {
        id--;
    }
    
    //static block
    static{
        id++;
    }
    
    //static block
    static{
        id++;
    }
    public void name(string n)
    {
        name = n;
        system.debug('Name is ' +name);
    }

}