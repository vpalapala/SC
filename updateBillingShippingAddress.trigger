trigger updateBillingShippingAddress on Account (before insert, before update) {

Set<Id> billToId = new Set<Id>();
List<Account> billToAcc = New List<Account>();

for(Account acc : Trigger.New){
    if(acc.Type == 'Location Customer' || acc.Type == 'SXM Location')
       billToId.add(acc.ParentId);
    else 
       billToId.add(acc.Id);    
}

List<Account> accnt = [SELECT Id, Name, BillingStreet, BillingCity, BillingState, BillingCountry, BillingPostalCode, 
                    ShippingStreet, ShippingCity, ShippingState, ShippingCountry, ShippingPostalCode, Primary_Designer__c, Secondary_Designer__c FROM ACCOUNT WHERE ID IN: billToId];

for(Account acc : Trigger.New){

    if(acc.Type != 'Location Customer' || acc.Type != 'SXM Location'){
       if(acc.BillingStreet == Null || acc.BillingStreet == ''){
          acc.BillingStreet = acc.Corporate_Address__c; 
          if(acc.Corporate_Address_2__c != Null)
          acc.BillingStreet = acc.BillingStreet + ' ' + acc.Corporate_Address_2__c;
       }
       if(acc.BillingCity == Null || acc.BillingCity == '')
       acc.BillingCity = acc.Corporate_City__c;
       if(acc.BillingState == Null || acc.BillingState == '') 
       acc.BillingState = acc.Account_State__c;
       if(acc.BillingCountry == Null || acc.BillingCountry == '') 
       acc.BillingCountry = acc.Corporate_Country__c;
       if(acc.BillingPostalCode == Null || acc.BillingPostalCode == '') 
       acc.BillingPostalCode = acc.Corporate_Zip__c; 
       if(acc.ShippingStreet == Null || acc.ShippingStreet == '')
       acc.ShippingStreet = acc.Corporate_Address__c;
       if(acc.ShippingCity == Null || acc.ShippingCity == '')
       acc.ShippingCity = acc.Corporate_City__c;
       if(acc.ShippingState == Null || acc.ShippingState == '')
       acc.ShippingState = acc.Account_State__c;
       if(acc.ShippingCountry == Null || acc.ShippingCountry == '')
       acc.ShippingCountry = acc.Corporate_Country__c;
       if(acc.ShippingPostalCode == Null || acc.ShippingPostalCode == '')
       acc.ShippingPostalCode = acc.Corporate_Zip__c;  
    }
    
    if(acc.Type == 'Location Customer' || acc.Type == 'SXM Location'){
       if(acc.ShippingStreet == Null || acc.ShippingStreet == ''){
       acc.ShippingStreet = acc.Corporate_Address__c;
       if(acc.Corporate_Address_2__c != Null)
          acc.ShippingStreet = acc.ShippingStreet + ' ' + acc.Corporate_Address_2__c;
       }
       if(acc.ShippingCity == Null || acc.ShippingCity == '')
       acc.ShippingCity = acc.Corporate_City__c;
       if(acc.ShippingState == Null || acc.ShippingState == '')
       acc.ShippingState = acc.Account_State__c;
       if(acc.ShippingCountry == Null || acc.ShippingCountry == '')
       acc.ShippingCountry = acc.Corporate_Country__c;
       if(acc.ShippingPostalCode == Null || acc.ShippingPostalCode == '')
       acc.ShippingPostalCode = acc.Corporate_Zip__c;
       for(account a: accnt){
          if(a.Id == acc.parentId){             
             acc.BillingStreet = a.BillingStreet;             
             acc.BillingCity = a.BillingCity; 
             acc.BillingState = a.BillingState;
             acc.BillingCountry = a.BillingCountry;
             acc.BillingPostalCode = a.BillingPostalCode;
             acc.Primary_Designer__c = a.Primary_Designer__c;
             acc.Secondary_Designer__c = a.Secondary_Designer__c;  
          }
       }
    }

}


}