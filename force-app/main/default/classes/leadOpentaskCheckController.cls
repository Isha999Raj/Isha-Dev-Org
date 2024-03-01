public class leadOpentaskCheckController {
    
    public static void checkTask(List<Task> taskList){
        
        Map<Id,Task> taskMap = New Map<Id,Task>();
        for(Task t1 : taskList){
            
            if(t1.WhatId != NULL){
                taskMap.put(t1.WhatId,t1); 
            }
         
        }
        
        List<Task> newTask = New List<Task>();
        if(taskMap.size() > 0){
            List<Lead> leadList = [SELECT Id,Status From Lead Where Id IN : taskMap.keySet()];
            for(Lead l1 : leadList){
                if(l1.Status == 'Open'){
                    l1.addError('Task is alreadyOpen , No need create other task');
                }
                else{
                    Task createTask = New Task();
                    createTask.WhoId = l1.Id;
                    createTask.Subject = 'New task with customer ....';
                    createTask.Status = 'Open';
                    newTask.add(createTask);
                }
                insert newTask;
            }
        }
    }
}