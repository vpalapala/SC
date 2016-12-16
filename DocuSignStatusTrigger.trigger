trigger DocuSignStatusTrigger on dsfs__DocuSign_Status__c (after insert, after update) {
      
      List <dsfs__DocuSign_Status__c> records = trigger.isDelete ? trigger.old : trigger.new;

      /*if(trigger.isBefore == true)
      {
            if(trigger.isInsert == true)
            {
                  
            }
            else if(trigger.isUpdate == true)
            {
                  
            }
            else if(trigger.isDelete == true)
            {
                  
            }
      }     
      else 
      */
      if(trigger.isAfter == true)
      {
            if(trigger.isInsert == true)
            {
            	UDocuSign.envelopeStatus(records, trigger.oldMap); 	    
            }
            else if(trigger.isUpdate == true)
            {
                UDocuSign.envelopeStatus(records, trigger.oldMap); 	        
            }
            //else if(trigger.isDelete == true)
            //{
             //          
            //}
            //else if(trigger.isUndelete == true)
            //{
            //      
            //}
      }
}