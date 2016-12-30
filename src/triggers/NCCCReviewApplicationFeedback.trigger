trigger NCCCReviewApplicationFeedback on Stages__c (before update,after update) {
    if(trigger.isAfter && trigger.isUpdate){
        list<Id> StageIds = new list<Id>();
        list<Id> NofoGroupIDs = new list<Id>();
        list<Id> NofoIds = new list<Id>();
        
        list<Stages__c> StageUpdate = new list<Stages__c>();
        Id NOFAID = Schema.SObjectType.NOFA__c.getRecordTypeInfosByName().get('RFP').getRecordTypeId();
        for(Stages__c s: Trigger.New) {
             StageIds.add(s.Id);
        }
        
         list<Stages__c> StageList = new list<Stages__c>([Select Id, Name, Review_Started__c,NOFA_Group__c,Status__c,Start_Date__c,NCCC_Enforce_Dates_for_Reviews__c,(select id,name from Panel__r) from Stages__c where ID IN:StageIds]);
         if(StageList !=null && !StageList.isEmpty()){
            for(Stages__c stageNum : StageList){
                NofoGroupIDs.add(stageNum.NOFA_Group__c);
            }
         }
         
         list<NOFA_Group__c> NOFOGroup = new list<NOFA_Group__c>([Select Id,Name,(select id,name from NOFA_Member__r)from NOFA_Group__c where ID IN:NofoGroupIDs]);
         set<Id> panelIds = new set<Id>();
         if(NOFOGroup!=null && !NOFOGroup.isEmpty()){
            //for(NOFA_Group__c nofGrp : NOFOGroup){
                //for(NOFA_Member__c NofaInf : nofGrp.NOFA_Member__r){
                   // if(nofGrp.NOFA_Member__r !=null && !nofGrp.NOFA_Member__r.isEmpty()){
                        for(Stages__c stage :StageList){
                            if(stage.Start_Date__c == System.Today()  && stage.NCCC_Enforce_Dates_for_Reviews__c==True){
                                for(Paneling__c panel :stage.Panel__r){
                                    if(stage.Start_Date__c == System.Today() && stage.NCCC_Enforce_Dates_for_Reviews__c){
                                        panelIds.add(panel.Id);
                                        /*ApexPages.StandardController controller = new ApexPages.StandardController(panel);
                                        CreatePanelAssignments1 cls = new CreatePanelAssignments1(controller);
                                        cls.AssignPanels();*/
                                }
                            }
                       // }
                    //  }
                  //  } 
                }
             }
         }
         if(panelIds.size()>0){
             AssignPanels.panelAssignments(panelIds);
         }
     }
     
     
     //Move to next stage trigger
     if(trigger.isBefore && trigger.isUpdate){
         
         set<Id> cstageIds = new set<Id>();
         set<Id> snofaGrpIds = new set<Id>();
         set<Id> campusIds = new set<Id>();
         map<Id,Stages__c> stageMap = new map<Id,Stages__c>();
         for(Stages__c s: trigger.new){
            if(s.Review_Complete_Action__c != null && s.Review_Incomplete_Action__c != null){
                cstageIds.add(s.Id);
                snofaGrpIds.add(s.NOFA_Group__c);
                campusIds.add(s.Campus__c);     
                stageMap.put(s.Id,s);       
            }
         }
         if(cstageIds.size()>0){
            list<Stages__c> previousStages = new list<Stages__c>([Select Id,Name,NOFA_Group__c,NCCC_Enforce_Dates_for_Reviews__c,Start_Date__c,Stage_Sequence__c,(select id,name from Panel__r) from Stages__c where NOFA_Group__c in :snofaGrpIds and Campus__c in :campusIds]);
            list<Application_Feedback__c> appFeedBacks = new list<Application_Feedback__c>([Select Id,Name,Status__c,Application__c,Expert_Review_Panel__r.Panel__r.Stage_Number__c from Application_Feedback__c
                                                                                            where Expert_Review_Panel__r.Panel__r.Stage_Number__c in :previousStages]);
            map<Id,Stages__c> previousStagesMap = new map<Id,Stages__c>();
            for(Stages__c s:previousStages){
                previousStagesMap.put(s.Id,s);
            }
            set<Id> appIds = new set<Id>();
            if(appFeedBacks.size()>0){
                for(Application_Feedback__c apFB: appFeedBacks){
                    appIds.add(apFB.Application__c);
                }
            }
            list<Application3__c> apps = new list<Application3__c>([Select Id,Status__c from Application3__c where Id in :appIds and Status__c = 'Submitted']);
            list<Panel_Application__c> panelApps = new list<Panel_Application__c>();
            for(Stages__c ps: previousStages){
                for(Stages__c cs: stageMap.values()){
                    if(ps.Id != cs.Id && cs.Start_Date__c == date.today() && cs.Stage_Sequence__c > ps.Stage_Sequence__c && cs.NCCC_Enforce_Dates_for_Reviews__c){
                        if(previousStagesMap.get(cs.Id).Panel__r.size()>0){ 
                            for(Paneling__c p: previousStagesMap.get(cs.Id).Panel__r){
                                for(Application3__c a:apps){
                                    Panel_Application__c pa = new Panel_Application__c();
                                    pa.Application__c = a.Id;
                                    pa.Paneling__c = p.Id;
                                    panelApps.add(pa);
                                }
                            }
                        }
                    }
                }
            }
            if(panelApps.size()>0){
                insert panelApps;
            }
                                                                                            
         }
     
     }
    
}