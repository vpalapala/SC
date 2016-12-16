trigger updateClientMandSalesPandEContractonAccount on Contract (after insert, after update) {

 if(runOnceTriggerControl.runOnceTriggerControl){   
   Set<Id> accIds = new Set<id>();
   List<Account> acc = new List<Account>();
   List<Account> accupd = new List<Account>();
   
   for(Contract c : Trigger.New){
       accIDs.add(c.AccountId);
   }
   
   acc = [SELECT id, name, SAM__c, Sales_Person__c, EPICOR_Contract_Number__c FROM Account WHERE Id IN: accIds];
   
   for(Contract c : Trigger.New){
       for(Account ac : acc){
         if(ac.Id == c.AccountId && (ac.SAM__c != c.Client_Manager__c || ac.Sales_Person__c != c.Sales_Person_1__c)){
             ac.SAM__c = c.Client_Manager__c;
             ac.Sales_Person__c = c.Sales_Person_1__c;                
         }
         if(c.Status == 'Recurring Billing (P)' || c.Status == 'Recurring Billing (A)'){
             ac.EPICOR_Contract_Number__c  = c.EPICOR_Contract_Number__c ;             
         }
         accupd.add(ac);
       }  
   }
    
   if(accupd.size() > 0){
       update accupd;
   }
   runOnceTriggerControl.runOnceTriggerControl = false;
  } 
}