public class s_method 
{
    
    public static integer stud_id;
    public static string stud_name;
    public static string course;
    
    public s_method(integer sid, string nm, string crs)
    {
    stud_id = sid;
    stud_name = nm;
    course = crs;
    }
    
    public static void  get_info()
    {
        system.debug('student id is : '+stud_id);
        system.debug('student name is : '+stud_name);
        system.debug('student course is : '+course);
    }

}