trigger SalesOrderLineSetupShipToValue on OrderItem (Before Insert, Before Update) {

//Get the ShipTo Value from Order Header

List<Id> SalesOrderIds = new List<Id>();

for(OrderItem sol:trigger.new){

        SalesOrderIds.add(sol.OrderId );

    }

Map<Id,Order> orderMap = new Map<Id,Order>([select Ship_To_Customer__c from Order where id in:SalesOrderIds ]);

for(OrderItem sol:trigger.new){

    if(!orderMap.IsEmpty()){      
        sol.Ship_To__c = orderMap.get(sol.OrderId ).Ship_To_Customer__c ;
    }

}
}