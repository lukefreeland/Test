trigger AppFeedbackHistory on Application_Feedback__c (After Update) 
{
    if(!test.IsRunningTest()){
        cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
    }
}