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
        System.assertEquals(acc.Name, 'Flavio Branco');
    }

    @isTest
    static void partnerAccountTest(){
        Account acc2 = new Account();
        acc2.Name = 'Flavio Branco Dois';
        acc2.AccountNumber = '12345678912111';
        acc2.Type = 'CNPJ';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
        acc2.RecordTypeId = recordTypeId;

        Test.startTest();
        insert acc2;
        Test.stopTest();
        System.assertEquals(acc2.Name, 'Flavio Branco Dois');
    }

    @isTest
    static void AccouintCPFInavlid(){
        Account acc3 = new Account();
        acc3.Name = 'Flavio Branco Dois';
        acc3.AccountNumber = '123456789121';
        acc3.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc3.RecordTypeId = recordTypeId;

        Test.startTest();
        insert acc3;
        Test.stopTest();
    }

}