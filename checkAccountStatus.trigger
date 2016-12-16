trigger checkAccountStatus on Order (before insert) {

Set<Id> accId = new Set<Id>();

  if(Trigger.isbefore && Trigger.isInsert){
        for(Order o : Trigger.new){
            accId.add(o.AccountId);
        }
        List<Account> acc = [SELECT Id, Name, Status__c, Credit_Hold__c FROM Account WHERE Id IN: accID];
        
        for(Account a : acc){
           for(Order o : Trigger.new){
              if(o.AccountId == a.Id && a.Status__c == 'Prospect')
              o.AddError('Order cannot be created as ' + a.Name + ' is still a Prospect.');   
           }
        }      
  }

}