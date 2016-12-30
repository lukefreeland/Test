public without sharing class AssignedUserHelper {
	
	public static void shareAuditRecords(list<Assigned_User__c> newRecs){
		Profile aduitProfile = [Select Id from Profile where Name = 'Audit'];
		map<Id,Id> userIdtoAuditId = new map<Id,Id>();
		list<Agency_wide_Audit__Share> auditShares = new list<Agency_wide_Audit__Share>();
		for(Assigned_User__c a:newRecs){
			if(a.Agency_wide_audit__c != null && a.Agency_wide_Audit_and_Assigned_Users__c != null){
				userIdtoAuditId.put(a.Agency_wide_Audit_and_Assigned_Users__c,a.Agency_wide_audit__c);
			}
		}
		list<User> users = new list<User>([Select Id,Name,Email from User where Id in :userIdtoAuditId.keyset() and isActive = true and ProfileId != :aduitProfile.Id]);
		if(users.size()>0){
			for(User u: users){
				if(userIdtoAuditId.get(u.Id)!=null && u.Id != userInfo.getUserId()){
					 Agency_wide_Audit__Share  aShare = new Agency_wide_Audit__Share();
	                 aShare.ParentId = userIdtoAuditId.get(u.Id);
	                 aShare.userorgroupId = u.Id;
	                 aShare.AccessLevel = 'Edit';
	                 auditShares.add(aShare);
				}
			}
			if(auditShares.size()>0){
				insert auditShares;
			}
		}
	}
	
}