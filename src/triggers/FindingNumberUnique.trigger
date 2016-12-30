trigger FindingNumberUnique on Findings__c (Before insert,Before update) {

  For(findings__c item:trigger.new){
    if(item.Agency_Wide_Audit__c!=null)
    {
    item.Unique_Audit_Number__c= item.Agency_Wide_Audit__c;
    }
   }

}