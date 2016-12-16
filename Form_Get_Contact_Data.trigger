trigger Form_Get_Contact_Data on Form__c (before insert, before update) {

 Set <Id> Contacts = new Set <Id>();

   for(Form__c f : trigger.new) {
      if(trigger.isInsert) {
         if(f.Main_Contact__c != null)
            contacts.add(f.Main_Contact__c);
         if(f.Music_Contact__c != null)
            contacts.add(f.Music_Contact__c);
         if(f.Demo_Contact__c != null)
            contacts.add(f.Demo_Contact__c);
         if(f.Video_Contact__c != null)
            contacts.add(f.Video_Contact__c);	
         if(f.IT_Contact__c != null)
            contacts.add(f.IT_Contact__c);	
      }
      
      if(trigger.isUpdate) {
         if(f.Main_Contact__c != null && f.Main_Contact__c != trigger.oldmap.get(f.id).Main_Contact__c)
            contacts.add(f.Main_Contact__c);
         if(f.Music_Contact__c != null && f.Music_Contact__c != trigger.oldmap.get(f.id).Music_Contact__c)
            contacts.add(f.Music_Contact__c);
         if(f.Demo_Contact__c != null && f.Demo_Contact__c != trigger.oldmap.get(f.id).Demo_Contact__c)
            contacts.add(f.Demo_Contact__c);	
         if(f.Video_Contact__c != null && f.Video_Contact__c != trigger.oldmap.get(f.id).Video_Contact__c)
            contacts.add(f.Video_Contact__c);
         if(f.IT_Contact__c != null && f.IT_Contact__c != trigger.oldmap.get(f.id).IT_Contact__c)
            contacts.add(f.IT_Contact__c);
      }
  
   }
     
   Map <id, Contact> ContactMap = new map <id, Contact>();  
     
   for(contact c : [select id, email, title, phone from contact where id in :Contacts]) 
      ContactMap.put(c.id, c); 	
   
      for(Form__c f : trigger.new) {
         if(trigger.isInsert) {
            if(f.Main_Contact__c != null && ContactMap.containsKey(f.Main_Contact__c)) {
               f.Main_Contact_Email__c = ContactMap.get(f.Main_Contact__c).email;
               f.Main_Contact_Phone__c = ContactMap.get(f.Main_Contact__c).phone;
               f.Main_Contact_Title__c = ContactMap.get(f.Main_Contact__c).title;	
            }             
            if(f.Music_Contact__c != null && ContactMap.containsKey(f.Music_Contact__c)) {
               f.Music_Contact_Email__c = ContactMap.get(f.Music_Contact__c).email;
               f.Music_Contact_Phone__c = ContactMap.get(f.Music_Contact__c).phone;
               f.Music_Contact_Title__c = ContactMap.get(f.Music_Contact__c).title;	
            } 
            if(f.Demo_Contact__c != null && ContactMap.containsKey(f.Demo_Contact__c)) {
               f.Demo_Contact_Email__c = ContactMap.get(f.Demo_Contact__c).email;
               f.Demo_Contact_Phone__c = ContactMap.get(f.Demo_Contact__c).phone;
               f.Demo_Contact_Title__c = ContactMap.get(f.Demo_Contact__c).title;	
            } 
            if(f.Video_Contact__c != null && ContactMap.containsKey(f.Video_Contact__c)) {
               f.Video_Contact_Email__c = ContactMap.get(f.Video_Contact__c).email;
               f.Video_Contact_Phone__c = ContactMap.get(f.Video_Contact__c).phone;
               f.Video_Contact_Title__c = ContactMap.get(f.Video_Contact__c).title;	
            } 
            if(f.IT_Contact__c != null && ContactMap.containsKey(f.IT_Contact__c)) {
               f.IT_Contact_Email__c = ContactMap.get(f.IT_Contact__c).email;
               f.IT_Contact_Phone__c = ContactMap.get(f.IT_Contact__c).phone;
               f.IT_Contact_Title__c = ContactMap.get(f.IT_Contact__c).title;	
            } 
         }
      
         if(trigger.isUpdate) {
            if(f.Main_Contact__c != null && f.Main_Contact__c != trigger.oldmap.get(f.id).Main_Contact__c && ContactMap.containsKey(f.Main_Contact__c)) {
               f.Main_Contact_Email__c = ContactMap.get(f.Main_Contact__c).email;
               f.Main_Contact_Phone__c = ContactMap.get(f.Main_Contact__c).phone;
               f.Main_Contact_Title__c = ContactMap.get(f.Main_Contact__c).title;
            }
            if(f.Music_Contact__c != null && f.Music_Contact__c != trigger.oldmap.get(f.id).Music_Contact__c && ContactMap.containsKey(f.Music_Contact__c)) {
               f.Music_Contact_Email__c = ContactMap.get(f.Music_Contact__c).email;
               f.Music_Contact_Phone__c = ContactMap.get(f.Music_Contact__c).phone;
               f.Music_Contact_Title__c = ContactMap.get(f.Music_Contact__c).title;	
            } 
            if(f.Demo_Contact__c != null && f.Demo_Contact__c != trigger.oldmap.get(f.id).Demo_Contact__c && ContactMap.containsKey(f.Demo_Contact__c)) {
               f.Demo_Contact_Email__c = ContactMap.get(f.Demo_Contact__c).email;
               f.Demo_Contact_Phone__c = ContactMap.get(f.Demo_Contact__c).phone;
               f.Demo_Contact_Title__c = ContactMap.get(f.Demo_Contact__c).title;	
            } 
            if(f.Video_Contact__c != null && f.Video_Contact__c != trigger.oldmap.get(f.id).Video_Contact__c && ContactMap.containsKey(f.Video_Contact__c)) {
               f.Video_Contact_Email__c = ContactMap.get(f.Video_Contact__c).email;
               f.Video_Contact_Phone__c = ContactMap.get(f.Video_Contact__c).phone;
               f.Video_Contact_Title__c = ContactMap.get(f.Video_Contact__c).title;	
            } 
            if(f.IT_Contact__c != null && f.IT_Contact__c != trigger.oldmap.get(f.id).IT_Contact__c && ContactMap.containsKey(f.IT_Contact__c)) {
               f.IT_Contact_Email__c = ContactMap.get(f.IT_Contact__c).email;
               f.IT_Contact_Phone__c = ContactMap.get(f.IT_Contact__c).phone;
               f.IT_Contact_Title__c = ContactMap.get(f.IT_Contact__c).title;	
            } 
            
            if(f.Main_Contact__c == null) {
               f.Main_Contact_Email__c = null;
               f.Main_Contact_Phone__c = null;
               f.Main_Contact_Title__c = null;
            }
            if(f.Music_Contact__c == null) {
               f.Music_Contact_Email__c = null;
               f.Music_Contact_Phone__c = null;
               f.Music_Contact_Title__c = null;
            }
            if(f.Demo_Contact__c == null) {
               f.Demo_Contact_Email__c = null;
               f.Demo_Contact_Phone__c = null;
               f.Demo_Contact_Title__c = null;
            }
            if(f.Video_Contact__c == null) {
               f.Video_Contact_Email__c = null;
               f.Video_Contact_Phone__c = null;
               f.Video_Contact_Title__c = null;
            }
            if(f.IT_Contact__c == null) {
               f.IT_Contact_Email__c = null;
               f.IT_Contact_Phone__c = null;
               f.IT_Contact_Title__c = null;
            }
                 
         }
  
     
   }




}