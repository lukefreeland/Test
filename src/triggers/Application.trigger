trigger Application on Application3__c (before insert, before update,after insert,after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            ApplicationHelper.checkApplicationforSameYr(trigger.new);             
        }
        list<Application3__c> updateApps = new list<Application3__c>();
        if(trigger.isUpdate){
            for(Id i: trigger.newMap.keyset()){
                if(trigger.oldMap.get(i).project__c != trigger.newMap.get(i).project__c){
                    updateApps.add(trigger.newMap.get(i));
                }
            }
            if(updateApps.size()>0)
                ApplicationHelper.checkApplicationforSameYr(updateApps);
        }
    }
    /*if(trigger.isBefore){
        if(trigger.isInsert){
            ApplicationHelper.populateOrg(trigger.new);
        }
    }*/  
    set<Id> orgIds = new set<Id>();   
   
    if(trigger.isbefore){
        if(trigger.isInsert || trigger.isUpdate){           
            
            if(trigger.isUpdate){
                ApplicationHelper.populateBudgetMatchRequired(trigger.new);
            }
        
            for(Application3__c a: trigger.new){
                if(a.Organization__c!=null){
                    orgIds.add(a.Organization__c);
                }
            }
            if(orgIds!=null && orgIds.size()>0){
                map<Id,Account> accMap = new map<Id,Account>([Select Id,Red_Flag_Count__c from Account where id in :orgIds]);         
                for(Application3__c a: trigger.new){
                    if(a.Organization__c!=null && accMap.get(a.Organization__c)!=null){
                        a.Red_Flag_Count__c = accMap.get(a.Organization__c).Red_Flag_Count__c;
                    }
                }
            }
            
        }        
        
    }
    
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            ApplicationHelper.shareApplicationsWithStateComission(trigger.new,trigger.oldMap); 
            list<Id> parentAppIds = new list<Id>();
            list<Award__c> awardUpdate = new list<Award__c>();
            list<Award__c> awardUpdateCheck = new list<Award__c>();
            for(Application3__c app1 : Trigger.new){
                if(app1.Parent_Application__c != null){
                    parentAppIds.add(app1.Parent_Application__c);
                }
            }
            
            if(parentAppIds.size()>0){
                list<Application3__c> apps = new list<Application3__c>([Select Id, Name, (Select id, Name from Award__r) from Application3__c where ID IN : parentAppIds]);
                for(Application3__c apCheck : Trigger.new){                 
                        for(Application3__c app2 : apps){
                            for(Award__c award : app2.Award__r){
                                if(apCheck.Type_of_Application__c == 'Amendment' && (apCheck.Status__c != 'Awarded' || apCheck.Status__c != 'Withdrawn' || apCheck.Status__c != 'Rejected')){
                                    award.Can_I_amend__c = false;
                                    awardUpdate.add(award);
                                }
                                if(apCheck.Type_of_Application__c == 'Amendment' && (apCheck.Status__c == 'Awarded' || apCheck.Status__c == 'Withdrawn' || apCheck.Status__c == 'Rejected')){
                                    award.Can_I_amend__c = true;
                                    awardUpdateCheck.add(award);
                                }
                            }
                        }
                }
                if(awardUpdate.size()>0)
                    update awardUpdate;
                if(awardUpdateCheck.size()>0)
                    update awardUpdateCheck; 
            }
        
         }
         
      
        if(trigger.isInsert){
            ApplicationHelper.shareApplications(trigger.new);
            ApplicationHelper.shareSCIApplications(trigger.new);
        }
    }
    
    if(trigger.isAfter && trigger.isUpdate){
       if(!test.isRunningTest()){
         cprh.TriggerHandler.LogRecordHistory(trigger.oldMap, trigger.newMap);
         set<Id> projIDs = new set<Id>();
         list<Project__c> updateProj = new list<Project__c>();
         map<Id,Application3__c> appMap = new map<Id,Application3__c>();
         for(Application3__c appProjects : Trigger.new){
             if(appProjects.Status__c == 'Submitted'){
                projIDs.add(appProjects.Project__c);
                appMap.put(appProjects.Project__c,appProjects);
            }
         }
         list<Project__c> Projs = new list<Project__c>([Select id,name,Project_Summary__c from Project__c where id IN : projIDs]);
         //for(Application3__c apps : Trigger.new){
            for(Project__c projectRecs : Projs){
               // if(apps.Status__c == 'Submitted'){
                    projectRecs.Project_Summary__c = appMap.get(projectRecs.Id).Executive_Summary__c;
                    updateProj.add(projectRecs);
               // }
            }
         //}
         update updateProj;
       }
    }
    
    if(trigger.isbefore) {
        if(trigger.isInsert){
            list<Id> parentAppIds = new list<Id>();         
            for(Application3__c app : Trigger.new){
                if(app.Type_of_Application__c == 'Continuation'){
                    parentAppIds.add(app.Parent_Application__c);
                }
            }
            list<Application3__c> contParentAppList = new list<Application3__c>([Select id, name, Parent_Award_Project_Years__c,(Select id,Name,Project_Years_Awarded_This_Award__c from Award__r) from Application3__c where Id IN :parentAppIds ]);
            for(Application3__c ap1 : Trigger.new){
                for(Application3__c ap2 : contParentAppList){
                    for(Award__c aw : ap2.Award__r){
                        system.debug('Award Project years......' +aw.Project_Years_Awarded_This_Award__c);
                        ap1.Parent_Award_Project_Years__c = aw.Project_Years_Awarded_This_Award__c;
                        
                    }
                }
            }
        }
    }
    
}