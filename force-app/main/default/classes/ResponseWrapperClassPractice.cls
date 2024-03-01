global with sharing class ResponseWrapperClassPractice {
    
    global class ResponseWrapper{
        
        global List<Account> success_account_list;
        global List<Account> success_Child_account_list;
        global List<Contact> success_contact_list;
        global List<Opportunity> success_subscription_list;
        global List<Case> success_case_list;
        
        global List<failure_Account> failure_account_list;
        global List<failure_companies> failure_company_list;
        global List<failure_Contact> failure_contact_list;
        global List<failure_subscription> failure_subscription_list;
        global List<failure_case> failure_case_list;
    }
    
    global class failure_Account{
        public account account_details;
        public string error_msg;
    }
    
    global class failure_companies{
        public account company_details;
        public string error_msg;
    }
    
    global class failure_Contact{
        public contact contact_details;
        public string error_msg;
    }
    
    global class failure_subscription{
        public opportunity subscription_details;
        public string error_mg;
    }
    
    global class failure_case{
        public case case_details;
        public string error_msg;
    }

}