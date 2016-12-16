trigger contractRecipientEmail on Contract (before insert, before update) {
      
      Set<Id> contactIds = new Set<Id>();
      List<RecordType> conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND (Name ='Location Contract' OR Name = 'SiriusXM Contract')];
      
      for(Contract ct : Trigger.New){
            if(ct.Contract_Recipient_Email__c == '' || ct.Contract_Recipient_Email__c == NULL){
                contactIds.add(ct.Person_to_Receive_Contract__c);
            }
      }
      
      Map<Id,Contact> contactEmailMap = new Map<Id,Contact>([SELECT Email FROM Contact WHERE Id IN: contactIds]);
      
      for(Contract ct : Trigger.New){
            if((ct.Contract_Recipient_Email__c == '' || ct.Contract_Recipient_Email__c == NULL) && contactEmailMap.size()>0){
                contact c = contactEmailMap.get(ct.Person_to_Receive_Contract__c);
                ct.Contract_Recipient_Email__c = c.Email;
            }
            if((ct.Contract_Recipient_Email__c == '' || ct.Contract_Recipient_Email__c == NULL) && ct.RecordtypeId != conrect[0].Id && ct.RecordtypeId != conrect[1].Id){
                ct.addError('Contract Recipient Mail cannot be left blank.');  
            }
      }
}