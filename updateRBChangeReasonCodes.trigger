trigger updateRBChangeReasonCodes on Recurring_Billing__c (before insert, before update) {

       Map <string, string> ChangeReasonMap = new Map <string, string>();
       Map <string, string> ChangeReasonTypeMap = new Map <string, string>();
       
       for(Subscription_Change_Reason__c scr : Subscription_Change_Reason__c.getall().values())
       {
            ChangeReasonMap.put(scr.Name , scr.Code__c);  
       }
       
       for(Subscription_Change_Reason_Type__c scrt : Subscription_Change_Reason_Type__c.getall().values())
       {
            ChangeReasonTypeMap.put(scrt.Name , scrt.Code__c);  
       }
       
       
       for(Recurring_Billing__c rb : Trigger.new){
           rb.Sub_Change_Reason_Code__c = ChangeReasonMap.get(rb.Sub_Change_Reason__c);
           rb.Sub_Change_Type_Code__c= ChangeReasonTypeMap.get(rb.Sub_Change_Reason_Type__c);
       }

}