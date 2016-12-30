trigger AwardHistory on Award__c (After Update) 
{
    if(!test.IsRunningTest()){
        cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
    }
}