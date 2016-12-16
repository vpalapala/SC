/* ************************************************************
 * Created By  : Sean Fielding (GearsCRM)
 * Created Date: 4/8/2013
 * Description : Trigger UAccountTrigger
 * 
 * Modified By   :
 * Modified Date : 
 * Description   :
 * 
 * ************************************************************/

trigger UAccountTrigger on Account (before insert, before update) 
{
	List<Account> records = trigger.isDelete ? trigger.old : trigger.new;

	if(trigger.isBefore)
	{
		if(trigger.isInsert)
		{
			UAccount.setAccountType(records, trigger.oldMap);
		}
		else if(trigger.isUpdate)
		{
			UAccount.setAccountType(records, trigger.oldMap);
		}
		//else if(trigger.isDelete)
		//{
		//}
	}     
	/*
	else if(trigger.isAfter)
	{
		if(trigger.isInsert)
		{
		}
		else if(trigger.isUpdate)
		{		
		}
		else if(trigger.isDelete)
		{		   
		}
		else if(trigger.isUndelete)
		{	  
		}
	}
	*/
}