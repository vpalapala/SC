trigger updateLineItemNumber on OrderItem (after insert) {

  Set<Id> ordId = new Set<Id>();
  List<OrderItem> ordItm = new List<OrderItem>();
  Decimal i = 1;
  
  for(OrderItem oI : Trigger.new){
         ordId.add(oI.OrderId);
  }
  
  List<Order> ordList = [SELECT Id, Name, Status FROM Order WHERE Id IN: ordId];
  List<OrderItem> ordItmList =[SELECT Id, OrderId, Order_Line__c FROM OrderItem WHERE OrderId IN: ordId ORDER BY Order_Line__c DESC];
  
  for(Order o : ordList){
      if(o.Status == 'Submitted' || o.Status == 'Completed' || o.Status == 'Closed'){
          
          for(OrderItem oi : ordItmList){
              if(oi.OrderId == o.Id && oi.Order_Line__c > 0){
                 i = i + 1;
              }
          }
          for(OrderItem oi : ordItmList){    
              if(oi.OrderId == o.Id && oi.Order_Line__c == NULL){
                 oi.Order_Line__c = i;
                 i = i + 1;
              }    
              ordItm.add(oi);
          }    
    
      }else{
      
           for(OrderItem oi : ordItmList){
              if(oi.OrderId == o.Id){
                 oi.Order_Line__c = i;
                 i = i + 1;
              }
              ordItm.add(oi);
          }
                       
      }
      
      i = 1;
  }
  
  if(ordItm.size()>0){
     update ordItm;
  }

}