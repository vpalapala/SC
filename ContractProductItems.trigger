trigger ContractProductItems on Contract (after insert, after update) {

    map<string, id> mapOppCon = new map<string, id>();
    list<Contract_Product__c> cpsToUpd = new list<Contract_Product__c>();
    
    RecordType conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract'];
    set<id>existCP = new set<id>();

    for(contract c: trigger.new )
    {
        if(c.RecordtypeId != conrect.Id)
        mapOppCon.put(c.opportunity__c, c.id);
    }

    for(Contract_Product__c c : [select product__c from  Contract_Product__c where contract__c in :mapOppCon.values() ])
    {
        existCP.add(c.product__c);
    }


    //grab all the opp line items and copy to the Contract_Product__c object
    for(opportunityLineItem oli : [select id, Total_RMR__c, Term__c, unitPrice, Description, Revenue__c, RMR__c, Pricebookentry.productCode, 
                                          Pricebookentry.product2.Name, ListPrice, TotalPrice, pricebookentry.UnitPrice, quantity, createddate, 
                                          pricebookentry.Product2Id, OpportunityId from opportunityLineItem where Opportunityid in :mapOppCon.keyset()])
    {
        //only create it if it isn't there
    
        Contract_Product__c newContProd = new Contract_Product__c();
        if (existCP.size()==0 || !existCP.contains(oli.pricebookentry.Product2Id))
        {
        
            //create a new Contract_Product__c
        
            newContProd.Contract__c = mapOppCon.get(oli.opportunityId);
            newContProd.Line_Item_Description__c    = oli.Description;
            newContProd.List_Price__c               = oli.ListPrice;
            newContProd.Product__c                  = oli.pricebookentry.Product2Id;
            newContProd.Product_code__c             = oli.pricebookentry.ProductCode;
            newContProd.Quantity__c                 = oli.Quantity;
            newContProd.Revenue__c                  = oli.Revenue__c;
            newContProd.RMR__c                      = oli.RMR__c;
            newContProd.Sales_Price__c              = oli.UnitPrice; //oli.PricebookEntry.UnitPrice;
            newContProd.Term__c                     = oli.Term__c;
            newContProd.Total_Price__c              = oli.TotalPrice;
            newContProd.Total_RMR__c                = oli.Total_RMR__c;
            newcontProd.Opportunity_Line_Item__c    = oli.id;
         
            cpsToUpd.add(newContProd);
    
        }

    }
    if (cpsToUpd.size()>0)
    {
        insert cpsToUpd;
    }
}