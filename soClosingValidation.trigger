trigger soClosingValidation on Order (after update) {

    Set<Id> ordId = new Set<Id>();
    
    for(Order o : Trigger.new){
       ordId.add(o.Id);
   }
   
    if(Trigger.isafter && Trigger.isUpdate){
       List<OrderItem> ordI = [SELECT Id, Status__c, OrderId, Quantity, Shipped_Qty__c, Order.LastModifiedBy.Name FROM OrderItem WHERE OrderId IN: ordId];
       List<OrderItem> ordI1 = new List<OrderItem>();
       for(OrderItem oi : ordI){
          for(Order o : Trigger.new){
             if(o.Id == oi.OrderId && o.Status == 'Closed' && oi.Order.LastModifiedBy.Name != 'Integration User'){
                if(oi.Quantity != oi.Shipped_Qty__c && oi.Status__c != 'void'){
                  o.addError('Shipped Qty does not match with the Order Line Qty for one of the Order Items in Order.');
                }
              }  
          }    
       } 
    }       

}