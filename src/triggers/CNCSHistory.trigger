trigger CNCSHistory on CNCS_Corporate_Program__c(After Update) 
{
    if(!test.IsRunningTest()){
        cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
    }
}