trigger FindingNumberUniqueInSubFindings on Sub_Findings__c (Before insert,Before update) {

  For(Sub_Findings__c item:trigger.new){
    if(item.Findings__c!=null)
    {
    item.Unique_Audit_Number__c= item.Findings__c;
    }
   }
 }