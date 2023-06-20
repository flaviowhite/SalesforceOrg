trigger AccountTrigger on Account (before insert, before update , after insert, after update) {
    List <Opportunity> oppList = new List <Opportunity>();
    List <Task> taskList = new List <Task>();
    Map<Id, RecordType> RecordTypeMap = new Map<Id, RecordType>([SELECT Name ,id FROM RecordType WHERE SobjectType = 'Account']);

    for (Account acc : Trigger.new){
        if (((!Utils.validaCNPJ(acc.AccountNumber)) && acc.Type == 'CNPJ') || ((!Utils.validaCPF(acc.AccountNumber)) && acc.Type == 'CPF')){
            acc.AccountNumber.addError('Numero do cliente é invalido');
        }
        if(RecordTypeMap.get(acc.RecordtypeId).Name == 'Parceiro'){
            oppList.add(createOpp(acc));
        }
        else if (RecordTypeMap.get(acc.RecordtypeId).Name == 'Consumidor final'){
            taskList.add(createTask(acc));
        }
    }
    if (oppList.size() > 0){
        Database.insert(oppList);
    }
    if (taskList.size() > 0){
        Database.insert(taskList);
    }

    public static Opportunity createOpp(Account acc){
        Opportunity opp =  new Opportunity();
        opp.Name = acc.name + ' - opp Parceiro';
        opp.CloseDate = System.today().addDays(30);
        opp.StageName = 'Qualification';
        return opp;
    }

    public static Task createTask(Account acc){
        Task task = new Task();
        task.Subject = 'Comsumidor Final';
        task.WhatId = acc.id;
        task.Status = 'Not Started';
        task.Priority = 'Normal';
        return task;
    }
}

