trigger Lead_Update_Acct_Parent_Acct on Lead (after update) {
    
    /*
        5/31/11
        Created by JMC, GearsCRM
        
        After conversion, insure that the Lead.Parent_Account_ID is reflected in the related Account.
    
    */
    
    //List<Id> leadsConverted = new List<Id>();
    map<id,id> leadsConverted = new map<id, id>();
    map<id, Account>convertedAccts = new map<id, Account>();
    list<account> convertAccts = new List<account>();
    
    Map <Id,id> AccountMap = new Map <Id,id>();
    
    //cycle through the records and collect the converted Leads
    
    for (Lead l : Trigger.new){
    
        if (l.IsConverted && trigger.oldmap.get(l.id).isConverted == false && l.Parent_Account__c != null){
            AccountMap.put(l.convertedAccountId, l.Parent_Account__c);
        }
    }
    
    list<Account>acctsToUpd = new list<Account>();
    
    for(Account a : [select id, parentID from account where id in :AccountMap.keySet()]) {
       a.parentId = accountMap.get(a.id);
       acctsToUpd.add(a); 
    
    }
    
    if(acctsToUpd.size() > 0)
       update acctsToUpd;
    
    
    
    
    /*
    
    
    convertAccts = [select id, parentID from account where id in :newAccounts];
    //convertedAccts = [select id from acccounts where id in :leadsConverted.keyset()];
    //If the Account.Parent != Lead.Parent_Account__c then update the Account
    
    //list<Lead>convertedAcct = new list<Lead>([select ConvertedAccountId from Lead where id in :leadsConverted.keyset()]);
    list<Account>acctsToUpd = new list<Account>();
    
    for (Lead l2 : [Select l.Parent_Account__c, l.IsConverted, l.ConvertedAccountId From Lead l ]){
        Account a = new Account();
        Lead l3 = new Lead();
        
        if (l2.Parent_Account__c != null){
                //check for a match on Acct Parent
                for (Account a2 : convertAccts){
                    if (l2.ConvertedAccountId == a2.id && l2.Parent_Account__c !=  a2.ParentId){
                    a2.ParentId= l2.Parent_Account__c;
                    acctsToUpd.add(a2);
                }
            }
        } 
    }
    
    if (acctsToUpd.size()>1)
    update acctsToUpd;
    */
}