public class PersonalInformation
{
    public integer student_roll_no;
    public PersonalInfo personalDetails;
    
    public class PersonalInfo
    {
        public Name nameInfo;
        public Address addressInfo;
        public Others otherInfo;
    }
    
    public class Name
    {
      public string FirstName;
      public string LastName;
    }
    
    public class Address
    {
      public string AddressLine1;
      public string AddressLine2;
      public string AddressLine3;
    }
    
    public class Others
    {
        public integer Age;
        public string Nationality;
    }
}