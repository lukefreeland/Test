public class PrimeNofaSelectionForCloneCont {
    
    public Prime_Application__c PrimeApp{get;set;}
    public string ParentPrimeId{get;set;}
    public PrimeNofaSelectionForCloneCont(ApexPages.StandardController controller) {
        PrimeApp = new Prime_Application__c();
        ParentPrimeId=ApexPages.currentPage().getParameters().get('parentId');
    }
    
    public PageReference continueApp(){
        PageReference pg = new PageReference('/apex/ClonePlus?id='+ParentPrimeId+'&childobjecttypes=Application3__c&NofaId='+PrimeApp.NOFO_RFP__c);
        return pg;
    }
    
    public PageReference cancel(){
        PageReference pg = new PageReference('/apex/PrimeApplicationDetail?Id='+ParentPrimeId);
        return pg;
    }
    
    

}