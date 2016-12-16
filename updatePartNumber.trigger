trigger updatePartNumber on RMA_Line_Item__c (before insert, before update) {

   Set<Id> oliIds = new Set<Id>();
   for(RMA_Line_Item__c rli: Trigger.New){
       oliIds.add(rli.Order_Line_Item__c);
   }
   
   List<OrderItem> op = [SELECT ID, Pricebookentry.Product2Id FROM OrderItem WHERE Id IN: oliIds];
   
   for(RMA_Line_Item__c rli: Trigger.New){
       for(OrderItem oi : op){
          if(oi.Id == rli.Order_Line_Item__c)
          rli.part_Number__c = oi.Pricebookentry.Product2Id;
       }
   }

}