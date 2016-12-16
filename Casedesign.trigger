trigger Casedesign on Design_Request_PM__c (after update) {

List<Case> designCase = new List<Case>();
Set<Id> sdrId = New Set<Id>();
RecordType rt = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name ='Design'];
Group q = [select Id from Group where Name = 'Designer Queue' and Type = 'Queue'];

for(Design_Request_PM__c sdr : Trigger.New){
    sdrId.add(sdr.Id); 
}

List<Case> caseSDR = [SELECT Id,Systems_Design_Request__r.Id FROM Case WHERE Systems_Design_Request__c IN: sdrId AND Subject =:'New System Design Request Submitted']; 
boolean flag = true;
 for(Design_Request_PM__c sdr : Trigger.New){
      flag = false;
      for(Case csdr : caseSDR){
         if(csdr.Systems_Design_Request__r.Id  == sdr.Id)
         flag = true;
      }      
           if(sdr.Submitted_to_Design__c == true && flag == false){
           case c = new case();
           c.RecordTypeId = rt.Id;
           c.Systems_Design_Request__c = sdr.Id;
           c.AccountId = sdr.Account__c;
           c.Status = 'New/Un-assigned';
           c.Subject = 'New System Design Request Submitted';
           c.OwnerId = q.Id;
           designCase.add(c);
           }
              
 }      
 if(designCase.size()>0)
 insert designcase;
}