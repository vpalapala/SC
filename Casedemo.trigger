trigger Casedemo on Demo_Form__c (after update) {

List<Case> Demo_Case = new List<Case>();
Set<Id> drId = New Set<Id>();
RecordType rt = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name ='Demo Case'];
Group q = [select Id from Group where Name = 'Sales Support Queue' and Type = 'Queue'];

for(Demo_Form__c dr : Trigger.New){
    drId.add(dr.Id); 
}

List<Case> caseSDR = [SELECT Id, Demo_Request_Form__r.id FROM Case WHERE Demo_Request_Form__c IN: drId AND Subject =:'New Demo Request Submitted']; 
boolean flag = true;
 for(Demo_Form__c dr : Trigger.New){
      flag = false;
      for(Case cdr : caseSDR){
         if(cdr.Demo_Request_Form__r.Id  == dr.Id)
         flag = true;
      }      
           if(dr.Submit_to_Sales_Support__c == true && flag == false){
           case c = new case();
           c.RecordTypeId = rt.Id;
           c.Demo_Request_Form__c= dr.Id;
           c.AccountId = dr.Account__c;
           c.Status = 'New/Un-assigned';
           c.Subject = 'New Demo Request Submitted';
           c.OwnerId = q.Id;
           Demo_Case.add(c);
           }
              
 }      
 if(Demo_Case.size()>0)
 insert Demo_case;
}