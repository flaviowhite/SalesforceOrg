public with sharing class Utils {
    
    public Boolean validaCPF(String CPF){
        if (CPF.length() == 11){
            return true;
        }
        return false;
    }

    public Boolean validaCNPJ(String CNPJ){
        if (CNPJ.length() == 14){
            return true;
        }
        return false;
    }
}