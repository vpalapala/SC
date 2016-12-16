trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
      
      List<Opportunity> records = Trigger.isDelete ? Trigger.old : Trigger.new;

      if(Trigger.isBefore == true)
      {
            if(Trigger.isInsert == true)
            {
            	//ULockedContract.checkLocked(records, trigger.oldMap);      
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
                //CreateAssetsFromOpportunity.OpportunityInserted(records); 
            }
            else if(trigger.isUpdate == true)
            {
                CreateAssetsFromOpportunity.OpportunityUpdated(records, trigger.oldMap);
            }
            else if(trigger.isDelete == true)
            {
                       
            }
            else if(trigger.isUndelete == true)
            {
                  
            }
      }
}