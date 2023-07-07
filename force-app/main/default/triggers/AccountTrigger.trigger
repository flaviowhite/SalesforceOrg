trigger AccountTrigger on Account (after update, after insert,before insert,before update,before delete,after delete,after undelete) {
    
    Bypass__c bypass = Bypass__c.getInstance(UserInfo.getUserId());
    if(bypass.AccountTrigger__c == true){
        return;
    }

    new AccountTriggerHandler().run();
    
}

