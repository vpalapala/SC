trigger Account_Update_Status_From_Opportunity on Opportunity (after insert, after update) {
    /*
    
    6/5/2011
    Created by JMC, GearsCRM
    
    1. Change Account Status from 'Suspect' to 'Prospect' if there is an Oppty created
    2. Never Move Status from 'Customer' to 'Prospect'
    3. Change to 'Customer' when Oppty is 'Closed Won'
    
    */
    Map<id, id> opMap = new Map<id, id>();
    Map<id, id> opClosedMap = new Map<id,id>();
    list<Account> acctToUpd = new list<Account>();
    
    //create a map of all Opportunities and associate Accounts
    for (opportunity o : trigger.new){
        
        if (o.IsWon && o.IsClosed)
            opClosedMap.put(o.accountID, o.id);
        else{
            opMap.put(o.accountId, o.id );
        }
    }
    
    //collect the Accounts
    
    
        if (trigger.isInsert){
            for (Account opAccounts : [select id, status__c from Account where id in :opMap.keyset()]){
            
        // If the Status = 'Suspect' and not = 'Customer' then changed the status to 'Prospect'
            
                if (opAccounts.Status__c == 'Suspect'){
                    opAccounts.Status__c = 'Prospect';
                
                    acctToUpd.add(opAccounts);
                }
            }
        }
        else {
        //closed won Opps 
            for (Account clsAccounts : [select id, status__c, Type from Account where id in :opClosedMap.keyset()]){
                if (clsAccounts.Status__c != ' Customer - Direct'){
                    clsAccounts.status__c = ' Customer - Direct';
                    if(clsAccounts.Type == 'Bill To')
                    clsAccounts.Type = 'Bill To';
                    if(clsAccounts.Type == 'Bill To Self')
                    clsAccounts.Type = 'Bill To Self';
                    acctToUpd.add(clsAccounts);
                }
            }
        }
        
    if (acctToUpd.size()>0)
        update acctToUpd;
    }