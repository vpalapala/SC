trigger updateOnHoldSaleOrder on Account (after update) {
   
   Set<Id> accId = new Set<Id>();
   
   for(Account acc : Trigger.New){
       if(acc.Credit_Hold__c == false)
          accId.add(acc.Id);
   }
   
   List<Order> ord = [SELECT Id, Name, Status FROM ORDER WHERE accountId IN: accId AND Status = 'On Hold'];
    
   for(Order o : ord){
      o.Status = 'Submitted';
   }  
    
   if(ord.size()>0)
   update ord; 
}