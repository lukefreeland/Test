public  without sharing class ExpertReviewPanelHelper {
    
    public static void shareApplications(list<Expert_Review_Panel__c> newRecs){
        set<Id> panelIds = new set<Id>();  
        set<Id> appIds = new set<Id>();     
        map<Id,Id> reviewerIdtoPanelId = new map<Id,Id>(); 
        map<Id,Id> stafffMemebertoPanelId = new map<Id,Id>(); 
        map<Id,list<Id>> conIdtoAppId = new map<Id,list<Id>>();
        
        for(Expert_Review_Panel__c er: newRecs){
            panelIds.add(er.Panel__c);          
            if(er.Reviewer__c!=null)
                reviewerIdtoPanelId.put(er.Reviewer__c,er.Panel__c);
            /*if(er.Staff_Reviewer__c!=null)
                stafffMemebertoPanelId.put(er.Staff_Reviewer__c,er.Panel__c);*/
        }
        Map<Id,Paneling__c> panels = new Map<Id,Paneling__c>([Select Id,(Select Id, Paneling__c, Application__c From Panel_Applications__r) From Paneling__c p where Id in :panelIds]);
        
        if(reviewerIdtoPanelId.size()>0){
            list<Application3__Share> appShares = new list<Application3__Share>();
            list<User> users = new list<User>([Select Id,Name,ContactId from User where ContactId in :reviewerIdtoPanelId.keyset()]);
            map<String,String> appShareMap = new map<String,String>();
            Map<Id,Application3__Share> appSharesExisting = new map<Id,Application3__Share>([Select Id,ParentId,UserOrGroupId from Application3__Share where UserOrGroupId in :users]);
            if(appSharesExisting.size()>0){
            	for(Application3__Share a: appSharesExisting.values()){
            		appShareMap.put(string.valueOf(a.UserOrGroupId)+string.valueOf(a.ParentId),a.ParentId);
            	}            	            	
            }
            for(User u: users){
            	system.debug('u.Id = '+u.Id);
            	system.debug('appShareMap = '+appShareMap);
                list<Panel_Application__c> panelApps = panels.get(reviewerIdtoPanelId.get(u.ContactId)).Panel_Applications__r;
                for(Panel_Application__c p: panelApps){   
                	system.debug('p app = '+p.Application__c);
                	system.debug('app = '+appShareMap.get(string.valueOf(u.Id)+string.valueOf(p.Application__c)));
                	if(appShareMap.get(string.valueOf(u.Id)+string.valueOf(p.Application__c))==null){                		
	                	appIds.add(p.Application__c);              
	                    Application3__Share aShare = new Application3__Share();
	                    aShare.ParentId = p.Application__c;
	                    aShare.userorgroupId = u.Id;
	                    aShare.AccessLevel = 'Read';
	                    appShares.add(aShare);
	                    
	                    if(conIdtoAppId.keyset().contains(u.Id)){
	                        conIdtoAppId.get(u.Id).add(p.Application__c);
	                    }
	                    else{
	                    //if it is the first time on the loop
	                        conIdtoAppId.put(u.Id,new list<Id>());
	                        conIdtoAppId.get(u.Id).add(p.Application__c);
	                    }
                	}
                }
            }
            list<Location__Share> locShares = new list<Location__Share>();
            if(appIds.size()>0){
            	map<Id,Application3__c> apps = new map<Id,Application3__c>([Select Id,(Select Id,Name from Locations__r) from Application3__c where Id in :appIds]);
            	if(apps.size()>0){
            		for(Id i: conIdtoAppId.keyset()){
            			if(conIdtoAppId.get(i) != null){
	            			list<Id> appIdsforUser = conIdtoAppId.get(i);
	            			for(Id j: appIdsforUser){
	            				if(apps.get(j).Locations__r.size()>0){
	            					for(Location__c l: apps.get(j).Locations__r){
	            						Location__Share aShare = new Location__Share();
                    					aShare.ParentId = l.Id;
                    					aShare.userorgroupId = i;
                    					aShare.AccessLevel = 'Read';
                    					locShares.add(aShare);	            						
	            					}
	            				}
	            			}
            			}
	            		
            		}
            	}
            	
            }
            system.debug('appshares = '+appshares);
            if(appShares.size()>0){
                insert appShares;
            }
            if(locShares.size()>0){
            	insert locshares;
            }
        }
        /*if(stafffMemebertoPanelId.size()>0){
            list<Application3__Share> appShares2 = new list<Application3__Share>();
            list<User> users = new list<User>([Select Id,Name,ContactId from User where ContactId in :stafffMemebertoPanelId.keyset()]);
            for(User u: users){
                list<Panel_Application__c> panelApps = panels.get(stafffMemebertoPanelId.get(u.ContactId)).Panel_Applications__r;
                for(Panel_Application__c p: panelApps){                 
                    Application3__Share aShare = new Application3__Share();
                    aShare.ParentId = p.Application__c;
                    aShare.userorgroupId = u.Id;
                    aShare.AccessLevel = 'Read';
                    appShares2.add(aShare);
                }
            }
            if(appShares2.size()>0){
                insert appShares2;
            }
        }*/
    }
    
    /*public static void shareExternal(){
        list<Expert_Review_Panel__Share> erpShares = new list<Expert_Review_Panel__Share>();
           
        for(SampleShare__c e : [Select Name, parentid__c, userid__c From SampleShare__c] ){
            Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share ();
            aShare.ParentId = e.parentid__c;
        
            aShare.userorgroupId = e.userid__c ;
            aShare.AccessLevel = 'Edit';
            erpShares.add(aShare);
        }
        
        if(erpShares.size()>0){
          System.debug('*** erpShares***- erpShares.size()***'+erpShares);
          insert erpShares;
        }
        
    }*/
    
     public static void createERPSharingRecords(list<Expert_Review_Panel__c> erps){
        System.debug('***createERPSharingRecords***');
        set<Id> panelIds = new set<Id>();
        set<Id> panelCoordinators = new set<Id>();            
        list<User> users = new list<User>();
        list<User> reviewerUsers = new list<User>();
        list<Expert_Review_Panel__Share> erpShares = new list<Expert_Review_Panel__Share>();
        list<Expert_Review_Panel__Share> erpSharesForReviewers = new list<Expert_Review_Panel__Share>();
        map<Id,Expert_Review_Panel__c> erpMap = new map<Id,Expert_Review_Panel__c>();
        
        set<Id> expRevID=new set<Id>();
               
                       
        for(Expert_Review_Panel__c e: erps){
            panelIds.add(e.Panel__c);           
            if(e.Reviewer__c!=null){
            	erpMap.put(e.Reviewer__c,e);
            }            
        }
        
        list<Paneling__c> panels = [Select Id,Name,Panel_Coordinator__c,Staff_Liasion1__c from Paneling__c where Id in :panelIds]; 
        for(Paneling__c p: panels){
        	if(p.Panel_Coordinator__c!=null){
            	panelCoordinators.add(p.Panel_Coordinator__c);
        	}
            //staffUsers.add(p.Staff_Liasion1__c);
        }            
        
        system.debug('erpMap.keyset() = '+erpMap.keyset());
        Users = [Select Id,Name,contactId,IsActive  from User where contactId in :panelCoordinators];
        reviewerUsers = [Select Id,Name,ContactId,IsActive from User where contactId in :erpMap.keyset()];
        
        
        if(Users.size()>0){
            for(User u: Users){
            	if(u.IsActive){               
                    for(Expert_Review_Panel__c e: erps){
                        Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share ();
                        aShare.ParentId = e.Id;                    
                        aShare.userorgroupId = u.Id;
                        aShare.AccessLevel = 'Edit';
                        erpShares.add(aShare);
                    }  
            	}              
            } 
        }
        
       
        
        
        if(erpShares.size()>0){
          System.debug('*** erpShares***- erpShares.size()***'+erpShares);
          insert erpShares;
        } 
        system.debug('reviewerUsers = '+reviewerUsers);
        for(User u:reviewerUsers){
          if(u.IsActive){
            for(Expert_Review_Panel__c e: erps){
                if(e.Reviewer__c == u.ContactId){
                     Expert_Review_Panel__Share aShare = new Expert_Review_Panel__Share();
                     aShare.ParentId = e.Id;
                     aShare.userorgroupId = u.Id;
                     aShare.AccessLevel = 'Edit';
                     erpSharesForReviewers.add(aShare);
                }
            }
          }
        } 
        
        if(erpSharesForReviewers.size()>0){
          System.debug('*** erpShares for reviewers***- erpShares.size()***'+erpShares);	
          insert erpSharesForReviewers;
        }
        
    }
    
    

}