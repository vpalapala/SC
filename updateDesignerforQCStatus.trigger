trigger updateDesignerforQCStatus on Case (before insert, before update) {

RecordType rt = [SELECT Id, Name FROM RecordType WHERE SobjectType = 'Case' AND Name = 'Systems Design'];
Set<Id> AccId = new Set<Id>();

for(Case c : Trigger.new){
    if(rt.Id == c.RecordTypeId)
    accId.add(c.AccountId); 
}

List<Account> accList = [SELECT Id, Name, Primary_Designer__c, Secondary_Designer__c FROM Account WHERE Id IN: accId];

for(Case c : Trigger.new){
  if((c.QC_Status__c == 'Approved' || c.QC_Status__c == 'Approved as Noted' || c.QC_Status__c == 'Revise and Resubmit')  || (c.Status == 'New' && c.New_Location__c == false)){  
    for(Account acc : accList){
        if(acc.Id == c.AccountId){
           if(acc.Secondary_Designer__c != Null)
           c.OwnerId = acc.Secondary_Designer__c;
           if(acc.Primary_Designer__c != Null)
           c.OwnerId = acc.Primary_Designer__c; 
 
           //acc.Secondary_Designer__c = c.Secondary_Designer__c;
        }
    }
  }  
} 
 
if(trigger.isInsert){
   Set<Id> cId = new Set<Id>();
   for(Case c : Trigger.new){
       if(c.RecordTypeId == rt.Id){
          cId.add(c.parentId);
       }
   }
   List<Case> cList = [SELECT Id, Status FROM Case WHERE ID IN: cId];
   
   for(Case c : cList){
       c.Status = 'Tier 2 - Escalated';
   }
   
   if(cList.size()>0)
   update cList;
} 

}