trigger updateShipViaCodeandTypeCode on Account (before insert, before update) {
   
   if(UserInfo.getName() != 'Integration User'){
       Map <string, string> ShipViaMap = new Map <string, string>();
       Map <string, string> TypeCodeMap = new Map <string, string>();
       Map <string, string> BrandCodeMap = new Map <string, string>();
       Map <string, string> IndustryCodeMap = new Map <string, string>();
       Map <string, string> MarketSegmentCodeMap = new Map <string, string>();      
       Map <string, string> CountryCodeMap = new Map <string, string>();
       Map <string, string> LockDownRegionMap = new Map <string, string>();      
       
       for(Lock_Down_Region__c ldr : Lock_Down_Region__c.getall().values())
       {
            LockDownRegionMap.put(ldr.Country__c , ldr.Region__c);  
       }
       
       for(Ship_Via__c sv : Ship_Via__c.getall().values())
       {
            ShipViaMap.put(sv.name , sv.Ship_Via_Code__c);  
       }
       
       for(Country_Code__c cc : Country_Code__c.getall().values())
       {
            CountryCodeMap.put(cc.Country_Desc__c,cc.name);  
       }
       
       for(AccountTypeCodeSettings__c acctc : AccountTypeCodeSettings__c.getall().values())
       {
            TypeCodeMap.put(acctc.name , acctc.Type_Code__c);  
       }
       
       for(Brands__c brc : Brands__c.getall().values())
       {
            BrandCodeMap.put(brc.BrandName__c, brc.Name);  
       }
       
       for(Industry_Codes__c indc : Industry_Codes__c.getall().values())
       {
            IndustryCodeMap.put(indc.name , indc.Code__c);  
       }
       
       for(Market_Segment_codes__c msc : Market_Segment_codes__c.getall().values())
       {
            MarketSegmentCodeMap.put(msc.name , msc.Code__c);  
       }
       
       for(Account a : Trigger.new){
           a.ERP_Account_Region__c = LockDownRegionMap.get(a.Corporate_Country__c);
           a.Ship_Via_Code__c = ShipViaMap.get(a.Ship_Via__c);
           a.Type_Code__c = TypeCodeMap.get(a.Type);
           a.Strategic_Brand_Code__c = BrandCodeMap.get(a.Strategic_Brand__c);
           a.Industry_Code__c = IndustryCodeMap.get(a.Industry);
           a.Market_Segment_Code__c = MarketSegmentCodeMap.get(a.Market_Segment__c);
           a.Corporate_Country_Code__c = CountryCodeMap.get(a.Corporate_Country__c);
       }
   }
   
   if(UserInfo.getName() == 'Integration User'){
       Map <string, string> BrandMap = new Map <string, string>();
       Map <string, string> IndustryMap = new Map <string, string>();
       Map <string, string> MarketSegmentMap = new Map <string, string>();  
       Map <string, string> CountryCodeMap = new Map <string, string>();    
       
       for(Brands__c brc : Brands__c.getall().values())
       {
            BrandMap.put(brc.Name,brc.BrandName__c);  
       }
       
       for(Industry_Codes__c indc : Industry_Codes__c.getall().values())
       {
            IndustryMap.put(indc.Code__c,indc.name);  
       }
       
       for(Market_Segment_codes__c msc : Market_Segment_codes__c.getall().values())
       {
            MarketSegmentMap.put(msc.Code__c,msc.name);  
       }
       for(Country_Code__c cc : Country_Code__c.getall().values())
       {
            CountryCodeMap.put(cc.Country_Desc__c,cc.name);  
       }
       
       for(Account a : Trigger.new){
           a.Strategic_Brand__c = BrandMap.get(a.Strategic_Brand_Code__c);
           a.Industry = IndustryMap.get(a.Industry_Code__c);
           a.Market_Segment__c = MarketSegmentMap.get(a.Market_Segment_Code__c);
           a.Corporate_Country_Code__c = CountryCodeMap.get(a.Corporate_Country__c);
       }
   }
}