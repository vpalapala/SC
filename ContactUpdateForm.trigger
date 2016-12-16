trigger ContactUpdateForm on Contact (after update) {

   Map <id, Contact> ContactMap = new Map <id, Contact>();

   // if 
   for(Contact c : trigger.new)
      if(c.email != trigger.oldMap.get(c.id).email
         ||c.phone != trigger.oldMap.get(c.id).phone
         ||c.title != trigger.oldMap.get(c.id).title )
            ContactMap.put(c.id, c);

   List <Form__c> FormsToUpdate = new List <Form__c>();

   for(Form__c f : [select id, Main_Contact__c, Main_Contact_Email__c, Main_Contact_Phone__c, Main_Contact_Title__c,
                               Music_Contact__c, Music_Contact_Email__c, Music_Contact_Phone__c, Music_Contact_Title__c,
                               Demo_Contact__c, Demo_Contact_Email__c, Demo_Contact_Phone__c, Demo_Contact_Title__c,
                               Video_Contact__c, Video_Contact_Email__c, Video_Contact_Phone__c, Video_Contact_Title__c,
                               IT_Contact__c, IT_Contact_Email__c, IT_Contact_Phone__c, IT_Contact_Title__c
      from Form__c where ((main_Contact__c in :ContactMap.keySet())
                       OR (music_Contact__c in :ContactMap.keySet())
                       OR (demo_Contact__c in :ContactMap.keySet())
                       OR (video_Contact__c in :ContactMap.keySet())
                       OR (IT_Contact__c in :ContactMap.keySet()))]) {
                       	
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
            
            FormsToUpdate.add(f);
            if(FormsToUpdate.size() == 200) {
               update FormsToUpdate;
               FormsToUpdate.clear();	
            }
                	
   }
   
   if(FormsToUpdate.size() > 0) 
      update FormsToUpdate;
        
}