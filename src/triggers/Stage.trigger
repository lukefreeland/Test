trigger Stage on Stages__c (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        set<Id> stageIds = new set<Id>();
        for(Stages__c s: trigger.new){
            if(s.Consensus_Approach__c != null && trigger.oldMap.get(s.Id).Consensus_Approach__c != trigger.newMap.get(s.Id).Consensus_Approach__c){
                stageIds.add(s.Id);
            }
        }
        if(stageIds.size()>0){
            list<Paneling__c> panels = new list<Paneling__c>([Select Id,recordTypeId,Stage_Number__c from Paneling__c where Stage_Number__c in : stageIds]);
            if(panels.size()>0){
                for(Paneling__c p: panels){
                    if(p.Stage_Number__c!= null){
                         string rt = trigger.newMap.get(p.Stage_Number__c).Consensus_Approach__c;
                         p.RecordTypeId = Schema.SObjectType.Paneling__c.getRecordTypeInfosByName().get(rt).getRecordTypeId();
                    }
                }
                try{
                    update panels;
                }
                catch(Exception e){
                    system.debug('e = '+e);
                }    
            }
        }
    }
    
}