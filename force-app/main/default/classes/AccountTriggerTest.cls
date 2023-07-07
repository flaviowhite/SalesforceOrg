@isTest
public  class AccountTriggerTest {


    @isTest
    static void finalConsumerAccontTest(){
        Account acc = new Account();
        acc.Name = 'Flavio Branco';
        acc.AccountNumber = '12345678912';
        acc.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc.RecordTypeId = recordTypeId;

        Test.startTest();
        insert acc;
        Test.stopTest();
        List <Task> taskList = [SELECT Subject, Status, Priority FROM Task WHERE WhatId = :acc.Id];
        if (taskList.size() > 0){
            System.assertEquals('Consumidor Final', taskList[0].Subject);
            System.assertEquals('Not Started', taskList[0].Status);
            System.assertEquals('Normal', taskList[0].Priority);
        }
    }

    @isTest
    static void partnerAccountTest(){
        Account acc2 = new Account();
        acc2.Name = 'Flavio Branco';
        acc2.AccountNumber = '12345678912111';
        acc2.Type = 'CNPJ';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        acc2.RecordTypeId = recordTypeId;

        Test.startTest();
        insert acc2;
        Test.stopTest();

        List <Opportunity> opportunityList = [SELECT CloseDate, StageName FROM Opportunity WHERE Name = :acc2.name + '- opp Parceiro'];

        if (opportunityList.size() > 0){
            System.assertEquals(System.today().addDays(30), opportunityList[0].CloseDate);
            System.assertEquals('Qualification', opportunityList[0].StageName);
        }
    }

    @isTest
    static void AccountCPFInavlid(){
        Account acc3 = new Account();
        acc3.Name = 'Flavio Branco';
        acc3.AccountNumber = '123456789121';
        acc3.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc3.RecordTypeId = recordTypeId;

        Test.startTest();
        try {
            insert acc3;
        } catch (Exception e) {
            System.debug('CPF invalido');
        }
        
        Test.stopTest();
    }

    @isTest
    static void AccountCNPJInavlid(){
        Account acc4 = new Account();
        acc4.Name = 'Flavio Branco';
        acc4.AccountNumber = '12345678';
        acc4.Type = 'CNPJ';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        acc4.RecordTypeId = recordTypeId;

        Test.startTest();
        try {
            insert acc4;
        } catch (Exception e) {
            System.debug('CNPJ invalido');
        }
        
        Test.stopTest();
    }

    @isTest
    static void beforeUpdateTest(){
    
        Account acc = new Account();
        acc.Name = 'Flavio Branco';
        acc.AccountNumber = '12345678912';
        acc.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc.RecordTypeId = recordTypeId;
        insert acc;

        Test.startTest();
        Account account = [SELECT id FROM Account WHERE AccountNumber = '12345678912'];
        account.AccountNumber =  '12345678913';
        update account;
        Test.stopTest();
        
    }

    @isTest
    static void activeBypassTest(){
        Bypass__c bypass = new Bypass__c();
        bypass.AccountTrigger__c = true;
        insert bypass;

        Account acc = new Account();
        acc.Name = 'Flavio Branco';
        acc.AccountNumber = '12345678912';
        acc.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc.RecordTypeId = recordTypeId;

        Test.startTest();
        insert acc;
        Test.stopTest();
        
    }

}