trigger updateInvoiceRelatedCodes on Contract (before insert, before update) {

   Map <string, string> InvoiceOutputCodesMap = new Map <string, string>();
   Map <string, string> InvoiceFormatCodesMap = new Map <string, string>();
   Map <string, string> InvoiceFileTypeCodesMap = new Map <string, string>();
   Map <string, string> BillingCycleCodesMap = new Map <string, string>();
   Map <string, string> ChangeReasonCodesMap = new Map <string, string>();
   Map <string, string> ChangeReasonTypeCodesMap = new Map <string, string>();
   
   
   for(Invoice_Output_Codes__c ioc : Invoice_Output_Codes__c.getall().values())
   {
        InvoiceOutputCodesMap.put(ioc.name , ioc.Code__c);  
   }
   
   for(Invoice_Format_Codes__c ifc : Invoice_Format_Codes__c.getall().values())
   {
        InvoiceFormatCodesMap.put(ifc.name , ifc.Code__c);  
   }
   
   for(Invoice_File_Type_Codes__c iftc : Invoice_File_Type_Codes__c.getall().values())
   {
        InvoiceFileTypeCodesMap.put(iftc.name , iftc.Code__c);  
   }
   
   for(Billing_Cycle_Code__c bcc : Billing_Cycle_Code__c.getall().values())
   {
        BillingCycleCodesMap.put(bcc.name , bcc.Code__c);  
   }
   
   for(ChangeReasonCode__c iftc : ChangeReasonCode__c.getall().values())
   {
        ChangeReasonCodesMap.put(iftc.name , iftc.Code__c);  
   }
   
   for(ChangeReasonTypeCode__c iftc : ChangeReasonTypeCode__c.getall().values())
   {
        ChangeReasonTypeCodesMap.put(iftc.Description__c , iftc.name);  
   }
   
   //Select Integration User to update description fields only
   User u = [SELECT Id, Name FROM User WHERE Name =: 'Integration User'];
   
   Map <string, string> InvoiceOutputMap = new Map <string, string>();
   Map <string, string> InvoiceFormatMap = new Map <string, string>();
   Map <string, string> InvoiceFileTypeMap = new Map <string, string>();
   Map <string, string> BillingCycleMap = new Map <string, string>();
   Map <string, string> ChangeReasonMap = new Map <string, string>();
   Map <string, string> ChangeReasonTypeMap = new Map <string, string>();
   
   
   for(Invoice_Output_Codes__c ioc : Invoice_Output_Codes__c.getall().values())
   {
        InvoiceOutputMap.put(ioc.Code__c , ioc.name);  
   }
   
   for(Invoice_Format_Codes__c ifc : Invoice_Format_Codes__c.getall().values())
   {
        InvoiceFormatMap.put(ifc.Code__c , ifc.name);  
   }
   
   for(Invoice_File_Type_Codes__c iftc : Invoice_File_Type_Codes__c.getall().values())
   {
        InvoiceFileTypeMap.put(iftc.Code__c , iftc.name);  
   }
   
   for(Billing_Cycle_Code__c bcc : Billing_Cycle_Code__c.getall().values())
   {
        BillingCycleMap.put(bcc.Code__c , bcc.name);  
   }
   
   for(ChangeReasonCode__c iftc : ChangeReasonCode__c.getall().values())
   {
        ChangeReasonMap.put(iftc.Code__c , iftc.name);  
   }
   
   for(ChangeReasonTypeCode__c iftc : ChangeReasonTypeCode__c.getall().values())
   {
        ChangeReasonTypeMap.put(iftc.name , iftc.Description__c);  
   }
   
   for(Contract c : Trigger.New){
       
       if(c.lastmodifiedbyId != u.Id){
           c.Invoice_Format_Code__c = InvoiceFormatCodesMap.get(c.Invoice_Format__c);
           c.Invoice_Output_Code__c = InvoiceOutputCodesMap.get(c.Invoice_Output__c);
           c.Invoice_File_Type_Code__c = InvoiceFileTypeCodesMap.get(c.Invoice_File_Type__c);
           c.Billing_Cycle_Code__c = BillingCycleCodesMap.get(c.Billing_Cycle__c);
           c.Change_Reason_Code__c =  ChangeReasonCodesMap.get(c.change_Reason__c);
           c.Change_Reason_Type_Code__c =  ChangeReasonTypeCodesMap.get(c.change_Reason_Type__c);
           if(c.change_Reason_Type__c == 'Sirius' || c.change_Reason_Type__c == 'Sirius XM')
           c.change_Reason_Type_Code__c = 'SXM';
           if(c.change_Reason_Type__c == 'BANKRUPT' || c.change_Reason_Type__c == 'Bankruptcy')
           c.change_Reason_Type_Code__c = 'BANKRUPT';
       }
       
       if(c.lastmodifiedbyId == u.Id){
           c.Invoice_Format__c = InvoiceFormatMap.get(c.Invoice_Format_Code__c);
           c.Invoice_Output__c = InvoiceOutputMap.get(c.Invoice_Output_Code__c);
           c.Invoice_File_Type__c = InvoiceFileTypeMap.get(c.Invoice_File_Type_Code__c);
           c.Billing_Cycle__c = BillingCycleMap.get(c.Billing_Cycle_Code__c);
           c.Change_Reason__c =  ChangeReasonMap.get(c.change_Reason_Code__c);
           c.Change_Reason_Type__c =  ChangeReasonTypeMap.get(c.change_Reason_Type_Code__c);
       }
   }

}