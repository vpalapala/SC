/*
Sean Fielding
GearsCRM
6/2/2011

Any Task completed will remove the inactivity flag from the account - regardless of the activity date


*/


trigger TaskInactivityFlag on Task (after insert, after update) {

   Set <Id> Accounts = new Set <Id>();
 
   for(Task t : trigger.new)
      if(t.accountId != null && t.isclosed == true)
         Accounts.add(t.accountId);
    
   List <Account> AccountsToUpdate = new List <Account>(); 
         
   for(Account a : [select id, inactivity_flag__c from Account where id in :Accounts]) {
      if(a.Inactivity_Flag__c == true) {
         a.Inactivity_Flag__c = false;
         AccountsToUpdate.add(a);	
      }
   }
   
   if(AccountsToUpdate.size() > 0)
      update AccountsToUpdate;


}