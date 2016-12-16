trigger updatecounteronSubscrptnTemplt on Recurring_Billing__c (before insert, before delete) {
system.debug(UserInfo.getName());

 if(Trigger.isInsert && UserInfo.getName() != 'Integration User'){
     Set<Id> contrId = new Set<Id>();
     Set<Id> contrId1 = new Set<Id>();
     
     for(Recurring_Billing__c rbs : Trigger.New){
         if(rbs.Subscription_Template__c == true){
            contrId.add(rbs.Contract__c);
         }
         if(rbs.Subscription_Template__c == false){
            contrId1.add(rbs.Contract__c);
         }
     }
     
     List<Recurring_Billing__c> rbsList = [SELECT Id, Name, Subscription_Counter__c, Contract__r.Id FROM Recurring_Billing__c WHERE Contract__c IN: contrId AND Subscription_Template__c =: true ORDER BY Subscription_Counter__c DESC];
     List<Recurring_Billing__c> rbsList1 = [SELECT Id, Name, Subscription_Counter__c, Contract__r.Id FROM Recurring_Billing__c WHERE Contract__c IN: contrId1 AND Subscription_Template__c =: false ORDER BY Subscription_Counter__c DESC];  
     integer i = 1;
            for(Recurring_Billing__c rb: Trigger.New){
                
              if(rb.Subscription_Template__c == true){  
                if(rbsList.size() > 0){
                    for(Recurring_Billing__c rbl : rbsList){
                        if(rb.Contract__c == rbl.Contract__c){
                           rb.Subscription_counter__c = string.valueOf(integer.valueof(rbl.Subscription_counter__c) + 1);
                           break;
                        }   
                    }
                }
                else{
                    rb.Subscription_Counter__c = '1';
                }
              }
              
              if(rb.Subscription_Template__c == false){  
                
                    for(Recurring_Billing__c rbl : rbsList1){
                        if(rb.Contract__c == rbl.Contract__c && i == 1){
                           i = integer.valueof(rbl.Subscription_counter__c) + 1;
                        }   
                    }
                
                    rb.Subscription_Counter__c = string.valueof(i);
                    i = i + 1;
                
              }  
            }
   }
   //if the subscription is deleted it has to be counter has to be reordered.  
   if(Trigger.isDelete){
   }       
}