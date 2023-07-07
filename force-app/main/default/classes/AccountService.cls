public with sharing class AccountService {
    public AccountService() {}

    public void checkAccountNumber(List <Account> accountList){

        Utils utils = new Utils();

        try {
            for (Account account : accountList){
                if ((account.Type == 'CNPJ' && !utils.validaCNPJ(account.AccountNumber)) || (account.Type == 'CPF' && !utils.validaCPF(account.AccountNumber))){
                    account.addError('Numero do cliente é invalido');
                }
            }
        } catch (Exception e) {
            System.debug('erro ao processar validação do AccountNumber');
        }

    }
}

