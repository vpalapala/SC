/*
Atulit Gupta
Salesforce BAT
3/24/2014

Any Task created from Sales User on Leads will update Leads status from Open to Contacted

*/


trigger UpdateLeadStatus on Task (after insert) {

   Set <Id> LeadIds = new Set <Id>();
   List<Profile> profileList = [Select Id,Name from Profile where Name Like '%Sales%'];
   Map<Id,String> profileMap = new Map<Id,String>();
   
   //Create a map of profile with Ids as key and name as pair
   for(Profile p : profileList){
       profileMap.put(p.Id,p.Name);
   }
 
   //Get the leadIDs from the Tasks and check for the logged in user, is a sales user
   for(Task t : trigger.new){
      String task_whoid = t.WhoID;
      System.debug(userinfo.getProfileId());
      system.debug(profileMap.get(userinfo.getProfileId()));
      //if(t.WhoId != null && task_whoid.startsWith(Schema.SObjectType.Lead.getKeyPrefix()) && profileMap.get(userinfo.getProfileId()) != null)
         LeadIds.add(t.WhoId);
   }      
   
   //Query the leads from the set of IDs and update the status to Contacted if the Status of Lead is Open
   system.debug(LeadIds); 
   List <Lead> LeadsToUpdate = new List <Lead>(); 
   if(LeadIds.Size() > 0){      
       for(Lead l : [select id, Status from Lead where id in :LeadIds]) {
          if(l.Status == 'Open') {
             l.Status = 'Contacted';
             LeadsToUpdate.add(l);  
          }
       }
   }   
   try{
       if(LeadsToUpdate.size() > 0)
          update LeadsToUpdate;   }Catch(Exception e){          String errorMessage = e.getMessage();           Integer occurence;            if (e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION')){                occurence = errorMessage.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION,') + 34;                errorMessage = errorMessage.mid(occurence, errorMessage.length());                occurence = errorMessage.lastIndexOf(':');               errorMessage = errorMessage.mid(0, occurence);            }            else {                errorMessage = e.getMessage();            }          trigger.new[0].adderror(errormessage);
   }
}