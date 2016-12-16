trigger updateparentContractPROCoverageDetails on PRO_Coverage_Details__c (after insert) {
    
     Set<Id> pcontr = new Set<Id>();
     Set<Id> contr = new Set<Id>();
     list<Contract> loccont = new List<Contract>();
     list<PRO_Coverage_Details__c> proToUpd = new list<PRO_Coverage_Details__c>();
     list<PRO_Coverage_Details__c> ppro = new list<PRO_Coverage_Details__c>();
     list<PRO_Coverage_Details__c> cpro = new list<PRO_Coverage_Details__c>();
     RecordType conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract'];
    
    for(PRO_Coverage_Details__c pcd : trigger.new){
        contr.add(pcd.Contract__c);
    }
    
    loccont = [SELECT id, Bill_To_Contract__c FROM Contract WHERE Id IN: contr AND RecordTypeId =: conrect.Id];
    
    for(Contract c : loccont){
      pcontr.add(c.Bill_To_Contract__c);
    }
    
    ppro = [SELECT Id, Country__c, Pay_PRO__c, PRO_Coverage_Type__c, Product__c, Contract__c FROM PRO_Coverage_Details__c WHERE Contract__c IN: pcontr];
    cpro = [SELECT Id, Country__c, Pay_PRO__c, PRO_Coverage_Type__c, Product__c, Contract__c, Contract__r.Bill_To_Contract__c FROM PRO_Coverage_Details__c WHERE Contract__c IN: contr];
    
    boolean flag;
    
    for(PRO_Coverage_Details__c pcd : cpro){
        flag = true;
      for(Contract c : loccont){
        if(pcd.Contract__c == c.id){   
            for(PRO_Coverage_Details__c ppcd : ppro){
                if(ppcd.Contract__c == pcd.Contract__r.Bill_To_Contract__c && ppcd.Product__c == pcd.Product__c)
                flag = false; 
            }
            
            if(flag){
                    PRO_Coverage_Details__c newPro = new PRO_Coverage_Details__c();
                    newPro.Contract__c = c.Bill_To_Contract__c;
                    newPro.Product__c = pcd.Product__c;
                    newPro.Country__c = pcd.Country__c;
                    newPro.Pay_PRO__c = pcd.Pay_PRO__c;
                    newPro.PRO_Coverage_Type__c = pcd.PRO_Coverage_Type__c;
                
                    proToUpd.add(newPro);
            }
        }   
      }  
    }
    
    if (proToUpd.size()>0)
     {
         insert proToUpd;
     }
}