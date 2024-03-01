public class ns_method 
{
    public string col1;
    public string col2;
    public string col3;
    
    public ns_method(string color1, string color2, string color3)
    {
        col1 = color1;
        col2 = color2;
        col3 = color3;
    }
    
    public void show_color()
    {
        system.debug('Color 1 is :'+col1);
        system.debug('Color 2 is : '+col2);
        system.debug('Color 3 is : '+col3);
    }
    
}