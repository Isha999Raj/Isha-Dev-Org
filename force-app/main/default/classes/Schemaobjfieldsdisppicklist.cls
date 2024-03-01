public class Schemaobjfieldsdisppicklist {
    public map<String,Schema.SObjectType> objmap {set;get;}
    public list <selectoption> objects {set;get;}
    public list <selectoption> fields {set;get;}
    public String Selected {set;get;}
    public  Schemaobjfieldsdisppicklist (){
        objects = new list <selectoption>();
        fields = new list <selectoption>();
        selectoption n =new Selectoption('None' ,'-None-');
        objects.add(n);
        fields.add(n);
        //fetch all object from the salesforce metedata
        objmap = Schema.getGlobalDescribe();
        // fetch all the object names from the Map
        set<String> keys =objmap.keyset();
        // create a list to Store Object names And store them
        List<String> objnames = new list<String> (Keys);   
        objnames.sort();
        // take one by one objectname and create them  as picklist option
        for(String s : objnames){
            selectoption op = new selectoption(s,s);
            objects.add(op);
        }
    }
    public void getdata(){
        fields.clear();
        selectoption n =new Selectoption('None' ,'-None-');
        if(selected !='None'){
            schema.SObjectType obj =objmap.get(Selected);   
            //get the description of the give Sobject
            Schema.DescribeSObjectResult result = obj.getDescribe();
            map<String,Schema.SObjectField> fldmap = result.fields.getmap();
            set<String> keys =fldmap.keyset();
            List<String> fldnames = new list<String> (Keys);   
            fldnames.sort();
            for(String s: fldnames){
                Selectoption p = new selectoption(s,s);    
                fields.add(p);
            }
            
        }else{
            fields.add(n);           
            
        }
    }
}