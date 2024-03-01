public class AccountMappingWrapperPractice {
    
    public string mobile_number;
    public string name;
    public string email;
    public cls_companies[] companies;
    public cls_contact[] contacts;
    public cls_subscription[] subscriptions;
    public cls_case[] cases;
    
    
    public class cls_companies{
        public string mobile_number;
        public string email;
        public string Industry_type;
    }
    
    public class cls_contact{
       public string FirstName;
       public string LastName;
       public string email;
       public string Level;
    }
    
    public class cls_subscription{
        public string subscription_type;
        public string expired_at;
        public string amount;
    }
    
    public class cls_case{
        public string Case_Origin;
        public string Potential_Liability;
        public string Status;
    }
    
    public static AccountMappingWrapperPractice parse(string json){
        return (AccountMappingWrapperPractice) System.JSON.deserialize(json, AccountMappingWrapperPractice.class);
    }

}