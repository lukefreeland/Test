public without sharing class UserHelper {
    public static void shareOrganizationEditPermission(map<Id,User> oldmap, map<Id,User> newmap){
        list<Profile> p = [Select Id,Name from Profile where Name = 'Grantee Admin' or Name = 'State Commission Profile' or Name = 'Applicant'];        
        list<Id> uIds = new list<Id>();
        for(User u: newmap.values()){
            if(u.ProfileId==p[0].Id || u.ProfileId ==p[1].Id || u.ProfileId == p[2].Id){
                if(oldmap==null){
                    if(u.AccountId!=null){
                        uIds.add(u.Id);                     
                    }               
                }else{
                    if(u.AccountId!=null && oldmap.get(u.Id).AccountId!=u.AccountId){
                        uIds.add(u.Id); 
                    }
                }
            }
        }
        if(uIds.size()>0){
            shareOrgsFuture(uIds);
        }       
        
    }
    
    
    @future
    public static void shareOrgsFuture(list<Id> uIds){
        list<User> users = new list<User>([Select isActive,Id,Name,AccountId from User where Id in : uIds]);
        list<AccountShare> accShares = new list<AccountShare>();
        for(User u: users){
          if(u.IsActive){   
            AccountShare accShare = new AccountShare();
            accShare.AccountId = u.AccountId;
            accShare.userorgroupId = u.Id;
            accShare.AccountAccessLevel = 'Edit';
            accShare.OpportunityAccessLevel = 'Read';
            accShares.add(accShare);
          }       
        }
        if(accShares.size()>0){
            insert accShares;
        }
    }
    
    /* public static void assignUserstoGroup(map<Id,User> newmap){
        list<Id> stateCommissionUsers = new list<Id>();
        list<Id> NonStateCommssionUsers = new list<Id>();
        Profile stateCommissionProfile = [Select Id,Name from Profile where Name = 'State Commission Profile'];
        for(User u: newmap.values()){   
            if(u.IsPortalEnabled && u.IsActive){        
                if(u.ProfileId == stateCommissionProfile.Id){
                    // assign to State Commission Group
                    stateCommissionUsers.add(u.Id);
                }else{
                    // assign to Non State Commission Group
                    NonStateCommssionUsers.add(u.Id);               
                }       
            }
        }
        if(stateCommissionUsers.size()>0){
            createGroupMemberSC(stateCommissionUsers);
        }
        if(NonStateCommssionUsers.size()>0){
            createGroupMemberNonSC(NonStateCommssionUsers);
        }
    }
    
    @future
    public static void createGroupMemberSC(list<Id> scIds){
        list<User> stateCommissionUsers = new list<User>([Select Id,Name from User where Id in :scIds]);
        Group scGroup = [select Id from Group Where name = 'State Commission Users'];
        List<GroupMember> gmList = new List<GroupMember>();
        for(User u: stateCommissionUsers){
            if(scGroup!=null){                                                                  
                GroupMember gm = new GroupMember();
                gm.GroupId = scGroup.id;
                gm.UserOrGroupId = u.Id;
                gmList.add(gm);   
            }
        }
        if(gmList.size()>0){
            insert gmList;
        }
    }
    
    @future
    public static void createGroupMemberNonSC(list<Id> nonscIds){
        list<User> NonStateCommssionUsers = new list<User>([Select Id,Name from User where Id in :nonscIds]);
        Group nonScGroup = [select Id from Group Where name = 'Non State Commission Users'];
        list<GroupMember> gmList = new List<GroupMember>();  
        for(User u: NonStateCommssionUsers){
            if(nonScGroup!=null){                                                               
                GroupMember gm = new GroupMember();
                gm.GroupId = nonScGroup.id;
                gm.UserOrGroupId = u.Id;
                gmList.add(gm);   
            }
        }
        if(gmList.size()>0){
            insert gmList;
        }
    }*/
    
    
    public static void shareRecords(map<Id,User> oldMap,map<Id,User> newMap){
            list<Id> uIds = new list<Id>();
            map<String,Id> pMap = new map<String,Id>();  
            list<Profile> profiles = new list<Profile>([Select Id,Name from Profile where Name = 'Grantee Admin' or Name = 'Applicant']);
            for(Profile p: profiles){
                pMap.put(p.Name,p.Id);
            }
            for(Id i:newMap.keyset()){
                if(oldMap==null && (newMap.get(i).profileId == pMap.get('Grantee Admin') || newMap.get(i).profileId == pMap.get('Applicant'))){
                    uIds.add(i);
                }               
                if(oldMap!=null && newMap.get(i).ProfileId != null && oldMap.get(i).ProfileId!=null &&
                   newMap.get(i).profileId != oldMap.get(i).profileId && 
                   (newMap.get(i).profileId == pMap.get('Grantee Admin') || newMap.get(i).profileId == pMap.get('Applicant'))){
                    uIds.add(i);
                }
            }
            
            if(uIds.size()>0){
                shareRecords(uIds);
            }
    }
    
    
    
    @future
    public static void shareRecords(list<Id> usrIds){
         
        
        try{
            
            list<User> users = new list<User>([Select Id,Name,ProfileId,AccountId from User where id in :usrIds]);
            list<Prime_Application__Share> pshares = new list<Prime_Application__Share>();
            list<Application3__Share> appshares = new list<Application3__Share>();  
            list<Location__Share> locshares = new list<Location__Share>();
            list<Award__Share> awshares = new list<Award__Share>();  
            list<Award_Reporting__Share> awrshares = new list<Award_Reporting__Share>();                    
            set<Id> orgIds = new set<Id>();                     
            set<Id> awIds = new set<Id>();
            list<Prime_Application__c> primeApps = new list<Prime_Application__c>();       
            
            // Share prime applications
            primeApps = [Select Id,CNCS_Status__c from Prime_Application__c where CNCS_Status__c != 'In Progress'];         
            if(users.size()>0){
                for(User u: users){                         
                    for(Prime_Application__c p: primeApps){                            
                         Prime_Application__Share pShare = new Prime_Application__Share();
                         pShare.ParentId = p.Id;
                         pShare.userorgroupId = u.Id;
                         pShare.AccessLevel = 'Read';
                         pshares.add(pShare);                                                       
                     }              
                }
            }
            
            
            // Share Applications    
            if(users.size()>0){       
                for(User u: users){
                    if(u.AccountId!=null){
                        orgIds.add(u.AccountId);                    
                    }
                }
            }
            list<Application3__c> apps = new list<Application3__c>([Select Id,Organization__c,(Select Id,Application__r.Organization__c from Locations__r),(Select Id, 
                                                                    Application_ID__r.Organization__c,Grant_Status__c  From Award__r where Grant_Status__c = 'Awarded') from Application3__c where Organization__c in :orgIds]);
           
           
            if(users.size()>0 && apps.size()>0){
                for(Application3__c a: apps){
                    for(User u: users){
                        if(u.AccountId != null && a.Organization__c != null && u.AccountId == a.Organization__c){
                             Application3__Share aShare = new Application3__Share();
                             aShare.ParentId = a.Id;
                             aShare.userorgroupId = u.Id;
                             aShare.AccessLevel = 'Edit';
                             appShares.add(aShare);     
                             
                             if(a.Locations__r.size()>0){
                                 for(Location__c l: a.Locations__r){
                                     Location__Share lShare = new Location__Share();
                                     lShare.ParentId = l.Id;
                                     lShare.userorgroupId = u.Id;
                                     lShare.AccessLevel = 'Edit';
                                     locShares.add(lShare);    
                                 }  
                             }
                             if(a.Award__r.size()>0){
                                 for(Award__c aw: a.Award__r){
                                     awIds.add(aw.Id);
                                     Award__Share awShare = new Award__Share();
                                     awShare.ParentId = a.Id;
                                     awShare.userorgroupId = u.Id;
                                     awShare.AccessLevel = 'Read';
                                     awShares.add(awShare);   
                                 }                                      
                             }      
                        }
                    }
                }
                
                list<Award_Reporting__c> awReports = new list<Award_Reporting__c>([Select Id,Name,Org_Id__c,Award__r.Grant_Status__c from Award_Reporting__c where Award__c in :awIds]);
                if(awReports.size()>0){
                    for(Award_Reporting__c a: awReports){
                        for(User u: users){
                            if(u.AccountId == a.Org_Id__c){
                                Award_Reporting__Share awrShare = new Award_Reporting__Share();
                                awrShare.ParentId = a.Id;
                                awrShare.userorgroupId = u.Id;
                                awrShare.AccessLevel = 'Edit';
                                awrShares.add(awrShare);      
                            }
                        }
                    }
                }
                
                
                
                if(pShares!=null && pShares.size()>0){
                    insert pShares;
                }   
                
                if(appShares!=null && appShares.size()>0){
                    insert appShares;
                }      
                
                if(locShares!=null && locShares.size()>0){
                    insert locShares;
                }
                
                if(awShares!=null && awShares.size()>0){
                    insert awShares;
                }   
                
                if(awrShares!=null && awrShares.size()>0){
                    insert awrShares;
                }  
            }
        }
        catch(Exception e){
            system.debug('exception = '+e);
        }
    
        
    
    }
    
    
}