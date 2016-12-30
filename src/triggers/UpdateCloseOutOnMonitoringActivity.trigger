trigger UpdateCloseOutOnMonitoringActivity on Monitoring_Activity__c (before insert) {
    
    list<Id> MonPlanIds = new list<Id>();
    list<Id> GrantMonIds = new list<Id>();
    list<Id> AwardIds = new list<Id>();
    list<Id> masterAwardIds = new list<Id>();
    for(Monitoring_Activity__c ma : Trigger.new){
    	MonPlanIds.add(ma.Monitoring_Plan__c);
    }
    list<Monitoring_Plan__c> maPlan = new list<Monitoring_Plan__c>([Select Id, Name,Grant_Monitoring__c from Monitoring_Plan__c where ID IN : MonPlanIds]);
    for(Monitoring_Plan__c mp : maPlan){
    	GrantMonIds.add(mp.Grant_Monitoring__c);
    }
    list<Grant_Monitoring__c> grMon = new list<Grant_Monitoring__c>([Select Id, Name, Grant__c from Grant_Monitoring__c where ID IN : GrantMonIds]);
    for(Grant_Monitoring__c gm : grMon ){
    	AwardIds.add(gm.Grant__c);
    }
    list<Award__c> AwardList = new list<Award__c>([Select Id, Name,Master_Award__c from Award__c where ID IN : AwardIds]);
    for(Award__c aw : AwardList){
    	masterAwardIds.add(aw.Master_Award__c);
    }
    list<Master_Award__c> masterAward = new list<Master_Award__c>([Select Id, Name , (Select Id, Name from Grants_Close_Out__r) from Master_Award__c where ID IN : masterAwardIds]);
    for(Monitoring_Activity__c mAct : Trigger.new){
    	for(Monitoring_Plan__c mPlan : maPlan){
    		for(Grant_Monitoring__c gMon : grMon){
    			for(Award__c awar : AwardList){
    				for(Master_Award__c mAward : masterAward){
    					if(masterAward != null && !masterAward.isEmpty()){
    						mAct.Master_Award_Name__c = mAward.Id;
    					}
    					for(Grant_Close_Out__c gCloseOut : mAward.Grants_Close_Out__r){
    						if(mAward.Grants_Close_Out__r != null && !mAward.Grants_Close_Out__r.isEmpty()){
    						mAct.Grant_Close_Out__c = gCloseOut.Id;
    						}
    					}
    				}
    			}
    		}
    	}
    }
}