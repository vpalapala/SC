trigger updateCodeId on Media_Concepts__c (before insert) {

 Decimal i = 0;
  
  List<Media_Concepts__c> MDCList = [SELECT ID, Name, CodeId__c FROM Media_Concepts__c ORDER BY CodeID__c DESC];
  
  if(MDCList.Size()>0)
  i = MDCList[0].CodeId__c;
  else
  i = 1;
  
  for(Media_Concepts__c mcs : Trigger.New){
      i = i + 1;
      mcs.CodeID__c = i;
      mcs.Code_ID_text__c = string.valueof(i);
  } 
  

}