trigger copyBillToContractToLocationContract on Contract (before insert, before update, after insert, after update) {
    
     Set<id> contid = new Set<Id>();
     Set<Id> LocaccId = new Set<Id>();
     
     RecordType conrect = [SELECT Id, Name From RecordType WHERE SobjectType='Contract' AND Name ='Location Contract'];
     
     for(Contract con : Trigger.new){
         LocaccId.add(con.AccountId);
         contId.add(con.Bill_To_Contract__c);
     }
     
     List<Alternate_Bill_To__c> abt = [SELECT Id, Bill_To_Account__c, Location_Account__c FROM Alternate_Bill_To__c WHERE Location_Account__c IN: LocAccId];
     List<Contract> tempc = [SELECT Id, AccountId FROM Contract WHERE ID IN: ContId];
     Boolean flag; 
     
     contId = new Set<Id>();
     
     for(Contract con : Trigger.new){
             
         flag = false;
         
         if(con.RecordTypeId ==  conrect.Id){
              for(Contract c1 : tempc){
                  for(Alternate_Bill_To__c abt1 : abt){
                      if(c1.Id == con.Bill_To_Contract__c && abt1.Location_Account__c == con.AccountId && abt1.Bill_To_Account__c == c1.AccountId)
                      flag = true;
                  }
              }
              if(flag)
              contId.add(con.Bill_To_Contract__c);
              else
              con.adderror('The bill to contract does not have the same Bill to or Alternate Bill to account for the related location account.');
         }
         
     }
    
     
     
     if(trigger.isbefore){    
         List<Contract> contList = [SELECT AccountId,Account_Number__c,ActivatedById,ActivatedDate,Additional_Notes_for_Billing_Dept__c,Ad_Contract_Type__c,
         Allow_Redlining__c,Auto_Billing_Email_Address__c,Auto_Email_RMR_Invoices__c,Auto_Renewal_Mo__c,Auto_Renew__c,BillingCity,
         BillingCountry,BillingLatitude,BillingLongitude,BillingPostalCode,BillingState,BillingStreet,Billing_Contact__c,
         Billing_Cycle__c,Bill_To_Contract__c,Bill_To__c,BMI_Only__c,Bypass_Approvals__c,Chain_Code__c,Change_Reason_Type__c,
         Change_Reason__c,Client_First_Name__c,Client_Last_Name__c,Client_Manager__c,Combine_SC_Detail__c,CompanySignedDate,
         CompanySignedId,Company_Name__c,Contract18DigitID__c,ContractNumber,ContractTerm,Contract_Recipient_Email__c,
         Contract_Type__c,Contract_Value__c,Copywriting_Included__c,Corporate_Address__c,Coterminous__c,Counter__c,
         Co_Terminous__c,CreatedById,CreatedDate,Create_Bill_To__c,Credit_Card__c,CurrencyIsoCode,CustomerSignedDate,
         CustomerSignedId,CustomerSignedTitle,Delivery__c,Description,Description_of_Messages__c,
         Description_of_Special_Conditions__c,Description_of_Video_Program__c,Design_Engineer__c,DS_Template__c,Effective_Date__c,
         Email__c,EndDate,Equipment_Lease_Price__c,Equipment_Purchase_Price__c,Equipment_Type__c,ERP_Account_Type__c,Evergreen__c,
         Expiration_Date__c,Epicor_Contract_Number__c,Expiration_Days__c,Expiration_Month__c,Expiration_Quarter__c,Expiration_Year__c,Fax__c,
         Fixed_Exchange_Rate__c,Fixed_Rate__c,Id,If_Email_Still_Wants_Paper__c,Initial_of_Locations__c,
         Invoices_to_be_billed_to_system__c,Invoice_File_Type__c,Invoice_Format__c,Invoice_Output__c,IsDeleted,LastActivityDate,
         LastApprovedDate,Location_Address__c,
         MC_Series_Player_network_PULL__c,MC_Series_Player_network_PUSH__c,MC_Series_Player_using_disc_updates__c,Messaging__c,
         Monthly_Music_Service_Fee__c,Music_Concept__c,Music_Service_Fee__c,Need_Bill_To_Added__c,Next_Invoice_Date__c,
         Non_Standard_Warranty__c,Notes_for_Contract_Admin__c,Number_of_Messages__c,Opportunity_Name__c,Opportunity_Stage__c,
         Opportunity__r.Id,Oppty_RMR_Contract_Value__c,Oppty_Total_ELO__c,Original_Term_Date__c,OwnerExpirationNotice,OwnerId,
         Payment_Terms__c,Performance_Right_paid_by__c,Person_to_Receive_Contract__c,Phone__c,Project_Manager__c,Quantity__c,
         Reason_Needs_Approval__c,Reason_Terminated__c,RecordTypeId,Renewal_Comments__c,Renewal__c,RMR_Contract_Value_old__c,
         RMR_Contract_Value__c,Sales_Person_1__c,Sales_Person_2__c,Same_as_Corporate_Contract__c,Serenade_SL__c,ShippingCity,
         ShippingCountry,ShippingLatitude,ShippingLongitude,ShippingPostalCode,ShippingState,ShippingStreet,SpecialTerms,StartDate,
         Status,StatusCode,Store_Contact__c,SystemModstamp,Template__c,Terminated_Comments__c,Term__c,Title__c,Total_ELO_on_Contract__c,
         Video__c,VPerformance_Right_paid_by__c FROM Contract WHERE ID IN: contId];
         
         for(Contract cont : Trigger.new){
             for(Contract c : contList){
                  if(cont.Bill_To_Contract__c == c.Id){
                        //cont.AccountId = c.AccountId;
                        cont.Allow_Redlining__c = c.Allow_Redlining__c;
                        cont.BillingCountry = c.BillingCountry;
                        cont.Billing_Cycle__c = c.Billing_Cycle__c;
                        if(cont.Change_Reason__c == Null)
                        cont.Change_Reason__c = c.Change_Reason__c;
                        cont.CompanySignedId = c.CompanySignedId;
                        cont.Contract_Type__c = c.Contract_Type__c;
                        cont.Co_Terminous__c = c.Co_Terminous__c;
                        cont.CustomerSignedId = c.CustomerSignedId;
                        cont.Epicor_Contract_Number__c = c.Epicor_Contract_Number__c;
                        cont.Description_of_Special_Conditions__c = c.Description_of_Special_Conditions__c;
                        cont.Email__c = c.Email__c;
                        cont.Expiration_Date__c = c.Expiration_Date__c;
                        cont.Fixed_Exchange_Rate__c = c.Fixed_Exchange_Rate__c;
                        cont.Invoices_to_be_billed_to_system__c = c.Invoices_to_be_billed_to_system__c;
                        cont.MC_Series_Player_network_PULL__c = c.MC_Series_Player_network_PULL__c;                    
                        cont.Non_Standard_Warranty__c = c.Non_Standard_Warranty__c;
                        cont.Opportunity__c = c.Opportunity__r.Id;
                        cont.Payment_Terms__c = c.Payment_Terms__c;
                        cont.Reason_Needs_Approval__c = c.Reason_Needs_Approval__c;                    
                        cont.ShippingCountry = c.ShippingCountry;
                        //cont.Status = c.Status;
                        cont.Video__c = c.Video__c;
                        cont.Account_Number__c = c.Account_Number__c;
                        cont.Auto_Billing_Email_Address__c = c.Auto_Billing_Email_Address__c;
                        cont.BillingLatitude = c.BillingLatitude;
                        //cont.Bill_To_Contract__c = c.Bill_To_Contract__c;                    
                        cont.Company_Name__c = c.Company_Name__c;
                        cont.Contract_Value__c = c.Contract_Value__c;                    
                        cont.CustomerSignedTitle = c.CustomerSignedTitle;
                        cont.Description_of_Video_Program__c = c.Description_of_Video_Program__c;                    
                        cont.Expiration_Days__c = c.Expiration_Days__c;
                        cont.Fixed_Rate__c = c.Fixed_Rate__c;
                        cont.Invoice_File_Type__c = c.Invoice_File_Type__c;                    
                        cont.MC_Series_Player_network_PUSH__c = c.MC_Series_Player_network_PUSH__c;
                        cont.Music_Concept__c = c.Music_Concept__c;
                        cont.Notes_for_Contract_Admin__c = c.Notes_for_Contract_Admin__c;                    
                        cont.Performance_Right_paid_by__c = c.Performance_Right_paid_by__c;
                        cont.Reason_Terminated__c = c.Reason_Terminated__c;
                        cont.Sales_Person_1__c = c.Sales_Person_1__c;
                        cont.ShippingLatitude = c.ShippingLatitude;                    
                        cont.VPerformance_Right_paid_by__c = c.VPerformance_Right_paid_by__c;
                        //cont.ActivatedById = c.ActivatedById;
                        cont.Auto_Email_RMR_Invoices__c = c.Auto_Email_RMR_Invoices__c;
                        cont.BillingLongitude = c.BillingLongitude;
                        cont.Bill_To__c = c.Bill_To__c;                                        
                        cont.Copywriting_Included__c = c.Copywriting_Included__c;                    
                        cont.Delivery__c = c.Delivery__c;
                        cont.Design_Engineer__c = c.Design_Engineer__c;                                        
                        cont.Id = c.Id;
                        cont.Invoice_Format__c = c.Invoice_Format__c;                    
                        cont.MC_Series_Player_using_disc_updates__c = c.MC_Series_Player_using_disc_updates__c;                    
                        cont.Number_of_Messages__c = c.Number_of_Messages__c;                    
                        cont.Person_to_Receive_Contract__c = c.Person_to_Receive_Contract__c;
                        //cont.RecordTypeId = c.RecordTypeId;
                        cont.Sales_Person_2__c = c.Sales_Person_2__c;
                        cont.ShippingLongitude = c.ShippingLongitude;
                        cont.Store_Contact__c = c.Store_Contact__c;
                        cont.ActivatedDate = c.ActivatedDate;
                        cont.Auto_Renewal_Mo__c = c.Auto_Renewal_Mo__c;
                        cont.BillingPostalCode = c.BillingPostalCode;
                        cont.BMI_Only__c = c.BMI_Only__c;
                        cont.Client_Manager__c = c.Client_Manager__c;
                        cont.Create_Bill_To__c = c.Create_Bill_To__c;
                        cont.Description = c.Description;
                        cont.DS_Template__c = c.DS_Template__c;
                        cont.If_Email_Still_Wants_Paper__c = c.If_Email_Still_Wants_Paper__c;
                        cont.Invoice_Output__c = c.Invoice_Output__c;                    
                        cont.Messaging__c = c.Messaging__c;
                        cont.Need_Bill_To_Added__c = c.Need_Bill_To_Added__c;                    
                        cont.Original_Term_Date__c = c.Original_Term_Date__c;
                        cont.Phone__c = c.Phone__c;
                        cont.Renewal_Comments__c = c.Renewal_Comments__c;
                        cont.Same_as_Corporate_Contract__c = c.Same_as_Corporate_Contract__c;
                        cont.ShippingPostalCode = c.ShippingPostalCode;                    
                        cont.Additional_Notes_for_Billing_Dept__c = c.Additional_Notes_for_Billing_Dept__c;
                        cont.Auto_Renew__c = c.Auto_Renew__c;
                        cont.BillingState = c.BillingState;
                        cont.Bypass_Approvals__c = c.Bypass_Approvals__c;
                        cont.Combine_SC_Detail__c = c.Combine_SC_Detail__c;
                        cont.ContractTerm = c.ContractTerm;
                        cont.Coterminous__c = c.Coterminous__c;
                        cont.Credit_Card__c = c.Credit_Card__c;
                        cont.Description_of_Messages__c = c.Description_of_Messages__c;
                        cont.Effective_Date__c = c.Effective_Date__c;
                        cont.Equipment_Type__c = c.Equipment_Type__c;                    
                        cont.Initial_of_Locations__c = c.Initial_of_Locations__c;
                        //if(cont.Next_Invoice_Date__c == Null)
                        //cont.Next_Invoice_Date__c = c.Next_Invoice_Date__c;                    
                        cont.OwnerExpirationNotice = c.OwnerExpirationNotice;
                        cont.Project_Manager__c = c.Project_Manager__c;
                        cont.Renewal__c = c.Renewal__c;
                        cont.Serenade_SL__c = c.Serenade_SL__c;
                        cont.ShippingState = c.ShippingState;
                        cont.Template__c = c.Template__c;
                        cont.Ad_Contract_Type__c = c.Ad_Contract_Type__c;
                        cont.BillingCity = c.BillingCity;
                        cont.BillingStreet = c.BillingStreet;
                        cont.Chain_Code__c = c.Chain_Code__c;
                        cont.CompanySignedDate = c.CompanySignedDate;
                        cont.Contract_Recipient_Email__c = c.Contract_Recipient_Email__c;
                        //cont.Counter__c = c.Counter__c;
                        cont.CurrencyIsoCode = c.CurrencyIsoCode;                    
                        cont.Fax__c = c.Fax__c;                    
                        cont.Location_Address__c = c.Location_Address__c;
                        cont.OwnerId = c.OwnerId;
                        cont.ShippingCity = c.ShippingCity;
                        cont.ShippingStreet = c.ShippingStreet;
                        cont.Terminated_Comments__c = c.Terminated_Comments__c;
                        cont.Billing_Contact__c = c.Billing_Contact__c;
                        if(cont.Change_Reason_Type__c == Null)
                        cont.Change_Reason_Type__c = c.Change_Reason_Type__c;
                        cont.CustomerSignedDate = c.CustomerSignedDate;
                        cont.Evergreen__c = c.Evergreen__c;
                        if(cont.StartDate == Null)
                        cont.StartDate = c.StartDate;
                        cont.Title__c = c.Title__c;
                        cont.SpecialTerms = c.SpecialTerms;
                        
                  }
             }
         }
     
   }  
     
}