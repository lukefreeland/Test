public class AddApplicationToPanelCont {
    private ApexPages.StandardController standardController;
    public AddApplicationToPanelCont(ApexPages.StandardController standardController){
         this.standardController = standardController;  
    }
    
    public PageReference AssignApplication(){   
        list<Application3__c> appList =new list<Application3__c>();
        list<Application3__c> apps =new list<Application3__c>();
        List<Paneling__c> PanelList = new list<Paneling__c>();
        List<Panel_Application__c> PanelApp= new List<Panel_Application__c>();
        Application3__c app = new Application3__c();
        Id recordId = standardController.getId();
        set<Id> nofaIds = new set<Id>();
        set<Id> panelIds= new set<Id>(); 
        set<String> statusofApp = new Set<String>{'Submitted','Submitted to CNCS','Review In Progress'};
        Stages__c Stage = [Select id,Name,Review_Complete_Action__c,Review_Incomplete_Action__c,(Select id,Name,Panel_Name__c from Panel__r),
                           Nofa_Group__r.Id from Stages__c where id =: recordId];
        System.Debug('Stage Name----'+ Stage.Name);
        if(Stage != Null && Stage.Panel__r!=Null){
           for(Paneling__c p: Stage.Panel__r){
                panelIds.add(p.id);   
           }    
        System.Debug('Panel ID-----'+ panelIds );
        }
        if(panelIds.size()>0){
            PanelList = new list<Paneling__c>([select id,Name,Disaster_Type__c,Focus_Area__c,Organization__c,Organization_Type__c,Project_State__c,Round__c
                                               From Paneling__c where id IN: panelIds]);
        }    
        
        System.Debug('Panel List -----'+ PanelList );    
     
        if(Stage!=null && Stage.Nofa_Group__r.Id!=null){
           NOFA_Group__c nfGrp = [Select n.Name, n.Id,Review_of__c, (Select Id, NOFA__c From NOFA_Member__r) From NOFA_Group__c n where Id = :Stage.Nofa_Group__r.Id];
           if(nfgrp != null && nfGrp.NOFA_Member__r != null){
               for(NOFA_Member__c nm: nfGrp.NOFA_Member__r){
                    nofaIds.add(nm.NOFA__c);
               }
           System.debug('NOFA ---- ' + nofaIds);
           }      
           if(nofaIds.size()>0){
                appList = new list<Application3__c>([Select Id,Name,status__c,Organization__r.Name,Organization__r.Organization_Type__c,Disaster_Type_CP__c,Disaster_Type__c,
                        Disaster_Type_App__c,recordtype.name,
                            Disaster_Type_Application__c,Disaster_Type_ConceptPaper__c,Round__c,Round__r.Name,Round__r.Round_Number__c,
                            Project__r.Project_State__c,
                            Capacity_Building_CP__c,
                            Capacity_Building__c,
                            Natural_and_Other_Disasters__c,
                            Natural_and_Other_Disasters_CP__c,
                            Energy_Conservation__c,
                            Energy_Conservation_CP__c,
                            Environmental_Stewardship_Conservation__c,
                            Environmental_Stewardship_Conservation_C__c,
                            Infrastructure_Improvement__c,
                            Infrastructure_Improvement_CP__c,
                            Urban_and_Rural_Development__c,
                            Urban_and_Rural_Development_CP__c,
                            Education__c,
                            Education_CP__c,
                            Veterans_Military_Families__c,
                            Veterans_and_Military_Families_CP__c,
                            Disaster_Services__c,
                            Disaster_Services_CP__c,
                            Environmental_Stewardship__c,
                            Environment_Stewardship_CP__c,
                            Healthy_Futures__c,
                            Healthy_Futures_CP__c,
                            Economic_Opportunities__c,
                            Economic_Opportunities_CP__c from Application3__c where status__c in :statusofApp and NOFA_RFP__c IN: nofaIds ]);    
           }
           
           System.Debug('Application List' + appList );
    
       }
       if(PanelList !=Null && !PanelList.isEmpty()){
            
            for(Paneling__c pan: PanelList){
                
               if(appList !=Null && !appList.isEmpty()){
                     
                    for(Application3__c a: appList){
                        System.Debug('Entered Loop');
                        System.Debug('Panel Focus Area  ' + pan.Focus_Area__c);
                        System.Debug('Panel Disaster Type  ' + pan.Disaster_Type__c);
                        System.Debug('Panel Organization Name  ' + pan.Organization__c);
                        System.Debug('Panel Organization Type  ' + pan.Organization_Type__c);
                        System.Debug('Panel Project State  ' + pan.Project_State__c);
                        System.Debug('Panel Round  ' + pan.Round__c);
                        System.Debug('Application Values' + a.Natural_and_Other_Disasters__c);
                        System.Debug('Application Values' + a.Energy_Conservation__c);
                        
                       if((pan.Disaster_Type__c!=Null && ((a.Disaster_Type_CP__c !=null && pan.Disaster_Type__c.contains(a.Disaster_Type_CP__c)) || 
                                                          (a.Disaster_Type__c != null && pan.Disaster_Type__c.contains(a.Disaster_Type__c)) ||
                                                          (a.Disaster_Type_App__c!=null && pan.Disaster_Type__c.contains(a.Disaster_Type_App__c)) || 
                                                          (a.Disaster_Type_Application__c!=null && pan.Disaster_Type__c.contains(a.Disaster_Type_Application__c)) ||
                                                          (a.Disaster_Type_ConceptPaper__c!=null && pan.Disaster_Type__c.contains(a.Disaster_Type_ConceptPaper__c )))) 
                            || (pan.Focus_Area__c != null && ((a.Natural_and_Other_Disasters__c !=null && pan.Focus_Area__c.contains(a.Natural_and_Other_Disasters__c)) ||
                                                             (a.Energy_Conservation__c != null && pan.Focus_Area__c.contains(a.Energy_Conservation__c)) ||
                                                             (a.Environmental_Stewardship_Conservation__c != null && pan.Focus_Area__c.contains(a.Environmental_Stewardship_Conservation__c)) ||
                                                             (a.Infrastructure_Improvement__c != null && pan.Focus_Area__c.contains(a.Infrastructure_Improvement__c)) || 
                                                             (a.Urban_and_Rural_Development__c != null && pan.Focus_Area__c.contains(a.Urban_and_Rural_Development__c )) ||
                                                             (a.Education__c!=null && pan.Focus_Area__c.contains(a.Education__c)) || 
                                                             (a.Veterans_Military_Families__c!=null && pan.Focus_Area__c.contains(a.Veterans_Military_Families__c)) || 
                                                             (a.Disaster_Services__c!=null  && pan.Focus_Area__c.contains(a.Disaster_Services__c)) || 
                                                             (a.Environmental_Stewardship__c!= null && pan.Focus_Area__c.contains(a.Environmental_Stewardship__c )) || 
                                                             (a.Healthy_Futures__c!=null && pan.Focus_Area__c.contains(a.Healthy_Futures__c)) ||
                                                             (a.Economic_Opportunities__c!=null && pan.Focus_Area__c.contains(a.Economic_Opportunities__c)) || 
                                                             (a.Capacity_Building__c!=null && pan.Focus_Area__c.contains(a.Capacity_Building__c)))) 
                            || (pan.Organization_Type__c != null && ((a.Organization__r.Organization_Type__c !=null && pan.Organization_Type__c.contains(a.Organization__r.Organization_Type__c )))) 
                            || (pan.Project_State__c != null && ((a.Project__r.Project_State__c != null && pan.Project_State__c.contains(a.Project__r.Project_State__c))))
                            || (pan.Round__c != null && ((a.Round__c != null && pan.Round__c.contains(a.Round__c)))) 
                            || (pan.Organization__c != null && ((a.Organization__r.Name != null && pan.Organization__c.contains(a.Organization__r.Name))))
                            || (pan.Disaster_Type__c ==Null && pan.Focus_Area__c == Null && pan.Organization_Type__c == Null && pan.Project_State__c== Null && pan.Round__c==Null && pan.Organization__c== Null)){
                        
                        System.Debug('Entered IF');
                            a.status__c = 'Review In Progress';
                            Panel_Application__c pa = new Panel_Application__c();
                            pa.Application__c = a.id;
                            pa.Paneling__c = pan.id;
                           // apps.add(a);
                           update a;
                            PanelApp.add(pa);
                        }
                    }
                   // update apps;
                }
            
            }
        
        }
        if(PanelApp.size()>0){
          insert PanelApp;
        }
        System.Debug('Panel Application-----'+PanelApp);
        PageReference pageRef = new PageReference('/'+Stage.Id);
        pageRef.setRedirect(true);
        return pageRef;
    }
}