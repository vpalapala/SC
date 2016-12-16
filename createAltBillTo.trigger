trigger createAltBillTo on Account (after insert) {

  List<Alternate_Bill_To__c> labt = new  List<Alternate_Bill_To__c>();
  
  for(Account a : Trigger.new){
     
     if(a.Type == 'Location Customer' && a.LastModifiedBy.Name != 'Integration User'){
      Alternate_Bill_To__c abt = new Alternate_Bill_To__c();
      abt.Location_Account__c = a.Id;
      abt.Bill_To_Account__c = a.parentId;
      abt.Bill_To_Type__c = 'All';
      labt.add(abt);
     } 
  
  }
  
  insert labt;

}