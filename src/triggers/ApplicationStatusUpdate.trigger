trigger ApplicationStatusUpdate on Stages__c (after update){
    list<Id> StageIds = new list<Id>();
    set<id> appids = new  set<id>();
    list<id> panelids = new list<id>();
    list<id> expIds= new list<id>();
    public integer i=0;
    public integer j=0;
    map<Id,Application3__c> AppListUpdate= new map<Id,Application3__c>();
    List<Application3__c> Applicationslist = new List<Application3__c>();
    for(Stages__c s: Trigger.New) {
         StageIds.add(s.Id);
    }
    
    List<Stages__c> Stages =[Select id, Name, Review_Incomplete_Action__c, Review_Complete_Action__c,End_Date__c,Start_Date__c,NCCC_Enforce_Dates_for_Reviews__c,Extension_Date__c from Stages__c where id =:StageIds];
    System.Debug('Stages------' + Stages);
    List<Paneling__c> panel = [select id,Name,Stage_Number__c from Paneling__c where Stage_Number__c IN :StageIds];
    
        for(Paneling__c pan: panel){
            panelids.add(pan.id);
        }
        List<Panel_Application__c> panelapplist = [select id,Application__c,Paneling__c from Panel_Application__c where   Paneling__c IN :panelids];
        List<Expert_Review_Panel__c> exp = [select id,panel__c from Expert_Review_Panel__c where panel__c IN :panelids];
        System.Debug('Panel Application------' + panelapplist);
        System.Debug('Expert Review Panel------' + exp);
        for(Expert_Review_Panel__c E: exp){
            expIds.add(E.id);
        }
        
        List<Application_Feedback__c> appFeedbackList = [Select id,Name,Expert_Review_Panel__c, Application__c,Status__c from Application_Feedback__c where Expert_Review_Panel__c IN :expIds];
         System.Debug('Application Feedback------' + appFeedbackList );
        for(Panel_Application__c pa: panelapplist){
            appids.add(pa.Application__c);
        }
        System.Debug('Application list from panel '+appids);
        Applicationslist = [Select id,Name,Status__c from Application3__c where id IN :appids];
        System.Debug('Applications------' + Applicationslist );
        if(Stages!=null && !Stages.isempty()){
            for(Stages__c s: Stages){
                if(s.End_Date__c == System.Today() && s.NCCC_Enforce_Dates_for_Reviews__c == True){
                    if(Applicationslist!=null && !Applicationslist.isempty()){
                        for(Application3__c app: Applicationslist){
                             if(appFeedbackList!=null && !appFeedbackList.isempty()){
                                System.debug('AF #');
                                for(Application_Feedback__c af: appFeedbackList){
                                    if(af.Application__c == app.id){
                                        if(af.Status__c == 'Not Submitted' || af.Status__c == 'Not Started'){
                                            if(s.Review_Incomplete_Action__c == 'Move to PO Approval/Denial Waitlist'){                                            
                                                 app.Status__c = 'PO Approval/Denial Waitlist';
                                            }
                                            if(s.Review_Incomplete_Action__c == 'Move to Next Review Stage'){                                            
                                                 app.Status__c = 'Submitted';
                                            }
                                            if(s.Review_Incomplete_Action__c == 'Move to SPO Approval/Denial Waitlist'){                                            
                                                 app.Status__c = 'Move to SPO Approval/Denial Waitlist';
                                            } 
                                            if(s.Review_Incomplete_Action__c == 'Deny the Application'){                                            
                                                 app.Status__c = 'Rejected';
                                            }
                                            if(s.Review_Incomplete_Action__c == 'Waitlist the Application'){                                            
                                                 app.Status__c = 'Waitlisted';
                                            }                                                   
                                                 AppListUpdate.put(app.Id,app);                                            
                                                 continue;
                                         }  
                                         else if(af.Status__c == 'Submitted' ){
                                         if(s.Review_Complete_Action__c== 'Move to PO Approval/Denial Waitlist'){                                            
                                                 app.Status__c = 'PO Approval/Denial Waitlist';
                                            }
                                            if(s.Review_Complete_Action__c == 'Move to SPO Approval/Denial Waitlist'){                                            
                                                 app.Status__c = 'Move to SPO Approval/Denial Waitlist';
                                            }
                                            if(s.Review_Complete_Action__c == 'Move to Next Review Stage'){                                            
                                                 app.Status__c = 'Submitted';
                                            } 
                                                AppListUpdate.put(app.Id,app);                                               
                                                break;
                                                System.debug('Application Updated -- ' + AppListUpdate);
                                         }                                         
                                                                                                                        
                                     }
                                         
                                     System.Debug('Application To be Updated ' +AppListUpdate);
                                }
                              }       
                         }  
                     }
                }
                system.debug('AppListUpdate.values = '+AppListUpdate.values());
                if(AppListUpdate.size()>0 && s.Extension_Date__c==Null){
                    update AppListUpdate.values();
                }
                if(AppListUpdate.size()>0 && (s.Extension_Date__c!=Null && s.Extension_Date__c > System.Today())){
                    update AppListUpdate.values();
                }
            }
        } 
        
       /* if(AppListUpdate.size()>0 && Stages.Extension_Date__c==Null){
            update AppListUpdate.values();
        }
        if(AppListUpdate.size()>0 && (Stages.Extension_Date__c!=Null && Stages.Extension_Date__c > System.Today())){
            update AppListUpdate.values();
        }*/

}