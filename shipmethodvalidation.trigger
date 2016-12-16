trigger shipmethodvalidation on Media__c (after insert, before update) {

Set<Id> MediaId = new Set<Id>();
User u = [SELECT Id, Name FROM User WHERE Name =: 'Integration User'];
   
       for(Media__c m : Trigger.new){
           MediaId.add(m.Id);
       }
       
       List<Media__c> mList = [SELECT Id, lastmodifiedbyId, Ship_Method_Code__c, Ship_Method__c, Account__r.Type FROM Media__c WHERE ID IN: MediaId];
       
       for(Media__c med : Trigger.new){
           for(Media__c m : mList){
              
              if(m.lastmodifiedbyId != u.Id && med.Ship_Method__c == Null && med.Id == m.id && m.Account__r.Type == 'Location Customer')
               med.adderror('Ship Method is required for Location.');
               
           }             
       }     
   
}