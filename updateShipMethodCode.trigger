trigger updateShipMethodCode on Media__c (after insert, before update) {
   
   Map <string, string> ShipMethodMap = new Map <string, string>();
   Map <string, string> ShipMethodCodeMap = new Map <string, string>();
   
   User u = [SELECT Id, Name FROM User WHERE Name =: 'Integration User'];
   
   Set<Id> MediaId = new Set<Id>();
   
   for(Ship_Method_Code__c sm : Ship_Method_Code__c.getall().values())
   {
        ShipMethodMap.put(sm.name , sm.Ship_Method_Code__c);  
        ShipMethodCodeMap.put(sm.Ship_Method_Code__c , sm.name);  
   }
   
   if(Trigger.isInsert){
   
       for(Media__c m : Trigger.new){
           MediaId.add(m.Id);
       }
       
       List<Media__c> mList = [SELECT Id, lastmodifiedbyId, Ship_Method_Code__c, Ship_Method__c FROM Media__c WHERE ID IN: MediaId];
       
       for(Media__c m : mList){
          
          if(m.lastmodifiedbyId != u.Id)
           m.Ship_Method_Code__c = ShipMethodMap.get(m.Ship_Method__c);
           
          if(m.lastmodifiedbyId == u.Id)
           m.Ship_Method__c = ShipMethodCodeMap.get(m.Ship_Method_Code__c);
       }
       
       if(mList.size() > 0)
       update mList;
   }
   
   if(Trigger.isUpdate){
   
      for(Media__c m : Trigger.New){
          
          if(m.lastmodifiedbyId != u.Id)
           m.Ship_Method_Code__c = ShipMethodMap.get(m.Ship_Method__c);
           
          if(m.lastmodifiedbyId == u.Id)
           m.Ship_Method__c = ShipMethodCodeMap.get(m.Ship_Method_Code__c);
       }
      
   }
  
}