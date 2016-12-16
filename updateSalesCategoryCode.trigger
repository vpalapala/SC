trigger updateSalesCategoryCode on OrderItem (before insert, before update) {
   
   if(Trigger.isInsert){
       for(OrderItem oI : Trigger.new){
            oI.Status__c = 'Draft';
       }
   }
   
   Map <string, string> SaleCategoryMap = new Map <string, string>();
   Map <string, string> WarehouseCodeMap = new Map <string, string>();
   Map <string, string> WarehouseCodeMap1 = new Map <string, string>();
   Set<Id> orderId = new Set<Id>();
   Set<Id> pbeId = new Set<Id>();
   Set<Id> partId = new Set<Id>();
   
   for(Sales_Category__c sc : Sales_Category__c.getall().values())
   {
        SaleCategoryMap.put(sc.name , sc.Sales_Category_Code__c);  
   }
   
   for(WarehouseCode__c wc : WarehouseCode__c.getall().values())
   {
        WarehouseCodeMap.put(wc.name , wc.Code_Id__c);
        WarehouseCodeMap1.put(wc.Code_Id__c , wc.name);  
   }
   
   for(OrderItem oI : Trigger.new){
       orderID.add(oi.OrderId); 
   }
   
   List<Order> ord =  [SELECT Id, Ship_To_Customer__r.Id FROM Order WHERE Id IN: orderId]; 
   
   if(Trigger.isInsert){
       for(OrderItem oI : Trigger.new){
          pbeId.add(oI.PricebookEntryId);
          system.debug(pbeid);
       }
       List<PricebookEntry> pbe  = [Select id, Product2Id FROM PricebookEntry WHERE Id IN: pbeId];
       for(pricebookentry pb : pbe){
           partId.add(pb.product2Id);
       }
       List<Product2> part = [SELECT Id, Warehouse__c, Warehouse_Code__c FROM Product2 WHERE Id IN: partID];
       for(OrderItem oI : Trigger.new){
          if(part.size()>0){
            for(pricebookentry pb : pbe){
              if(oI.PricebookEntryId == pb.Id){ 
                 for(product2 pr : part){
                    if(pb.Product2ID == pr.Id)
                    oI.Warehouse__c = WarehouseCodeMap1.get(pr.Warehouse_Code__c);
                 }
              }    
            } 
          }
       }  
         
   }
   //if(ord.size()>0)
   //update ord;
   
   for(OrderItem oI : Trigger.new){
       oI.Sales_Category__c = SaleCategoryMap.get(oI.Sales_Category_Desc__c);
       oI.Warehouse_Code__c = WarehouseCodeMap.get(oI.Warehouse__c);
       if(Trigger.isInsert){
           for(Order o : ord){
               if(o.Id == oI.OrderId)
               oi.Ship_To__c = o.Ship_To_Customer__r.Id;
           }
       }    
   }
}