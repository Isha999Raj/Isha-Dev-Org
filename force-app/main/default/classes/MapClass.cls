public class MapClass
{
    public void Inserting_Data()
    {
        Map<integer,string> Map1 = new Map<integer,string>{1=>'Isha',2=>'Kishan'};
        Map1.put(3,'Anjali');
        Map1.put(4,'Vighnesh');
        system.debug('Map1 Records :- ' +Map1);
        Map1.remove(3);
        system.debug('Updated Map1 Records :- ' +Map1);
        system.debug('Size of Map1 : ' +Map1.size());
        system.debug('Keys in Map1 are : ' +Map1.keyset());
        system.debug('Values in Map1 are : ' +Map1.values());
        for(integer key : Map1.keyset())
        {
            string a = Map1.get(key);
            system.debug(a);
        }
       //Map1.clear();
       //system.debug('clear ' +Map1);
       //Map1.clone();
       //system.debug('clone : ' +Map1);
       
       
    }
    
    public void Inserting_str_Listofstr()
    {
        List<string> list1 = new List<string>{'Ajeet','Prithvi'};
        list1.add('Ravi');
        list1.add('Mukesh');
        Map<string,List<string>> strMap = New Map<string,List<string>>{'5'=>list1};
        system.debug('List of string values in an unique key :- ' +strMap);
        
    }
    
    
    public void Inserting_Liststr()
    {
        Map<ID, Account> m3 = New Map<ID,Account>([SELECT ID, Name, Phone From Account]);
        for (ID key : m3.keyset())
        {
            Account a = m3.get(key);
            system.debug(a.ID+ '=' +a.Name+' ' +a.Phone);
        }
         system.debug('values are : ' +m3.values());
    }
    
    public void liststr()
    {
     //List<contact> contactList = New List<contact>();
     Map<Account,List<Contact>> contactListByAccount = New Map<Account,List<Contact>>(); 
     for(Account acc : [SELECT Name,(SELECT FirstName,LastName FROM Contacts) FROM Account])
     {
         contactListByAccount.put(acc,acc.contacts);
         system.debug(acc.Name+':'+acc.contacts);
     }
    }
    
    public void mapOfmAap()
        {
          Map<string,Map<integer,string>> mapping = New Map<string,Map<integer,string>>();
          Map<integer,string> innerMapping = New Map<integer,string>();
          innerMapping.put(1,'A');
          innerMapping.put(2,'B');
          system.debug(innerMapping);
          mapping.put('3',innerMapping);
          system.debug(mapping);
        }
    
    public void mapOfmap2()
    {
        
    }
}