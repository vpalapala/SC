trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
      
      List<OpportunityLineItem> records = Trigger.isDelete ? Trigger.old : Trigger.new;

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
            else if(trigger.isDelete == true)
            {
                  
            }
      }     
      else if(Trigger.isAfter == true)
      {
            if(Trigger.isInsert == true)
            {
               UOpportunityLineItem.UpdateContractProducts(records, true, false, false);
               UOpportunityLineItem.setMusicTerm(records, trigger.oldMap);       
            }
            else if(trigger.isUpdate == true)
            {
               UOpportunityLineItem.UpdateContractProducts(records, false, true, false);  
               UOpportunityLineItem.setMusicTerm(records, trigger.oldMap);      
            }
            else if(trigger.isDelete == true)
            {
               system.debug('--------deleteing');
               UOpportunityLineItem.UpdateContractProducts(records, false, false, true);
               UOpportunityLineItem.setMusicTerm(records, trigger.oldMap);              
            }
            else if(trigger.isUndelete == true)
            {
                  
            }
      }
}