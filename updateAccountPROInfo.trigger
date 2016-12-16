trigger updateAccountPROInfo on PRO_Coverage_Details__c (after insert, after update) {
    
    Set<Id> contractIds = new Set<Id>();
    Set<Id> acctIds = new Set<Id>();
    List<Contract> conList = new List<Contract>();
    List<Account> accList = new List<Account>();
    
    for(PRO_Coverage_Details__c pcd :Trigger.new){
        contractIds.add(pcd.Contract__c);
    }
    
    conList = [SELECT Id, Name, AccountID FROM Contract WHERE Id IN: contractIds];
    
    for(Contract c : conList){
       acctIds.add(c.AccountId);
    }
    
    accLIst = [SELECT id, name, Corporate_Country__c, Pay_PRO__c, PRO_Category__c FROM Account WHERE Id IN: acctIds AND Type = 'Location Customer']; 
    
    for(account acc : accList){
        for(Contract c : conList){
          if(acc.Id == c.AccountId){ 
            for(PRO_Coverage_Details__c pcd :Trigger.new){
                if(pcd.Country__c == acc.Corporate_Country__c && c.Id == pcd.Contract__c){
                   acc.Pay_PRO__c = pcd.Pay_PRO__c;
                   acc.PRO_Category__c = pcd.PRO_Coverage_Type__c; 
                }
            }
          }  
        }
    }
    
    if(accList.size()>0)
    update accList;
    
    accLIst = [SELECT id, name, Corporate_Country__c, Pay_PRO__c, PRO_Category__c FROM Account WHERE Id IN: acctIds AND (Type = 'Bill To' OR Type = 'Bill To Self')];
    List<PRO_Coverage_Details__c> PROList = [SELECT id, name, Contract__c, Pay_PRO__c, PRO_Coverage_Type__c, Country__c FROM PRO_Coverage_Details__c WHERE Contract__c IN: contractIds]; 
    integer PNCount = 0;
    integer CustCount = 0;
    for(account acc : accList){
        for(Contract c : conList){
          if(acc.Id == c.AccountId){ 
            
            for(PRO_Coverage_Details__c pcd :PROList){
                if(pcd.Pay_PRO__c == 'Playnetwork'){
                   PNCount++;
                }
                if(pcd.Pay_PRO__c == 'Customer'){
                   CustCount++;
                }
                if(pcd.Country__c == acc.Corporate_Country__c && c.Id == pcd.Contract__c){
                   acc.PRO_Category__c = pcd.PRO_Coverage_Type__c; 
                }
            }
            
            if(PNCount > 0 && CustCount == 0)
            acc.Pay_PRO__c = 'Playnetwork';
            if(PNCount == 0 && CustCount > 0)
            acc.Pay_PRO__c = 'Customer';
            if(PNCount > 0 && CustCount > 0)
            acc.Pay_PRO__c = 'Hybrid';
          }  
        }
    }
    
    if(accList.size()>0)
    update accList;
    
}