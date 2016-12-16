trigger updateCounterOnBillToContracts on Contract (before insert) {

   if(Trigger.isInsert && UserInfo.getName() != 'Integration User'){     
        Set<Id> accId = new Set<Id>();
        RecordType conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract']; 
        for(Contract c :  Trigger.New){
            if(c.RecordTypeId ==  conrect.Id) {
                accId.add(c.AccountId);
            }    
        }

        List<contract> con = [SELECT Id, Name, Counter__c, AccountId FROM Contract WHERE accountID IN: accID ORDER BY Counter__c Desc]; 
        
        for(Contract c: Trigger.New){
            
            if(con.size() > 0){
                for(Contract co : con){
                    if(c.AccountId == co.AccountId){
                       if(co.Counter__c == null || co.Counter__c == '')
                       co.Counter__c = '1'; 
                       c.counter__c = string.valueOf(integer.valueof(co.Counter__c) + 1);
                       break;
                    }   
                }
            }
            else{
                c.Counter__c = '1';
            }
        }
   }
}