public class practiceSoql
{
    
    //fetching records of Test-5,Test-2,Test-1 by passing id of Test-1 .
    public void FetchingRecords1(string Lid)
    {
        List<Test_7__c> getList = new List<Test_7__c>();
        getList = [SELECT Name,Test_5__r.Name,
                  Test_5__r.Test_2__r.Name,
                  Test_5__r.Test_2__r.Test_1__r.Name
                  FROM Test_7__c WHERE Test_5__r.Test_2__r.Test_1__c=:Lid];
        for(Test_7__c looping : getList)
        {
            if(looping.Test_5__r != NULL)
            {
                system.debug('Test-5 Records : ' +looping.Test_5__r);
            }
            if(looping.Test_5__r.Test_2__r != NULL)
            {
                system.debug('Test-2 Records : ' +looping.Test_5__r.Test_2__r);
            }
            if(looping.Test_5__r.Test_2__r.Test_1__r != NULL)
            {
                system.debug('Test-1 Records : ' +looping.Test_5__r.Test_2__r.Test_1__r);
            }
        }
        
    }
    
    //fetching records of Test-2,Test-4 by passing id of Test-1 .
    public void FetchingRecords2(string Lid)
    {
        List<Test_1__c> getList = new List<Test_1__c>();
        getList = [SELECT Name,id,(SELECT Name,id From Test_2s__r),(SELECT Name,id FROM Test_4s__r)From Test_1__c WHERE id =: Lid];
        for(Test_1__c looping : getList)
        {
           for(Test_2__c fetchRec : looping.Test_2s__r)
           {
               system.debug('Test-2 Records : ' +fetchRec);
           }
            for(Test_4__c fetchRec1 : looping.Test_4s__r)
            {
                system.debug('Test-4 Records : ' +fetchRec1);
            }
        }
    }
    
    //fetching records of Test-4,Test-1 by passing id of Test-1 .
    public void FetchingRecords3(string Lid)
    {
        List<Test_6__c> getList = new List<Test_6__c>();
        getList = [SELECT Name,id,
                   Test_4__r.Name,
                   Test_4__r.Test_1__r.Name
                   FROM Test_6__c WHERE Test_4__r.Test_1__c=: Lid];
        for(Test_6__c looping : getList)
        {
            if(looping.Test_4__r != NULL)
            {
                system.debug('Test-4 Records : ' +looping.Test_4__r);
            }
            if(looping.Test_4__r.Test_1__r != NULL)
            {
                system.debug('Test-1 Records : ' +looping.Test_4__r.Test_1__r);
            }
        }
    }
    
    //fetching records of Test-2,Test-3,Test-4 by passing id of Test-4 .
    public void FetchingRecords4(string Lid)
    {
        List<Test_5__c> getList = new List<Test_5__c>();
        getList = [SELECT Name,Test_2__r.Name,
                   Test_2__r.Test_3__r.Name,
                   Test_2__r.Test_3__r.Test_6_del__r.Test_4__r.Name
                   FROM Test_5__c WHERE Test_2__r.Test_3__r.Test_6_del__r.Test_4__c =: Lid];
        for(Test_5__c looping : getList)
        {
            if(looping.Test_2__r!=NULL)
            {
                system.debug('Test-2 Records : ' +looping.Test_2__r);
            }
            if(looping.Test_2__r.Test_3__r!=NULL)
            {
                system.debug('Test-3 Records : ' +looping.Test_2__r.Test_3__r);
            }
            if(looping.Test_2__r.Test_3__r.Test_6_del__r.Test_4__r!=NULL)
            {
                system.debug('Test-4 Records : ' +looping.Test_2__r.Test_3__r.Test_6_del__r.Test_4__r);
            }
        }
    }
    
    //fetching records of Test-2,Test-7 by passing id of Test-3 .
    public void FetchingRecords5(string Lid)
    {
        List<Test_3__c> getList = new List<Test_3__c>();
        getList = [SELECT Name,id,(SELECT Name FROM Test_2s__r),(SELECT Name FROM Test_7s__r)FROM Test_3__c WHERE ID=:Lid];
        for(Test_3__c looping : getList)
        {
            for(Test_2__c fetchRec : looping.Test_2s__r)
            {
                system.debug('Test-2 Records : ' +fetchRec);
            }
            for(Test_7__c fetchRec1 : looping.Test_7s__r)
            {
                system.debug('Test-7 Records : ' +fetchRec1);
            }
        }
    }
}