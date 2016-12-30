public class ReviewerRedirectionController {

    public Id caseId;
    public string ReviewerID{get;set;}
    public string userID{get;set;}  
    public Id Cid {get;set;}
    private ApexPages.StandardController ctrl;
    public ReviewerRedirectionController(ApexPages.StandardController controller) {
        Expert_Reviewer_Form__c reviewer = new Expert_Reviewer_Form__c();
        Cid = controller.getId();
        ctrl = controller;
        RedirectPage();
    }
    
    public ReviewerRedirectionController ()
    {

    }
    public PageReference RedirectPage()
    {
    Expert_Reviewer_Form__c Reviewer = [select id,name,recordType.Name from Expert_Reviewer_Form__c  where id=:Cid];  
    PageReference PgRef ;  
    if(Reviewer.recordType.Name=='Training Questions'){
        PgRef = new PageReference('/apex/FeedbackScore?id='+Cid);
    }
    else{
        pgref = new pageReference('/apex/VettingQuestionsForm    V?id='+Cid);
    
    }
     return PgRef;
    }

}