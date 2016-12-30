public with sharing class AssignPanels {
	public static void panelAssignments(set<Id> panelIds){
		
        // Apex code for handling record from a Detail page goes here
        set<Id> stageIds = new set<Id>();
      
        map<Id,Paneling__c> panelMap = new map<Id,Paneling__c>();
        list<Paneling__c> panels = [Select Id,Staff_Liasion1__c,Panel_Coordinator__c,Name,Stage_Number__c,Stage_Number__r.Instructions_to_Reviewers__c from Paneling__c where Id in :panelIds];
        for(Paneling__c p: panels){
        	stageIds.add(p.Stage_Number__c);
        	panelMap.put(p.Id,p);
        }
        
        list<Stages__c> stages = [Select Name, Id,  Section_1__c, Section_2__c, Section_3__c, Section_4__c, Section_5__c, Instructions_to_Reviewers__c,(Select Id, Attachment_Id__c, Name, Description__c, Type__c, Stages__c From Attachments__r) 
                             From Stages__c  where Id in :stageIds];
        map<Id,Stages__c> stageMap = new map<Id,Stages__c>();
        for(Stages__c s:stages){
        	stageMap.put(s.Id,s);
        }
        Set<Id> PanelMembers = new Set<Id>();
        Set<Id> PanelMembers1 = new Set<Id>();
        Set<Id> PanelApplications = new Set<Id>();      
        
       
        /*map<Id,Panel_Member__c> reviewerIdtoPMId = new map<Id,Panel_Member__c>();
        map<Id, Panel_Member__c> staffReviewerIdtoPMId = new map<Id,Panel_Member__c>();*/
        
        List<Expert_Review_Panel__c> ExpertReviewPanels = new List<Expert_Review_Panel__c>();
        List<Application_Feedback__c> AppFeedbackList = new List<Application_Feedback__c>();
        List<Feedback_questions__c> Feedques = new List<Feedback_questions__c>();
        List<Stage_Question__c > SQ1= new List<Stage_Question__c >();
        
        /* Get a list of all of the Contacts associated with the panel */
        List<Panel_Member__c> panelMemberList = new List<Panel_Member__c>();
        List<Panel_Member__c> panelMemberList1 = new List<Panel_Member__c>();
        panelMemberList1 = [SELECT Id,Staff_Member__c,Role__c,Panel__c FROM Panel_Member__c where Panel__c in :panelIds and Staff_Member__c!=null];
        panelMemberList = [SELECT Id,Expert_Reviewer__c,Role__c,Panel__c FROM Panel_Member__c where Panel__c in :panelIds and Expert_Reviewer__c!=null];       
        for(Panel_Member__c pm: panelMemberList){
          PanelMembers.add(pm.Expert_Reviewer__c);          
          //reviewerIdtoPMId.put(pm.Expert_Reviewer__c,pm); 
        }
        for(Panel_Member__c pm1: panelMemberList1){
          PanelMembers1.add(pm1.Staff_Member__c);
          //staffReviewerIdtoPMId.put(pm1.Staff_Member__c,pm1);
          
        }
        
        
        

        /* Get a list of all of the Applications associated with the panel */
        List<Panel_Application__c> panelApplicationList = new List<Panel_Application__c>();
        panelApplicationList = [SELECT Id,Application__c,Paneling__c FROM Panel_Application__c where Paneling__c in :panelIds];
        map<Id,Panel_Application__c> panelAppMap = new map<Id,Panel_Application__c>();
        for(Panel_Application__c pm: panelApplicationList){
          PanelApplications.add(pm.Application__c);
          panelAppMap.put(pm.Application__c,pm);
        }
        
        //List<Stage_Question__c > SQ1 = new List<Stage_Question__c >();
        SQ1 = [SELECT ID, Name,Active__c, If_Yes_Comments_Required__c,Question__c,Scoring_Method__c,Section__c,Weight__c,Roles__c,Stages_ID__c FROM Stage_Question__c where Stages_ID__c in :stageIds order by Section__c];
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        for(Paneling__c p:panels){
	        for (Panel_Member__c pm: panelMemberList){
	        	if(pm.Panel__c == p.Id){
		            Expert_Review_Panel__c exp = new Expert_Review_Panel__c();
		            if(pm != null)
			        {	
			        	system.debug('got here in exp loop = ');
			            exp.Reviewer__c = pm.Expert_Reviewer__c;
			            exp.Panel__c = p.Id;
			            exp.Panel_Member__c = pm.Id;
			            exp.Role__c = pm.Role__c;
			            //Set the Status 
			            ExpertReviewPanels.add(exp);
		            }
	        	}
	        }
        }
        for(Paneling__c p:panels){
	       	 for(Panel_Member__c pm: panelMemberList1){
	       	 	if(pm.Panel__c == p.Id){
		            Expert_Review_Panel__c exp1 = new Expert_Review_Panel__c();
		            if(pm != null)
		            {
			            exp1.Staff_Reviewer__c= pm.Staff_Member__c;
			            exp1.Panel__c = p.Id;
			            exp1.Panel_Member__c = pm.Id;
			            exp1.Role__c = pm.Role__c;
			            //Set the Status 
			            ExpertReviewPanels.add(exp1);
		            }
	       	 	}
	         }
        }
        system.debug('ExpertReviewPanels = '+ExpertReviewPanels);
        insert ExpertReviewPanels;
        
        
        
      
        
        
        /* Create an Expert Reviewer Panel Object for each Reviewer */
        system.debug('ExpertReviewPanels = '+ExpertReviewPanels);
        system.debug('panelApplications = '+panelApplications);
        for (Expert_Review_Panel__c ExpertPanel: ExpertReviewPanels){              
            for (Panel_Application__c pa: panelApplicationList){
            	if(ExpertPanel.Panel__c == pa.Paneling__c){
            		system.debug('got here in app feedback loop ');
	                Application_Feedback__c appFeedback = new Application_Feedback__c();
	                appFeedback.Expert_Review_Panel__c = ExpertPanel.Id;
	                
	                appFeedback.Application__c = pa.Application__c;
	                appFeedback.Instructions__c = panelMap.get(ExpertPanel.Panel__c).Stage_Number__r.Instructions_to_Reviewers__c ;
	                appFeedback.Staff_Liasion1__c= panelMap.get(ExpertPanel.Panel__c).Staff_Liasion1__c;
	                appFeedback.Panel_Coordinator__c = panelMap.get(ExpertPanel.Panel__c).Panel_Coordinator__c; 
	                //Need to add the Feedback Form
	                AppFeedbackList.add(appFeedback);
            	}
                    
            }  
        
        }
        
        if(AppFeedbackList.size()>0){           
            insert AppFeedbackList;
        }
        
        
       // Stage_Question__c stageque = [ Select Id, Name, Active__c, Allow_Comments__c, If_Yes_Comments_Required__c, Question__c, Roles__c, Scoring_Method__c, Section__c, Weight__c from Stage_Question__c where Id = :stage];
       list<Application_Feedback__c> appFeedBacks = new list<Application_Feedback__c>([Select Id,Expert_Review_Panel__r.Panel__r.Stage_Number__c from
       													Application_Feedback__c where Id in :AppFeedbackList]); 
       if(AppFeedbackList.size()>0 && SQ1.size()>0){ 
           for(Application_Feedback__c AppFeedback:appFeedBacks)
           {
                for( Stage_Question__c sq: SQ1 ) 
                { 
                  system.debug('sq.Stages_ID__c '+sq.Stages_ID__c);
            	  system.debug('AppFeedback.Expert_Review_Panel__r.Panel__r.Stage_Number__c '+AppFeedback.Expert_Review_Panel__r.Panel__r.Stage_Number__c); 	
                  if(sq.Stages_ID__c == AppFeedback.Expert_Review_Panel__r.Panel__r.Stage_Number__c){ 
                  		
                   Feedback_questions__c fq = new Feedback_questions__c();
                   fq.Application_Feedback__c = AppFeedback.Id;
                   fq.Stage_Question2__c = sq.Id;
                   fq.Stages_ID__c = sq.Stages_ID__c;
                   fq.Question__c = sq.Question__c;
                   fq.Scoring_Method__c = sq.Scoring_Method__c;
                   fq.weight__c = sq.Weight__c;
                   fq.Active__c = sq.Active__c;
                   fq.Comments_Required__c = sq.If_Yes_Comments_Required__c;
                   fq.Roles__c = sq.Roles__c; 	
                 
                   if(sq.Section__c == 'Section 1')
                   {
                   fq.Name__c = stageMap.get(sq.Stages_ID__c).Section_1__c;
                   }
                   else if(sq.Section__c== 'Section 2')
                   {
                   fq.Name__c = stageMap.get(sq.Stages_ID__c).Section_2__c;
                   }
                   else if(sq.Section__c== 'Section 3')
                   {
                   fq.Name__c = stageMap.get(sq.Stages_ID__c).Section_3__c;
                   }
                   else if(sq.Section__c== 'Section 4')
                   {
                   fq.Name__c = stageMap.get(sq.Stages_ID__c).Section_4__c;
                   }
                   else
                   {
                   fq.Name__c = stageMap.get(sq.Stages_ID__c).Section_5__c;
                   }
                   
                   
                   //fq.ID= panelQuestion2;
                   Feedques.add(fq);
                
                }
                }
           }
       }
       if(Feedques.size()>0){
          insert Feedques;
       }
        
        
        
        
    
    }
	
}