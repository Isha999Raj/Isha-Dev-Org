public class Test7 {
    public void FetchRecords1(string Lid7)
    {
        List<Test_7__c> getList = new List<Test_7__c>();
        getList = [SELECT Name,Test_5__r.Name,
                   Test_5__r.Test_2__r.Name,
                   Test_5__r.Test_2__r.Test_1__r.Name
                   FROM Test_7__c WHERE Test_5__r.Test_2__r.Test_1__c=:Lid7];
        //system.debug('Records of Test-7 : ' +getList);
        //system.debug('Records of Test-5 : ' +getList[0].Test_5__r);
        //system.debug('Records of Test-2 : ' +getList[0].Test_5__r.Test_2__r);
        //system.debug('Records of Test-1 : ' +getList[0].Test_5__r.Test_2__r.Test_1__r);
        for(Test_7__c looping:getList)
        {
           if(looping.Test_5__r != NULL)
           {
               system.debug(looping.Test_5__r);
           }
           if(looping.Test_5__r.Test_2__r != NULL)
           {
               system.debug(looping.Test_5__r.Test_2__r);
           } 
           if(looping.Test_5__r.Test_2__r.Test_1__r != NULL)
           {
               system.debug(looping.Test_5__r.Test_2__r.Test_1__r);
           }    
        }
        
    }
    
    public void FetchRecords2(string Lid1)
    {
        List<Test_1__c> getList = new List<Test_1__c>();
        getList = [SELECT Name,id,(SELECT Name,id FROM Test_2s__r),(SELECT Name,id FROM Test_4s__r)FROM Test_1__c WHERE id=:Lid1];
        //system.debug('Records of Test-1 : ' +getList);
        //system.debug('Records of Test-2 : ' +getList[0].Test_2s__r);
        //system.debug('Records of Test-4 : ' +getList[0].Test_4s__r);
        for(Test_1__c looping:getList)
        {
            // system.debug('Records of Test-2 : ' +looping.Test_2s__r); 
            // system.debug('Records of Test-4 : ' +looping.Test_4s__r); 
            for(Test_2__c TestRecord2 : looping.Test_2s__r)
            {
                system.debug('Records of Test-2 : ' +TestRecord2);
            }
            for(Test_4__c TestRecord4 : looping.Test_4s__r)
            {
                system.debug('Records of Test-4 : ' +TestRecord4);
            }
        }
        
    }
    
    public void FetchRecords3(string Lid1)
    {
        List<Test_6__c> getList = new List<Test_6__c>();
        getList = [SELECT Name,id,
                   Test_4__r.Name,
                   Test_4__r.Test_1__r.Name FROM Test_6__c WHERE Test_4__r.Test_1__c=:Lid1];
        for(Test_6__c looping:getList)
        {
           if(looping.Test_4__r != NULL)
           {
               system.debug(looping.Test_4__r);
           }
           if(looping.Test_4__r.Test_1__r != NULL)
           {
               system.debug(looping.Test_4__r.Test_1__r);
           }
        }
    }
    
    public void FetchRecords4(string Lid5)
    {
        List<Test_5__c> getList = new List<Test_5__c>();
        //getList = [SELECT Name,id,Test_2__r.Name, Test_2__r.Test_3__r.Name, Test_2__r.Test_1__r.Test_4s__r.Name FROM Test_5__c WHERE id=:Lid5];
        
    }
    
    public void FetchRecords5(string Lid3)
    {
        List<Test_3__c> getList = new List<Test_3__c>();
        getList = [SELECT Name,id,(SELECT Name,id FROM Test_2s__r),(SELECT Name,id FROM Test_7s__r)FROM Test_3__c WHERE id=:Lid3];
        for(Test_3__c looping:getList)
        {
            for(Test_2__c TestRecord2 : looping.Test_2s__r)
            {
                system.debug('Records of Test-2 : ' +TestRecord2);
            }
            for(Test_7__c TestRecord7 : looping.Test_7s__r)
            {
                system.debug('Records of Test-7 : ' +TestRecord7);
            }
        }
        
    }
    
}



/*for(Test_1__c looping:getList)
{
if(looping != NULL)
{
List<Test_2__c> Test2List = New List <Test_2__c>();
system.debug(Test2List);

}
else
{
system.debug('SORRY !!!  There is no Records here....');
}
}

}*/