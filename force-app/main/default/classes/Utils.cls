public with sharing class Utils {
    public Utils() {}
    
    public static Boolean validaCPF(String CPF){
        if (CPF.length() == 11){
            return true;
        }
        return false;
    }

    public static Boolean validaCNPJ(String CNPJ){
        if (CNPJ.length() == 14){
            return true;
        }
        return false;
    }
}