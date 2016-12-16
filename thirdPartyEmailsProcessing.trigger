trigger thirdPartyEmailsProcessing on EmailMessage (before insert) {

    List<String> emailaddresses = new List<String>();
    List<String> woNum          = new List<String>();
    List<Id> caseId             = new List<Id>();
    String wo                   = '';
    
    String emailCont            =  'agupta';
    String emailCont1            = 'palapala';
    
    //Attach email message from Service Channel to existing WO Case for additional notes.
    for(EmailMessage em : Trigger.new){
      //if(em.FromAddress.contains('@wonote.servicechannel.net'))
        if(em.FromAddress.contains(emailCont) || em.FromAddress.contains(emailCont))
           emailaddresses.add(em.FromAddress);
    }
    
    for(String e : emailaddresses){
        woNum.add(e.substringBefore('@'));
    }
    
    List<Third_Party_Info__c> tpi = [SELECT Id, Case__c, Work_Order_Number__c FROM Third_Party_Info__c WHERE Work_Order_Number__c IN: woNum];
    
    if(tpi.size() > 0){
       for(Third_Party_Info__c ti : tpi){
           for(EmailMessage em : Trigger.new){
               if(ti.Work_Order_Number__c == em.FromAddress.substringBefore('@')){              
                     caseId.add(em.parentId);
                     em.parentId = ti.Case__c;              
               }
           }
       }
     }
     
     List<Case> c = [SELECT id FROM Case WHERE Id IN: caseId];
     if(c.size() > 0)
     delete c;
    
     //Attach email message from Service Channel to existing WO Case for WO updates if WO doesn't exist create a new Service Channel Info record.
    for(EmailMessage em : Trigger.new){
      //if(em.FromAddress.contains('@scalert.com'))
        if(em.FromAddress.contains(emailCont)){
           wo = em.TextBody.substringBetween('WO #: ','PO #:');
           if(wo != ''){
             woNum.add(wo.trim());
             wo = ''; 
           }
        }   
    }
    
    tpi =  new List<Third_Party_Info__c>([SELECT Id, Case__c, Work_Order_Number__c FROM Third_Party_Info__c WHERE Work_Order_Number__c IN: woNum]);
    
    boolean flag; 
    List<Third_Party_Info__c> newTpi = new List<Third_Party_Info__c>();
    
       for(EmailMessage em : Trigger.new){
           flag = true;
           for(Third_Party_Info__c ti : tpi){       
               if(ti.Work_Order_Number__c == em.TextBody.substringBetween('WO #: ','PO #:').trim()){              
                     caseId.add(em.parentId);
                     em.parentId = ti.Case__c;
                     flag = false;              
               }
           }
           
           if(flag)
           {
                  System.debug('>>>>>>>>>>>>>>>>'+ em.TextBody);
                 
                  Third_Party_Info__c tp = new Third_Party_Info__c();
                  
                  tp.Work_Order_Number__c = em.TextBody.substringBetween('WO #: ','PO #:');
                  
                  tp.Category__c = em.TextBody.substringBetween('Category: ','Priority');
                  
                  tp.PO_Number__c = em.TextBody.substringBetween('PO #: ','Trade');
                  
                  tp.Priorities__c = em.TextBody.substringBetween('Priority: ','Tracking');
                  
                  tp.Trades__c = em.TextBody.substringBetween('Trade : ','NTE:');
                  
                  tp.Transaction_Number__c = em.TextBody.substringBetween('Tracking #: ','WO #');           
                  
                  tp.Case__c = em.parentId; 
                  
                  tp.Location_ID__c  = em.TextBody.substringBetween('Location ID:','Notes:');        
                  
                  tp.Tracking_Number__c = em.TextBody.substringBetween('Tracking #:','WO #:');   
                  
                  tp.recordTYpeId = Schema.SObjectType.Third_Party_Info__c.getRecordTypeInfosByName().get('Service Channel').getRecordTypeId();
                  
                  tp.Details__c    =  em.TextBody.substringBetween('Description1:','Description2:'); 
                  
                  newTpi.add(tp);
                  
           }
           else{
                  c = new List<Case>([SELECT id FROM Case WHERE Id IN: caseId]);
                  if(c.size() > 0)
                  delete c;
           }
       }
     if(newTpi.size() > 0){
        insert newTpi;
     }
     
}