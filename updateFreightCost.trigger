trigger updateFreightCost on OrderItem (after insert, after update) {

Set<Id> ordId = new Set<Id>();
if (!ProcessorControl.inFutureContext) {
    for(OrderItem ordI : Trigger.New){
            ordId.add(ordI.OrderId);
    }
    
    //List<OrderItem> ordItmList = [SELECT Id, Est_Freight_Cost__c FROM OrderItem WHERE Id IN: ordId];
    
    freightService.calculateFreight(ordId);
    
}    
/*for(OrderItem oi : ordItmList){
    oi.Est_Freight_Cost__c = fs.calculateFreight(oi.Id);
}

if(ordItmList.size()>0)
update ordItmList;
*/
}