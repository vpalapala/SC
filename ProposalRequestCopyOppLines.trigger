trigger ProposalRequestCopyOppLines on Proposal_Request__c (after insert) {

   Map<id,id> priMap = new Map<id,id>();

   for(Proposal_Request__c pr : trigger.new)
      if(pr.opportunity__c != null)
         priMap.put(pr.opportunity__c, pr.id);

         
   List <Proposal_Request_Items__c> pris = new List <Proposal_Request_Items__c>();
                 
   if(priMap.size() > 0) {
      for(OpportunityLineItem oli : [select id, Total_RMR__c, TotalPrice, Term__c, unitPrice, 
                                     Revenue__c, RMR__c, Quantity, ListPrice, description,
                                     CurrencyIsoCode, opportunityid, ServiceDate,
                                     PricebookEntry.ProductCode, PricebookEntry.Product2Id
                                     from OpportunityLineItem where opportunityid in :priMap.keySet()]) {
         Proposal_Request_Items__c pri = new Proposal_Request_Items__c();
         pri.Total_RMR__c = oli.Total_RMR__c;
         pri.Total_Price__c = oli.TotalPrice;
         pri.Term__c = oli.Term__c;
         pri.Sales_Price__c = oli.UnitPrice;
         pri.Revenue__c = oli.Revenue__c;
         pri.RMR__c = oli.RMR__c;
         pri.Quantity__c = oli.Quantity;
         pri.Proposal_Request__c = priMap.get(oli.opportunityid);
         pri.Product__c = oli.PricebookEntry.Product2Id;
         pri.Product_Code__c = oli.PricebookEntry.ProductCode;
         //pri.Name,
         pri.List_Price__c = oli.ListPrice;
         pri.Line_Item_Description__c = oli.Description;
         pri.Date__c = oli.ServiceDate;
         pri.CurrencyIsoCode = oli.CurrencyIsoCode;
         
         pris.add(pri);
         
         if(pris.size() == 200) {
            insert pris;
            pris.clear();	
         }
   
      }	
   }
   
   if(pris.size() > 0) 
      insert pris;
       

}