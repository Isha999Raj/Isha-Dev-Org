public class MapsTest {
    Public static void mapsMethod(){
        Map<string,string> stringByString = new Map<String, String>();
        Map<String, List<contact>> listOfStringByString = new Map<String, List<contact>>();
        Map<String, Map<String,List<String>>> complexMap = new Map<String, Map<String,List<String>>>();
        
        //1. .values()
            List<String> stringList = stringByString.values();
        //2. .keySet();
        set<String> kySetList = stringByString.keyset();
        // .containsKey(key) -boolean
        // .get(key)
        // 1.Isha : Vf page
        // 2.Anjali: Flow
        // 3.Dinesh: Batch
        // 4.Isha : Aura
        // 5.Anjali: trigger
        // 6.Dinesh: Test
        List<Contact> contactList = [Select Id,Name,Email,Phone From Contact];
        
        for(contact conRec : contactList){
            if(listOfStringByString.containsKey(conRec.Email)){
                List<contact> allVal = listOfStringByString.get(conRec.Email);
                allVal.add(conRec);
                listOfStringByString.put(conRec.Email, allVal);
            }else{
                listOfStringByString.put(conRec.Email, new List<Contact>{conRec});
            }
        }
        
    }
}