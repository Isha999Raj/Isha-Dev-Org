public class StudentHelper {

    public static List<StudentWrapper> studentList;
    public StudentHelper (){
        studentList = new  List<StudentWrapper>();
    }
    public Static void insertStudent(StudentWrapper stuWrap){
        studentList.add(stuWrap);
    }
    public Static List<String> getStudentByHobby(String hobby){
        map<String,List<String>> studentsByTheirHobbies = new map<String,List<String>>();
        
        for(StudentWrapper stuWarp:studentList){
            //studentsByTheirHobbies.put(stuWarp.Email,)
            //studentsByTheirHobbies.put()
            for(String eachHobby:stuWarp.hobbies){
                if(studentsByTheirHobbies.containsKey(eachHobby)){
                    studentsByTheirHobbies.get(eachHobby).add(stuWarp.Email);
                }else{
                   studentsByTheirHobbies.put(eachHobby,new list<String>{stuWarp.Email});

                }
                
            }
        }
        return studentsByTheirHobbies.get(hobby);
    }
}