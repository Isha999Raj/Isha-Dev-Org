global with sharing class ResponseActivityWrapper {
    
    global class ResponseWrapper{
        
        global List<Task> success_activity_list;
        global List<failure_activity> failed_activity_list;
    }
    
    global class failure_activity{
        public ActivityWrapperClass.cls_activity activity_details;
        public string error_msg;
    }

}