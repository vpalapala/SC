trigger updateMediaCounter on Media__c (before insert) {

List<Media__c> med = [SELECT Id, Name, Media_Counter__c FROM Media__c ORDER BY CreatedDate DESC Limit 1];
integer i = 1;
for(Media__c m : Trigger.New){

    if(med.size()>0){
       if(med[0].Media_Counter__c == Null){
           m.Media_Counter__c = i;
       }else{
           m.Media_Counter__c = med[0].Media_Counter__c + i;
       }
    }else{
        m.Media_Counter__c = i;
    }
    
    i++;
}

}