public class ActivityWrapperClass {
    
    public cls_activity[] Activity;
    
    public class cls_activity{
        
        public string activity_type;
        public string search_by_value;
        public string exam_date;
        public string activity_note;
        public string exam_name;
        public string exam_slug;
        public string subject;
        public Decimal exam_score;
        public string skill_based_exam_score;
        public Boolean is_qualified_in_exam; 
        
    }
    
     public static ActivityWrapperClass parse(string json){
        return (ActivityWrapperClass) System.JSON.deserialize(json, ActivityWrapperClass.class);
    }
    
    
}