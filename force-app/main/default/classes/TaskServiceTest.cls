@isTest
public class TaskServiceTest {
    @TestSetup
    static void makeData(){

        Account acc3 = new Account();
        acc3.Name = 'Flavio Branco';
        acc3.AccountNumber = '23456789121';
        acc3.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc3.RecordTypeId = recordTypeId;
        insert acc3;
        
    }

    @isTest
    static void checkToTaskTest(){
        TaskService taskService = new TaskService();
        List <Account> accountList = [SELECT id, RecordTypeId FROM Account];
        Test.startTest();
        taskService.checkToTask(accountList);
        Test.stopTest();
    }

    @isTest
    static void checkToTaskErrorTest(){
        TaskService taskService = new TaskService();
        List <Account> accountList = [SELECT id FROM Account];
        Test.startTest();
        taskService.checkToTask(accountList);
        Test.stopTest();
    }

    @isTest
    static void createTaskTest(){
        TaskService taskService = new TaskService();
        List <Account> accountList = [SELECT id, RecordTypeId FROM Account];
        Test.startTest();
        taskService.createTask(accountList[0]);
        Test.stopTest();
    }

    @isTest
    static void createTaskErrorTest(){
        TaskService taskService = new TaskService();
        Account account;
        Test.startTest();
        taskService.createTask(account);
        Test.stopTest();
    }

    @isTest
    static void insertTaskTest(){
        List <Task> taskList =  new List <Task>();
        TaskService taskService = new TaskService();
        Task task = new Task();
        task.Subject = 'Comsumidor Final';
        task.Status = 'Not Started';
        task.Priority = 'Normal';
        taskList.add(task);
        Test.startTest();
        taskService.insertTask(taskList);
        Test.stopTest();
    }
}