@isTest
public class AccountServiceTest {

    @TestSetup
    static void makeData(){
        Account acc = new Account();
        acc.Name = 'Flavio Branco';
        acc.AccountNumber = '23456789121';
        acc.Type = 'CPF';
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Consumidor final').getRecordTypeId();
        acc.RecordTypeId = recordTypeId;
        insert acc;
    }

    @isTest
    static void checkAccountNumberTest(){
        List <Account> accountList = [SELECT type, RecordTypeId, AccountNumber FROM  Account];
        AccountService accountService = new AccountService();
        Test.startTest();
        accountService.checkAccountNumber(accountList);
        Test.stopTest();

    }

    @isTest
    static void checkAccountNumberAddErrorTest(){
        List <Account> accountList = [SELECT type, RecordTypeId, AccountNumber FROM  Account];
        accountList[0].AccountNumber = '111111';
        AccountService accountService = new AccountService();
        Test.startTest();
        accountService.checkAccountNumber(accountList);
        Test.stopTest();

    }

    @isTest
    static void checkAccountNumberErrorTest(){
        List <Account> accountList;
        AccountService accountService = new AccountService();
        Test.startTest();
        accountService.checkAccountNumber(accountList);
        Test.stopTest();

    }


}