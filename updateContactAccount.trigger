trigger updateContactAccount on Case (after insert, after update) {

Set<Id> conId = new Set<Id>();
Set<Id> AccId = new Set<Id>();

for(Case c : Trigger.new){
    conId.add(c.ContactId);
    accId.add(c.AccountId); 
}

List<Contact> conList = [SELECT Id, Name, AccountId FROM Contact WHERE Id IN: conId];

for(Case c : Trigger.new){
    for(Contact con : conList){
        if(con.Id == c.ContactId && con.AccountId == Null){
           con.AccountId = c.AccountId;
        }
    }
} 

if(conList.size()>0)
update conList;
}