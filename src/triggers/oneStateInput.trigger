trigger oneStateInput on State_Commission_Input__c (before insert, before update) {
    list<Id> appIds = new list<Id>();
    
    for(State_Commission_Input__c sc : Trigger.new){
    	appIds.add(sc.Application_ID__c);
    }
    User user;
    user = [Select id, Name,State__c from User where ID =: UserInfo.getUserId()];
    list<Application3__c> apps = new list<Application3__c>([Select id, Name, State_and_or_Territories__c from Application3__c where ID IN : appIds]);
    list<State_Commission_Input__c> scInput = new list<State_Commission_Input__c>([Select id, Name,State_Commission_User_State__c from State_Commission_Input__c where Application_ID__c IN : appIds AND State_Commission_User_State__c =: user.State__c]);
    for(State_commission_Input__c scI : Trigger.new){
    	if(scInput.size()==1){
    		scI.addError('You cannot enter more than one state commission input for same Application/Concept Paper');
    	}
    }
    for(Application3__c app : apps){
    	for(State_Commission_Input__c sc : Trigger.new){
    		if(!app.State_and_or_Territories__c.Contains(sc.State_Commission_User_State__c)){
    		 sc.addError('You cannot create a state Commission input that does not belong to a State in the Application Areas effected by project');
    		}
    	}
    }
}