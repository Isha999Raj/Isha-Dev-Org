trigger PracticeTrigger on Account (before insert, after insert, before update, after Update, before Delete, After Delete, After Undelete)
{
    /*before insert on account
    if(Trigger.isInsert)
    {
        if(Trigger.isbefore)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc.id);  
            }
        }
    }
    
    if(Trigger.isInsert)
    {
        if(Trigger.isbefore)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.id);  
            }
        }
    }
    
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc.id);  
            }
        }
    }
    
    if(Trigger.isInsert)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.id);  
            }
        }
    }
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc.id);  
            }
        }
    }
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isBefore)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.Name);  
            }
        }
    }
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc);  
            }
        }
    }
    
    if(Trigger.isUpdate)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.Name);  
            }
        }
    }
    
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc.Name);  
            }
        }
    }
    
    if(Trigger.isDelete)
    {
        if(Trigger.isBefore)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.Name);  
            }
        }
    }
    
    if(Trigger.isDelete)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.old)
            {
              system.debug(acc.Name);  
            }
        }
    }
    
    if(Trigger.isDelete)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.new)
            {
              system.debug(acc.Name);  
            }
        }
    }*/
    
    if(Trigger.isUndelete)
    {
        if(Trigger.isAfter)
        {
            for(Account acc:Trigger.New)
            {
              system.debug(acc.Name);  
            }
        }
    }
}