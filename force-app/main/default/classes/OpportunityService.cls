public with sharing class OpportunityService {
    public OpportunityService() {}
    
    public void checkToCreateOpportunity(List <Account> accountList){

        try {

            Map<Id, Schema.RecordTypeInfo> recordTypeMap = Schema.SObjectType.Account.getRecordTypeInfosById();
            OpportunityService opportunityService = new OpportunityService();
            List <Opportunity> opportunityList = new List <Opportunity>();
            Opportunity opportunity = new Opportunity();
            
        
            for (Account account : accountList){
                if (account.RecordTypeId != null && recordTypeMap.get(account.RecordtypeId).Name == 'Parceiro'){
                    Opportunity = opportunityService.createOpportunity(account);
                    if (opportunity != null){
                        opportunityList.add(Opportunity);
                    }
                }
            }
    
            opportunityService.insertOpportunity(opportunityList);
            
        } catch (Exception e) {
            System.debug('erro ao checar oportunidade');
        }

       
        
    }

    public Opportunity createOpportunity(Account account){

        try {

        Opportunity opportunity =  new Opportunity();
        opportunity.Name = account.name + ' - opp Parceiro';
        opportunity.CloseDate = System.today().addDays(30);
        opportunity.StageName = 'Qualification';

        return opportunity;
            
        } catch (Exception e) {
            System.debug('Erro ao criar a oportunidade');
        }
        
        return null;
    }

    public void insertOpportunity(List <Opportunity> opportunityList){
        if (opportunityList.size() > 0){
            Database.insert(opportunityList);
        }
    }

}