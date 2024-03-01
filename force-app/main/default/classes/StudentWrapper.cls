public class StudentWrapper {
	public String FirstName;
    public String LastName;
    public String Email;
    public List<String> hobbies;
    
    public StudentWrapper(String FirstName,String LastName,String Email,List<String> hobbies){
        this.FirstName = FirstName;
        this.LastName = LastName;
        this.Email = Email;
        this.hobbies = hobbies;
    }
}