trigger Third_Party_Update on Third_Party_Info__c (before update) {
    
    List<Third_Party_Info__c> UpdateNotes          = new List<Third_Party_Info__c>();
    List<Third_Party_Info__c> UpdateCheckIndDates  = new List<Third_Party_Info__c>();
    List<Third_Party_Info__c> UpdateCheckOutdDates = new List<Third_Party_Info__c>();
    List<Third_Party_Info__c> UpdateStatus         = new List<Third_Party_Info__c>();
    
    for(Third_Party_Info__c tpInfo : Trigger.new){
        
        Third_Party_Info__c old = Trigger.oldMap.get(tpInfo.Id);
         
        System.debug('>>>>>>>>>>UpdateNotes1 ' +old.CheckInDate__c);
        System.debug('>>>>>>>>>>UpdateNotes2 ' +tpInfo.CheckInDate__c);
           
        if(old.Notes__c!= tpInfo.Notes__c)
        UpdateNotes.add(tpInfo);
        
        if(old.CheckInDate__c != tpInfo.CheckInDate__c)
        UpdateCheckIndDates.add(tpInfo);
        
        if(old.CheckOutDate__c != tpInfo.CheckOutDate__c)
        UpdateCheckOutdDates.add(tpInfo);
        
        if(old.Status__c != tpInfo.Status__c)
        UpdateStatus.add(tpInfo);
              
    }
    
    System.debug('>>>>>>>>>>UpdateNotes ' +UpdateNotes);
    System.debug('>>>>>>>>>>UpdateCheckIndDates  ' +UpdateCheckIndDates);
    System.debug('>>>>>>>>>>UpdateCheckOutdDates ' +UpdateCheckOutdDates);
    System.debug('>>>>>>>>>>Status' +UpdateStatus);
     
    if(UpdateNotes.size()>0){
        ThirdPartyHandler.UpdateAction(UpdateNotes);
    }
    
    if(UpdateCheckIndDates.size()>0){
        ThirdPartyHandler.UpdateCheckInDates(UpdateCheckIndDates);
    }
    
    if(UpdateCheckOutdDates.size()>0){
        ThirdPartyHandler.UpdateCheckOutDates(UpdateCheckOutdDates);
    }
    
    if(UpdateStatus.size()>0){
        ThirdPartyHandler.UpdateStatus(UpdateStatus);
    }
    
    
}