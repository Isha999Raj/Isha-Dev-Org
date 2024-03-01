public class s_ns_cons_fun 
{
    
    //static variable
    public static integer roll=0;
    
    //non static variable
    public string name;
    
    //non static block
    {
        system.debug(--roll);
        system.debug(roll);  
    }
    
    //static block
    static{
        roll++;
        system.debug(roll);
    }
    
    //non-static method
    public void meth(string name)
    {
        system.debug('non-static method call!!!!');
        system.debug(name);
    }
    
    //static method
    public static void method()
    {
        system.debug('static method call!!!!');
    }
    
    //constructor
    public s_ns_cons_fun()
    {   
        system.debug('constructor call!!!');
        system.debug(roll);
    }
}