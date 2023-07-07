@isTest
public class OpportunityServiceTest {

        @TestSetup
        static void makeData(){

            Account acc3 = new Account();
            acc3.Name = 'Flavio Branco';
            acc3.AccountNumber = '23456789121111';
            acc3.Type = 'CNPJ';
            Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Parceiro').getRecordTypeId();
            acc3.RecordTypeId = recordTypeId;
            insert acc3;
            
        }
    
        @isTest
        static void checkToOpportunityTest(){
            List <Account> accountList = [SELECT id, RecordTypeId FROM Account];
            OpportunityService opportunityService = new OpportunityService();
            Test.startTest();
            opportunityService.checkToCreateOpportunity(accountList);
            Test.stopTest();
        }

        @isTest
        static void checkToOpportunityErrorTest(){
            List <Account> accountList = [SELECT id FROM Account];
            OpportunityService opportunityService = new OpportunityService();
            Test.startTest();
            opportunityService.checkToCreateOpportunity(accountList);
            Test.stopTest();
        }
    
        @isTest
        static void createOpportunityTest(){
            List <Account> accountList = [SELECT id, RecordtypeId  FROM Account];
            OpportunityService opportunityService = new OpportunityService();
            Test.startTest();
            Opportunity opportunity = opportunityService.createOpportunity(accountList[0]);
            Test.stopTest();
        }
    
        @isTest
        static void insertOpportunityTest(){
            OpportunityService opportunityService = new OpportunityService();
            List <Opportunity> OpportunityList = new List <Opportunity>();
            Opportunity opp = new Opportunity();
            opp.Name = 'opp';
            opp.StageName = 'Closed';
            opp.CloseDate = System.today();
            opportunityList.add(opp);
            Test.startTest();
            opportunityService.insertOpportunity(opportunityList);
            Test.stopTest();
        }
    }