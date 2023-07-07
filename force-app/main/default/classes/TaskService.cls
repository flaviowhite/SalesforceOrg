public with sharing class TaskService {
    public TaskService() {}
    
    public void checkToTask(List <Account> accountList){

        try {

            Map<Id, Schema.RecordTypeInfo> recordTypeMap = Schema.SObjectType.Account.getRecordTypeInfosById();
            TaskService taskService = new TaskService();
            List <Task> taskList = new List <Task>();
            Task task = new Task();
    
            for (Account account : accountList){
                if (account.RecordTypeId != null && recordTypeMap.get(account.RecordtypeId).Name == 'Consumidor final'){
                    task = taskService.createTask(account);
                    if (task != null){
                        taskList.add(task);
                    }
                    
                }
            }
    
            taskService.insertTask(taskList);
            
        } catch (Exception e) {
            System.debug('erro ao checar a task');
        }
        
    }

    public Task createTask(Account account){
        try {
            Task task = new Task();
            task.Subject = 'Consumidor Final';
            task.WhatId = account.id;
            task.Status = 'Not Started';
            task.Priority = 'Normal';
    
            return task;
            
        } catch (Exception e) {
            System.debug('erro ao criar a task');
        }
        return null;
       
    }

    public void insertTask(List <Task> taskList){
        if(taskList.size() > 0 ){
            Database.insert(taskList);
        }
    }

}