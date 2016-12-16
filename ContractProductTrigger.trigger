trigger ContractProductTrigger on Contract_Product__c (after insert , after update, before insert, before update) {
      
      List<Contract_Product__c> records = Trigger.isDelete ? Trigger.old : Trigger.new;

      if(Trigger.isBefore == true)
      {
            if(Trigger.isInsert == true)
            {
            	ULockedContract.checkLocked(records, trigger.oldMap);       
            }
            else if(trigger.isUpdate == true)
            {
            	ULockedContract.checkLocked(records, trigger.oldMap);        
            }
            /*else if(trigger.isDelete == true)
            {
                  
            }*/
      }   
      else if(Trigger.isAfter == true)
      {
            if(Trigger.isInsert == true)
            {
            	UContractProduct.byPassApproval(Trigger.newMap, Trigger.oldMap);  
            }
            else if(trigger.isUpdate == true)
            {
             	UContractProduct.byPassApproval(Trigger.newMap, Trigger.oldMap);   
            }
            /*else if(trigger.isDelete == true)
            {
                       
            }
            else if(trigger.isUndelete == true)
            {
                  
            }*/
      }
}