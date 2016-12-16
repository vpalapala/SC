trigger ContractTrigger on Contract (after insert, after update, before insert, before update) {
      
      List<Contract> records = Trigger.isDelete ? Trigger.old : Trigger.new;
      List<RecordType> conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND (Name ='Location Contract' OR Name = 'SiriusXM Contract')];
      //List<RecordType> conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract'];
      for(Contract c: Trigger.New){
        //Contract oldcon = Trigger.oldMap.get(c.Id);
        //if(oldcon.RecordtypeId != conrect[0].Id && oldCon.RecordtypeId != conrect[1].Id){ 
        if(c.RecordtypeId != conrect[0].Id && c.RecordtypeId != conrect[1].Id){
              if(Trigger.isBefore == true)
              {
                    if(Trigger.isInsert == true)
                    {
                        ULockedContract.checkLocked(records, trigger.oldMap);    
                        //Ucontract.processEnvelopeStatus(records, trigger.oldMap);          
                    }
                    else if(trigger.isUpdate == true)
                    {
                        ULockedContract.checkLocked(records, trigger.oldMap);    
                        //Ucontract.processEnvelopeStatus(records, trigger.oldMap); 
                        UContractProduct.contractByPassApproval(Trigger.newMap, Trigger.oldMap);       
                    }
                    /*else if(trigger.isDelete == true)
                    {
                           
                    }*/
              }     
              else if(Trigger.isAfter == true)
              {
                    if(Trigger.isInsert == true)
                    {
                        UOpportunity.activiatedContract(records, trigger.oldMap);   
                    }
                    else if(trigger.isUpdate == true)
                    {
                        UOpportunity.activiatedContract(records, trigger.oldMap);                 
                    }
                    /*else if(trigger.isDelete == true)
                    {
                               
                    }
                    else if(trigger.isUndelete == true)
                    {
                          
                    }*/
              }
            }
      }        
}