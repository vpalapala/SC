trigger PROCoverageDetails on Contract (after insert, before update) {

  if(PROProcessorControl.runPROCoverageDetailTriggers){  
    map<string, id> mapOppCon = new map<string, id>();
    List<PRO_Coverage_Details__c> proToUpd = new List<PRO_Coverage_Details__c>();
    Set<Integer> dup = new Set<Integer>();
    List<Integer> dup1 = new List<Integer>();
    
    RecordType conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract'];
    set<id>existCP = new set<id>();

    for(contract c: trigger.new )
    {
        if(c.RecordtypeId != conrect.Id)
        mapOppCon.put(c.opportunity__c, c.id);
    }

    list<PRO_Coverage_Details__c> pro = [select product__c, Contract__c, Country__c, Pay_PRO__c, PRO_Coverage_Type__c from  PRO_Coverage_Details__c where contract__c in :mapOppCon.values()];
    boolean flag;
   
    //grab all the opp line items having Products with PRO Required and copy to the PRO_Coverage_Details__c object
    for(opportunityLineItem oli : [select id, Total_RMR__c, Term__c, unitPrice, Description, Revenue__c, RMR__c, Pricebookentry.productCode, 
                                          Pricebookentry.product2.Name, Pricebookentry.product2.PRO_Type_Required__c, ListPrice, TotalPrice, pricebookentry.UnitPrice, quantity, createddate, 
                                          pricebookentry.Product2Id, OpportunityId, Country__c, Pay_PRO__c, PRO_Coverage_Type__c from opportunityLineItem where Opportunityid in :mapOppCon.keyset() AND Pricebookentry.product2.PRO_Type_Required__c = :true])
    {
        flag = true;
        //only create it if it isn't there
        for(contract c: trigger.new ){
          if(c.Opportunity__c == oli.OpportunityId){  
            for(PRO_Coverage_Details__c pr : pro){ 
                if(pr.Contract__c == c.id && oli.pricebookentry.Product2Id == pr.Product__c && oli.Country__c == pr.Country__c && oli.Pay_PRO__c == pr.Pay_PRO__c && oli.PRO_Coverage_Type__c == pr.PRO_Coverage_Type__c){
                   flag = false;
                   pr.Pay_PRO__c = oli.Pay_PRO__c;
                   pr.PRO_Coverage_Type__c = oli.PRO_Coverage_Type__c;
            
                   proToUpd.add(pr); 
                }
            }
          }  
        }
        if (flag)
        {
        
            PRO_Coverage_Details__c newPro = new PRO_Coverage_Details__c();
            newPro.Contract__c = mapOppCon.get(oli.opportunityId);
            newPro.Product__c = oli.pricebookentry.Product2Id;
            newPro.Country__c = oli.Country__c;
            newPro.Pay_PRO__c = oli.Pay_PRO__c;
            newPro.PRO_Coverage_Type__c = oli.PRO_Coverage_Type__c;
            
            proToUpd.add(newPro);
    
        }

    }
        
    for(integer i = 0; i< protoupd.size(); i++){
        for(integer j = i+1; j< protoupd.size(); j++){
           system.debug(protoupd[i]);
           system.debug(protoupd[j]);
           if(protoupd[j] != null){
              system.debug(protoupd[i].Contract__c == protoupd[j].Contract__c  && protoupd[i].Product__c == protoupd[j].Product__c && protoupd[i].Country__c == protoupd[j].Country__c && protoupd[i].Pay_PRO__c == protoupd[j].Pay_PRO__c && protoupd[i].PRO_Coverage_Type__c == protoupd[j].PRO_Coverage_Type__c);
              if(protoupd[i].Contract__c == protoupd[j].Contract__c  && protoupd[i].Product__c == protoupd[j].Product__c && protoupd[i].Country__c == protoupd[j].Country__c && protoupd[i].Pay_PRO__c == protoupd[j].Pay_PRO__c && protoupd[i].PRO_Coverage_Type__c == protoupd[j].PRO_Coverage_Type__c)
                dup.add(j);
           } 
        }
    }
    
    dup1.addall(dup);
    
    for(integer d=dup.size()-1; d>=0;d--){
        system.debug(dup1.get(d));
        system.debug(protoupd);
        if(protoupd[dup1.get(d)] != null)
        protoupd.remove(dup1.get(d));
    }
     
    if (proToUpd.size()>0)
    {           
        upsert proToUpd;
        PROProcessorControl.runPROCoverageDetailTriggers = false;
    }
  }   
}