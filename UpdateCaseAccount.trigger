trigger UpdateCaseAccount on Third_Party_Info__c (After Insert, After update) {
    
    Map<String, String> CaseMap = new Map<String, String>();
    Map<String, String> accMap  = new Map<String, String>();
       
    List<Case>    UpdateCase = new List<Case>();
    
    for(Third_Party_Info__c TP:Trigger.new) {
         if(TP.Location_ID__c!=null && TP.Case__c!=null) 
         CaseMap.put(TP.Case__c,TP.Location_ID__c);
    }
    
    for(Third_Party_System_Setup__c Tps:[SELECT id, Account__c, Location_ID__c FROM Third_Party_System_Setup__c WHERE Location_ID__c in:CaseMap.values()]){
       accMap.put(Tps.Location_ID__c, Tps.Account__c);
    }
    
    for(case cd :[select Id, AccountId from Case where id in:CaseMap.keySet()]){
        cd.AccountId = accMap.get(CaseMap.get(cd.id));
        UpdateCase.add(cd);
    }
    System.debug('>>>>>>>>>>>>>>>>> UpdateCase'+UpdateCase) ;
    if(UpdateCase.size()>0)
    {
        update UpdateCase;
    }
}