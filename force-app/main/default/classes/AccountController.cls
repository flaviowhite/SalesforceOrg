public with sharing class AccountController {
    
    @AuraEnabled
    public static String accountUpdate(String jsonString){
        try {
            AccountWraper accountData = (AccountWraper) JSON.deserialize(jsonString, AccountWraper.class);
            List <Account> clientAccountList = [SELECT AccountNumber, Type, Name FROM Account WHERE id =: accountData.accountId WITH SECURITY_ENFORCED]; 
            clientAccountList[0].AccountNumber = accountData.accountNumber != null ? accountData.accountNumber : clientAccountList[0].AccountNumber;
            clientAccountList[0].Type = accountData.accountType != null ? accountData.accountType : clientAccountList[0].Type;
            clientAccountList[0].Name = accountData.name != null ? accountData.name : clientAccountList[0].Name;
            update clientAccountList[0];
            return 'Conta atualizada com sucesso';
        } catch (Exception e) {
            return 'Não foi possivel atualizar os seus dados - ' + e.getDmlMessage(0);
        }        
    }
    
}