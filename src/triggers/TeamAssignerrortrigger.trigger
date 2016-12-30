trigger TeamAssignerrortrigger on Team_Assignment__c (before insert,before update)
{
	string teamn = '';
	set<id> set1 = new set<id>();
	list<id> teamidset = new list<id>();
	map<id,string> namemap = new map<id,string>();
    for(Team_Assignment__c tass : trigger.new)
    {
          teamidset.add(tass.Team_Name__c);
    } 
    list<Team_Assignment__c> teamassn = [select id,name,Campus_Arrival_Date__c,Campus_Departure_Date__c,Project_Departure_Date__c from Team_Assignment__c where Team_Name__c in : teamidset];
        
    list<team__c> teamt = [select id,name from team__c where id in : teamidset];
    for(team__c t :teamt )
    {
         namemap.put(t.id,t.name);
    }
                      
    for(Team_Assignment__c ta : trigger.new){
            for(Team_Assignment__c teamassg : teamassn )
            {
               if(ta.id != teamassg.id)
               {
                    teamn= namemap.get(ta.Team_Name__c);
                    if(ta.No_Transition__c == true){
	                    if((ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Departure_Date__c <= teamassg.Project_Departure_Date__c) && ta.Project_Departure_Date__c >= teamassg.Project_Departure_Date__c){
	                    ta.adderror(teamn+ ' ' + 'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if (ta.Campus_Departure_Date__c <=teamassg.Campus_Departure_Date__c && (ta.Project_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c <= teamassg.Project_Departure_Date__c )){
	                    ta.adderror(teamn+ ' ' +'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if(ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c <= teamassg.Project_Departure_Date__c){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if(ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && ta.Project_Departure_Date__c >= teamassg.Project_Departure_Date__c){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
				        else
				        {
				        }
                    }
	   			    else
	                {
	                    if((ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Departure_Date__c <= teamassg.Campus_Arrival_Date__c) && ta.Campus_Arrival_Date__c >= teamassg.Campus_Arrival_Date__c){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if (ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && (ta.Campus_Arrival_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c <= teamassg.Campus_Arrival_Date__c )){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if(ta.Campus_Departure_Date__c >= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c <= teamassg.Campus_Arrival_Date__c){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	                    else if(ta.Campus_Departure_Date__c <= teamassg.Campus_Departure_Date__c && ta.Campus_Arrival_Date__c >= teamassg.Campus_Arrival_Date__c){
	                    ta.adderror(teamn+' '+'cannot be associated to this award for the specified dates because the team is associated with a different award during that period.');
	                    }
	       				else
	       				{
	       				}
	      			}
      		   }
            }
    } 
    
    Set<Id> awardIds = new Set<Id>();
    for(Team_Assignment__c t: trigger.new){
    	awardIds.add(t.Award__c);
    }
    map<Id,Award__c> awardMap = new map<Id,Award__c>([Select Id,Name,(Select Id,Name,Type__c,Description__c from Attachments__r) from Award__c 
    													where Id in :awardIds]);
    map<Id,Boolean> errorMap = new map<Id,Boolean>();													
    for(Award__c a: awardMap.values()){
    	for(Team_Assignment__c t: trigger.new){
    		if(a.Id == t.Award__c){
    			if(a.Attachments__r.size()==0){
    				if(t.Project_Arrival_Date__c!=null){
    					t.addError('Project Arrival Date can be entered Only if Award has an attachment Project Budget Estimate');
    				}
    			}else{
    				if(t.Project_Arrival_Date__c!=null){
    					for(Attachment__c att:a.Attachments__r){
	    					if(att.Type__c == 'Project Budget Estimate'){	   
	    						errorMap.put(t.Award__c,false); 						
	    						break;
	    					}else{
	    						errorMap.put(t.Award__c,true);
	    						continue;
	    					}
	    				}
	    				
    				}
    				
    			}    			
    		}
    	}
    }
    if(errorMap.size()>0){
	  	for(Id i:errorMap.keyset()){
			if(errorMap.get(i)){
			   for(Team_Assignment__c t: trigger.new){
			   	 if(i == t.Award__c){
			   	 	t.addError('Project Arrival Date can be entered Only if Award has an attachment Project Budget Estimate');
			   	 }
			   }	
			}
		}
	}
    
    /*for(Team_Assignment__c t: trigger.new){
    	if(t.Project_Arrival_Date__c!=null){
    		if(awardMap.get(t.Award__c).Attachments__r.size()==0){
    			t.addError('Project Arrival Date can be entered Only if Award has an attachment Project Budget Estimate');
    		}
    		/*else{
    			for(Attachment__c att:awardMap.get(t.Award__c).Attachment__r){
    				if(att.Name != 'Project Budget Estimate' && (att.Description__c!=null && !att.Description__c.contains('Project Budget Estimate'))){
    					
    				} 
    			}
    		}
    		
    	}
    }      */                  
}