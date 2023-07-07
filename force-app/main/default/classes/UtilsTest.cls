@isTest
public class UtilsTest {
    
    @isTest
    static void validaCPFTrueTest(){
        String CPF = '11111111111';
        Utils utils = new Utils();
        Test.startTest();
        utils.validaCPF(CPF);
        Test.stopTest();
    }

    @isTest
    static void validaCPFFalseTest(){
        String CPF = '1111111111';
        Utils utils = new Utils();
        Test.startTest();
        utils.validaCPF(CPF);
        Test.stopTest();
    }

    @isTest
    static void validaCNPJTrueTest(){
        String CNPJ = '11111111111111';
        Utils utils = new Utils();
        Test.startTest();
        utils.validaCNPJ(CNPJ);
        Test.stopTest();
    }

    @isTest
    static void validaCNPJFalseTest(){
        String CNPJ = '111111111111';
        Utils utils = new Utils();
        Test.startTest();
        utils.validaCNPJ(CNPJ);
        Test.stopTest();
    }


}