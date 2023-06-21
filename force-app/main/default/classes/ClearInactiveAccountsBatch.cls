public class ClearInactiveAccountsBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext context) {
        String query = 'SELECT id, (SELECT id FROM Tasks WHERE CreatedDate >= LAST_90_DAYS ) task, (SELECT id FROM Opportunities WHERE ((StageName =\'Closed Won\' and CloseDate >= LAST_N_DAYS:120) or (StageName = \'Negotiation/Review\'))) opp FROM Account WITH SECURITY_ENFORCED';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext context, List<Account> accountList) {
        List <Account> accountsToUpdateList = new List <Account>();
        for (Account accountAuxiliary : accountList) {
            if (accountAuxiliary.Tasks.size() == 0 || accountAuxiliary.Opportunities.size()== 0){
                accountAuxiliary.Inativa__c = true;
                accountsToUpdateList.add(accountAuxiliary);
            }
        }
        Database.update(accountsToUpdateList);
    }
    
    public void finish(Database.BatchableContext context) {}
}