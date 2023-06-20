trigger AccountTrigger on Account (before insert, before update , after insert, after update) {
    for (Account acc : Trigger.new){
        if (!Utils.validaCNPJ(acc.AccountNumber) || !Utils.validaCPF(acc.AccountNumber)){
            acc.AccountNumber.addError('Numero do cliente é invalido');
        }
        if(acc.Type == 'Parceiro'){
            createOpp(acc);
        }
        else if (acc.Type == 'Consumidor final'){
            createTask(acc);
        }
    }

    public static void createOpp(Account acc){
        Opportunity opp =  new Opportunity();
        opp.Name = acc.name + ' - opp Parceiro';
        opp.CloseDate = System.today().addDays(30);
        opp.StageName = 'Qualification';
        insert opp;
    }

    public static void createTask(Account acc){
        Task task = new Task();
        task.Subject = 'Comsumidor Final';
        task.WhatId = acc.id;
        task.Status = 'Not Started';
        task.Priority = 'Normal';
        insert task;
    }
}

