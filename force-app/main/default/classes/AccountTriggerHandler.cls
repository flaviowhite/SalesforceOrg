public class AccountTriggerHandler extends TriggerHandler {
 	
    private Map<Id, Account> oldAccountMap;
    private Map<Id, Account> newAccountMap;
    private List<Account>    oldAccountList;
    private List<Account>    newAccountList;

    public AccountTriggerHandler() {
        this.oldAccountMap  = (Map<Id, Account>) Trigger.oldMap;
        this.newAccountMap  = (Map<Id, Account>) Trigger.newMap;
        this.oldAccountList = (List<Account>)    Trigger.old;
        this.newAccountList = (List<Account>)    Trigger.new;
    }

    public override void beforeInsert(){
        AccountService accountService = new AccountService();
        accountService.checkAccountNumber(newAccountList);

    }

    public override void AfterInsert(){
        OpportunityService opportunityService = new OpportunityService();
        TaskService taskService = new TaskService();
        opportunityService.checkToCreateOpportunity(newAccountList);
        taskService.checkToTask(newAccountList);

    }

    public override void beforeUpdate(){
        AccountService accountService = new AccountService();
        accountService.checkAccountNumber(newAccountList);

    }

}