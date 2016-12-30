global class batchsample implements Database.Batchable<sObject>
{
    public String query;

    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
     
    global void execute(Database.BatchableContext BC,List<Award_Reporting__c> scope){
    
        list<Award_Reporting__c> aws= new list<Award_Reporting__c>();
        for(Sobject s : scope)
        {
          Award_Reporting__c a = (Award_Reporting__c)s;
          aws.add(a);
        }
        AwardReportingHelper.shareAwardReports(aws);
    }
     
    global void finish(Database.BatchableContext BC)
    {
                 
    }
}