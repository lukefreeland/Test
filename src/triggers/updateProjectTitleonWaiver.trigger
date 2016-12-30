trigger updateProjectTitleonWaiver on Waiver__c (before insert) {
    
    list<id> ProjectIds = new list<id>();
    
    for(Waiver__c Wv : Trigger.new){
        ProjectIds.add(Wv.Project__c);
    }
    if(ProjectIds != null && !ProjectIds.isEmpty()){
        list<Project__c> pro= new list<Project__c>([Select id, Name, Project_Title__c from Project__c where ID IN : ProjectIds]);
        for(Waiver__c W : Trigger.new){
            for(Project__c pr : pro){
                W.Program__c= pr.Project_Title__c;
                
            }
        }
        
    }
}