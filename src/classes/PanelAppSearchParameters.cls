public class PanelAppSearchParameters {
     public String arecId {get; set;}
     public String asearchParameter {get;set;}
     public list<String>  selected{get;set;}
     public list<String>  deselected{get;set;}
     public set<String> selectedSet = new set<String>();
     public set<String> deselectedSet = new set<String>();
     public ApplicationSearchCont panelEdit{get;set;}
     
     public list<selectOption> options {            
        set;
        get{
         system.debug('asearchParameter = '+asearchParameter);
         options = new list<SelectOption>();     
         options.add(new Selectoption('Available','Available',true));
            
         list<Application3__c> apps = new list<Application3__c>();
         
         set<Id> nofaIds = new set<Id>();
         Paneling__c parent = [Select Id, Name, Stage_Number__r.NOFA_Group__r.Id from Paneling__c where Id = :arecId];
         if(parent!=null && parent.Stage_Number__r.Nofa_Group__r.Id!=null)
         {
                NOFA_Group__c nfGrp = [Select n.Name, n.Id,Review_of__c, (Select Id, NOFA__c From NOFA_Member__r) From NOFA_Group__c n where Id = :parent.Stage_Number__r.Nofa_Group__r.Id];
                if(nfgrp != null && nfGrp.NOFA_Member__r != null)
                {
                    for(NOFA_Member__c nm: nfGrp.NOFA_Member__r)
                    {
                        nofaIds.add(nm.Nofa__c);
                    }
                }           
          
                if(nofaIds.size()>0)
                {
                    apps = [Select Id,Name,Organization__r.Name,Organization__r.Organization_Type__c,Disaster_Type_CP__c,Disaster_Type__c,
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
                            Economic_Opportunities_CP__c
                            from Application3__c where Nofa_Rfp__c in :nofaIds];                   
                }
          } 
         
          if(asearchParameter == 'OrganizationName'){   
          	        if(deselectedSet.size()==0){        
	                    for(Application3__c a: apps){
	                        if(a.Organization__r.Name!=null){                        	
	                            	deselectedSet.add(a.Organization__r.Name);                         	                              
	                        }
	                    }
          		    }
                    /*if(deselectedSet.size()>0){
                        for(String s: deselectedSet){
                            options.add(new SelectOption(s,s));   
                        }
                    }*/
                    if(panelEdit!=null){
                    	String fieldValue = (String)panelEdit.panel.Organization__c;
                    	if(fieldValue!=null){
                    		 list<String> values = fieldValue.split(';');
                     		 for(String s: values){
                     		 	 for(string ns : deselectedSet){
                            	   if(s==ns){
                                      deselectedSet.remove(ns);
                            	   }
                     		 	 }                       
                     		 }
                     		 for(string ns : deselectedSet){                            
                        		options.add(new SelectOption(ns,ns));                           
                     		 }    
                    	}
                    	else{            
                    		for(string s : deselectedSet){
                        		options.add(new SelectOption(s,s));
                    		}
                		}
                    }
                    else{            
                		for(string s : deselectedSet){
                    		options.add(new SelectOption(s,s));
                		}
            		}      
          }
          
          if(asearchParameter == 'OrganizationType'){
          			if(deselectedSet.size()==0){           
                        for(Application3__c a: apps){
                        	if(a.Organization__r.Organization_Type__c!=null){                        	
                            	deselectedSet.add(a.Organization__r.Organization_Type__c);
                        	}                              
                        }
                    }
                    if(panelEdit!=null){
                    	String fieldValue = (String)panelEdit.panel.Organization_Type__c;
                    	if(fieldValue!=null){
                    		 list<String> values = fieldValue.split(';');
                     		 for(String s: values){
                     		 	 for(string ns : deselectedSet){
                            	   if(s==ns){
                                      deselectedSet.remove(ns);
                            	   }
                     		 	 }                       
                     		 }
                     		 for(string ns : deselectedSet){                            
                        		options.add(new SelectOption(ns,ns));                           
                     		 }    
                    	}
                    	else{            
                    		for(string s : deselectedSet){
                        		options.add(new SelectOption(s,s));
                    		}
                		}
                    }
                    else{            
                		for(string s : deselectedSet){
                    		options.add(new SelectOption(s,s));
                		}
            		}
          }
          if(asearchParameter == 'ProjectStates'){
          			if(deselectedSet.size()==0){           
                        for(Application3__c a: apps){
                        	if(a.Project__r.Project_State__c!=null){                        	
                            	deselectedSet.add(a.Project__r.Project_State__c);
                        	}                              
                        }
                    }
                    if(panelEdit!=null){
                    	String fieldValue = (String)panelEdit.panel.Project_State__c;
                    	if(fieldValue!=null){
                    		 list<String> values = fieldValue.split(';');
                     		 for(String s: values){
                     		 	 for(string ns : deselectedSet){
                            	   if(s==ns){
                                      deselectedSet.remove(ns);
                            	   }
                     		 	 }                       
                     		 }
                     		 for(string ns : deselectedSet){                            
                        		options.add(new SelectOption(ns,ns));                           
                     		 }    
                    	}
                    	else{            
                    		for(string s : deselectedSet){
                        		options.add(new SelectOption(s,s));
                    		}
                		}
                    }
                    else{            
                		for(string s : deselectedSet){
                    		options.add(new SelectOption(s,s));
                		}
            		}
          }
          
          if(asearchParameter == 'DisasterTypes'){ 
          	        if(deselectedSet.size()==0){          
                    	for(Application3__c a: apps){                    	
	                        if(a.Disaster_Type_CP__c!=null){
	                            deselectedSet.add(a.Disaster_Type_CP__c);                              
	                        }
	                        if(a.Disaster_Type__c!=null){
	                            deselectedSet.add(a.Disaster_Type__c);                              
	                        }
	                        if( a.Disaster_Type_App__c!=null ){
	                            deselectedSet.add(a.Disaster_Type_App__c);                              
	                        }
	                        if(a.Disaster_Type_Application__c!=null){
	                            deselectedSet.add(a.Disaster_Type_Application__c);                              
	                        }
	                        if(a.Disaster_Type_ConceptPaper__c !=null){
	                            deselectedSet.add(a.Disaster_Type_ConceptPaper__c );                              
	                        }
                    	}
                    }
                    if(panelEdit!=null){
                    	String fieldValue = (String)panelEdit.panel.Disaster_Type__c;
                    	if(fieldValue!=null){
                    		 list<String> values = fieldValue.split(';');
                     		 for(String s: values){
                     		 	 for(string ns : deselectedSet){
                            	   if(s==ns){
                                      deselectedSet.remove(ns);
                            	   }
                     		 	 }                       
                     		 }
                     		 for(string ns : deselectedSet){                            
                        		options.add(new SelectOption(ns,ns));                           
                     		 }    
                    	}
                    	else{            
                    		for(string s : deselectedSet){
                        		options.add(new SelectOption(s,s));
                    		}
                		}
                    }
                    else{            
                		for(string s : deselectedSet){
                    		options.add(new SelectOption(s,s));
                		}
            		}
          }
          
          if(asearchParameter == 'Rounds'){      
          			if(deselectedSet.size()==0){     
	                    for(Application3__c a: apps){
	                        if(a.Round__c!=null){
	                           	deselectedSet.add(a.Round__r.Name+' '+a.Round__r.Round_Number__c);
	                       	}                              
	                    }
                    }
                    if(deselectedSet.size()>0){
                        for(String s: deselectedSet){
                            options.add(new SelectOption(s,s));   
                        }
                    }
          }
          if(asearchParameter == 'FocusAreas'){      
          			if(deselectedSet.size()==0){     
	                    for(Application3__c a: apps){
	                      if(a.recordtype.name == 'Application'){	
	                        if(a.Natural_and_Other_Disasters__c!=null){
	                        	list<String> values = a.Natural_and_Other_Disasters__c.split(';'); 
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Energy_Conservation__c!=null){
	                        	list<String> values = a.Energy_Conservation__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Environmental_Stewardship_Conservation__c!=null){
	                        	list<String> values = a.Environmental_Stewardship_Conservation__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Infrastructure_Improvement__c!=null){
	                        	list<String> values = a.Infrastructure_Improvement__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Urban_and_Rural_Development__c!=null){
	                        	list<String> values = a.Urban_and_Rural_Development__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Education__c!=null){
	                        	list<String> values = a.Education__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Veterans_Military_Families__c!=null){
	                        	list<String> values = a.Veterans_Military_Families__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Disaster_Services__c!=null){
	                        	list<String> values = a.Disaster_Services__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }
	                        if(a.Environmental_Stewardship__c!=null){
	                        	list<String> values = a.Environmental_Stewardship__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }
	                        if(a.Disaster_Services__c!=null){
	                        	list<String> values = a.Disaster_Services__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }
	                        if(a.Healthy_Futures__c!=null){
	                        	list<String> values = a.Healthy_Futures__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }
	                        if(a.Economic_Opportunities__c!=null){
	                        	list<String> values = a.Economic_Opportunities__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	
	                        if(a.Capacity_Building__c!=null){
	                        	list<String> values = a.Capacity_Building__c.split(';');
	                        	for(String s: values){
	                        	 	deselectedSet.add(s);
	                       		}                              
	                        }	            
	                      }               	
	                    }
                    }
                    if(panelEdit!=null){
                    	String fieldValue = (String)panelEdit.panel.Focus_Area__c;
                    	if(fieldValue!=null){
                    		 list<String> values = fieldValue.split(';');
                     		 for(String s: values){
                     		 	 for(string ns : deselectedSet){
                            	   if(s==ns){
                                      deselectedSet.remove(ns);
                            	   }
                     		 	 }                       
                     		 }
                     		 for(string ns : deselectedSet){                            
                        		options.add(new SelectOption(ns,ns));                           
                     		 }    
                    	}
                    	else{            
                    		for(string s : deselectedSet){
                        		options.add(new SelectOption(s,s));
                    		}
                		}
                    }
                    else{            
                		for(string s : deselectedSet){
                    		options.add(new SelectOption(s,s));
                		}
            		}
          }
            
         return options;
        }
     }
        
     public void selecting(){   
       selected.clear();
       system.debug('deselected = '+deselected);
       system.debug('selected = '+selected);
       for(String s: deselected){
            deselectedSet.remove(s);            
            selectedSet.add(s);
       } 
       system.debug('selected options after selecting = '+selectedOptions);
       assignOptions(selectedOptions,asearchParameter);      
     }
     
     public list<selectOption> selectedOptions{
         set;
         get{
          	selectedOptions = new list<SelectOption>(); 
            selectedOptions.add(new Selectoption('Chosen','Chosen',true));
            if(panelEdit!=null){
            	if(asearchParameter == 'OrganizationName'){
	                String fieldValue = (String)panelEdit.panel.Organization__c;	                              	                 
	                if(fieldValue != null && fieldValue != ''){
	                     list<String> values = fieldValue.split(';');
	                     for(String s: values){
	                        selectedSet.add(s);
	                     }              
	                } 
            	}
            	if(asearchParameter == 'OrganizationType'){
	                String fieldValue = (String)panelEdit.panel.Organization_Type__c;	                              	                 
	                if(fieldValue != null && fieldValue != ''){
	                     list<String> values = fieldValue.split(';');
	                     for(String s: values){
	                        selectedSet.add(s);
	                     }              
	                } 
            	}
            	if(asearchParameter == 'ProjectStates'){
	                String fieldValue = (String)panelEdit.panel.Project_State__c;	                              	                 
	                if(fieldValue != null && fieldValue != ''){
	                     list<String> values = fieldValue.split(';');
	                     for(String s: values){
	                        selectedSet.add(s);
	                     }              
	                } 
            	}
            	if(asearchParameter == 'DisasterTypes'){
	                String fieldValue = (String)panelEdit.panel.Disaster_Type__c;	                              	                 
	                if(fieldValue != null && fieldValue != ''){
	                     list<String> values = fieldValue.split(';');
	                     for(String s: values){
	                        selectedSet.add(s);
	                     }              
	                } 
            	}
            	if(asearchParameter == 'FocusAreas'){
	                String fieldValue = (String)panelEdit.panel.Focus_Area__c;	                              	                 
	                if(fieldValue != null && fieldValue != ''){
	                     list<String> values = fieldValue.split(';');
	                     for(String s: values){
	                        selectedSet.add(s);
	                     }              
	                } 
            	}
            }
            system.debug('selected set = '+selectedSet);
            if(selectedSet!=null){
                 for(String toSelect: selectedSet) {
                     selectedOptions.add(new SelectOption(toSelect,toSelect,false));
                 }
             }
            
             return selectedOptions;
             
         }
     }
     
     public void deselecting(){   
        deselected.clear();
        system.debug('deselected when unselected = '+deselectedSet);
        system.debug('selected when unselected = '+selectedSet);
        system.debug('selected in deselect function = '+selected);
        for(String s: selected){
            selectedSet.remove(s);
            deselectedSet.add(s);
        }
        list<selectOption> options = new list<selectOption>(); 
        for(String toSelect: selectedSet) {
            options.add(new SelectOption(toSelect,toSelect,false));
        }
        assignOptions(options,asearchParameter);       
       
     }
     
     public void assignOptions(list<selectOption> options,string searchParameter){
        //ahandle.chosenList = options;
        list<String> values = new list<string>();
        for(selectOption option:options){
            if(option.getValue()!='Chosen')
                values.add(option.getValue());
        }
        String combinedString = ' ';
        for(String s: values){
           if(combinedString == ' '){
               combinedString=s + ';' ;
           }else{
               combinedString+= s + ';' ;
           }
       }            
       if(panelEdit!=null){
       	  if(searchParameter == 'OrganizationName')
            panelEdit.panel.put('Organization__c',combinedString); 
            
          if(searchParameter == 'OrganizationType')
            panelEdit.panel.put('Organization_Type__c',combinedString);
            
          if(searchParameter == 'ProjectStates')
            panelEdit.panel.put('Project_State__c',combinedString);
            
          if(searchParameter == 'Rounds')
            panelEdit.panel.put('Round__c',combinedString);
            
          if(searchParameter == 'DisasterTypes')
            panelEdit.panel.put('Disaster_Type__c',combinedString);
            
          if(searchParameter == 'FocusAreas')
            panelEdit.panel.put('Focus_Area__c',combinedString);  
          
       }
       
    }
        
}