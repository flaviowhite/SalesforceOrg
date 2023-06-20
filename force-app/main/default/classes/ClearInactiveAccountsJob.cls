global class ClearInactiveAccountsJob {
    global void execute(SchedulableContext SC){
        Database.executeBatch(new ClearInactiveAccountsBatch(),500);
    }
}