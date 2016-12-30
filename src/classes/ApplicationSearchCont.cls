public class ApplicationSearchCont {
	
	public Paneling__c panel{get;set;}
	public String panelId {get;set;}
    public ApplicationSearchCont(ApexPages.StandardController controller) {
    	panelId = Apexpages.currentPage().getParameters().get('id'); 
		panel = new Paneling__c();
		if(panelId!=null && panelId != ''){
			panel = [Select Id,Name, Disaster_Type__c,Focus_Area__c,Organization__c,Organization_Type__c,Project_State__c,	Round__c from Paneling__c
				where Id = :panelId];
		}
				
    }
    
    public ApplicationSearchCont getThis(){
        return this;
    }
    
    public pageReference SaveParameters(){
    	if(panel!=null){
    		update panel;
    		PageReference pg = new PageReference('/'+panelId);
        	return pg;
    	}
    	return null;
    }

}