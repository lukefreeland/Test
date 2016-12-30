trigger AssignedUser on Assigned_User__c (after insert,after update) {

	if(trigger.isAfter){
		if(trigger.isInsert){
			AssignedUserHelper.shareAuditRecords(trigger.new);
		}
	}
	
}