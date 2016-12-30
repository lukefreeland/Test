public without sharing class PrimeApplicationHelper {
    public static void shareRecordsWithGrantees(list<Prime_Application__c> primeApps){
        list<Prime_Application__c> primeAppsToShare = new list<Prime_Application__c>();
        for(Prime_Application__c p: primeApps){
            if(p.CNCS_Status__c == 'Accepting Sub-Applications'){
                primeAppsToShare.add(p);
            }
        }
        if(primeAppsToShare.size()>0){
            list<Profile> profiles = new list<Profile>([Select Id,Name from Profile where Name = 'System Administrator' or Name = 'Grantee Admin' or Name = 'Applicant']);
            map<String,Id> pMap = new map<String,Id>();
            for(Profile p: profiles){
                pMap.put(p.Name,p.Id);
            }
            
                list<User> users = new list<User>([Select Id,Name,userRoleId from User where isActive = true and (ProfileId = :pMap.get('Grantee Admin') or ProfileId = :pMap.get('Applicant'))]);
                
                if(users.size()>0){
                    list<Prime_Application__Share> pshares = new list<Prime_Application__Share>();
                    for(Prime_Application__c p: primeAppsToShare){
                        if(p.CNCS_Status__c == 'Accepting Sub-Applications'){
                            for(User u: users){
                                Prime_Application__Share pShare = new Prime_Application__Share();
                                pShare.ParentId = p.Id;
                                pShare.userorgroupId = u.Id;
                                pShare.AccessLevel = 'Read';
                                pShares.add(pShare);
                            }
                        }
                    }
                    system.debug('pshares = '+pshares);
                    if(pShares.size()>0){
                        insert pShares;
                    }
                }
            
        }  
        
    }
    
    public static void shareRecords(list<Prime_Application__c> newPrimeApps){
        
            set<String> orgIds = new set<String>();         
            set<Id> conIds = new set<Id>();
            map<Id,Prime_Application__c> accIdtoPrimeAppId = new map<Id,Prime_Application__c>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Prime_Application__Share> appShares = new list<Prime_Application__Share>();
            for(Prime_Application__c a: newPrimeApps){
                if(a.Org_Id__c != null){
                    orgIds.add(a.Org_Id__c);
                    accIdtoPrimeAppId.put(a.Org_Id__c,a);
                }   
            }
            if(orgIds.size()>0){
                list<Account> accs = new list<Account>([Select (Select Id, LastName, FirstName, Name,AccountId From Contacts) From Account a where Id in :orgIds]);
                if(accs.size()>0){
                    for(Account a: accs){
                        if(a.Contacts.size()>0){
                            for(Contact c: a.Contacts){                              
                                conIds.add(c.id);                           
                                conNametoAccId.put(c.Id,c.AccountId);
                            }
                        }
                    }
                }
                if(conIds.size()>0){
                    set<Id> roleIds = new set<Id>();
                    list<User> users = new list<User>([Select isActive,Id,FirstName,LastName,Name,userRoleId,ContactId from User where ContactId in :conIds]);
                    if(users.size()>0){
                        for(User u: users){ 
                          if(u.isActive && u.Id!=userInfo.getUserId() && accIdtoPrimeAppId.get(conNametoAccId.get(u.ContactId))!= null && accIdtoPrimeAppId.get(conNametoAccId.get(u.ContactId)).OwnerId != u.Id){                               
                            Prime_Application__Share aShare = new Prime_Application__Share();
                            aShare.ParentId = accIdtoPrimeAppId.get(conNametoAccId.get(u.ContactId)).Id;
                            aShare.userorgroupId = u.Id;
                            aShare.AccessLevel = 'Edit';
                            appShares.add(aShare);
                          }                         
                        }
                    }                   
                }
                if(appshares.size()>0){
                    insert appshares;
                }
                
                
            }      
    }
    
    public static void updateFormulaSubAppsToAwarded(map<Id,Prime_Application__c> oldRecs, map<Id,Prime_Application__c> newRecs){
        Id appRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();        
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).CNCS_Status__c!=newRecs.get(i).CNCS_Status__c && newRecs.get(i).CNCS_Status__c == 'Awarded' && newRecs.get(i).Competitive_or_Formula__c == 'Formula' ){
                primeAppIds.add(i);
            }
        }
        system.debug('primeAppIds = '+primeAppIds);
        if(primeAppIds.size()>0){
            list<Application3__c> formulasubApps = new list<Application3__c>([Select Id,Status__c, Grantee_Status__c from Application3__c where Prime_Application__c in :primeAppIds and RecordTypeId = :appRTId]);
            system.debug('formulaSubApps = '+FormulaSubApps);
            if(formulasubApps.size()>0){
                for(Application3__c a: formulasubApps){
                    //a.Grantee_Status__c = 'Awarded'
                    a.Status__c = 'Awarded';
                }
                update formulasubApps; 
            }       
        }
    }
    
    public static void updateSubAppsToAccepted(map<Id,Prime_Application__c> oldRecs, map<Id,Prime_Application__c> newRecs){
        Id appRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        set<Id> primeAppIds = new set<Id>();        
        for(Id i: newRecs.keyset()){
            if(oldRecs.get(i).CNCS_Status__c!=newRecs.get(i).CNCS_Status__c && newRecs.get(i).CNCS_Status__c == 'Accepted' ){
                primeAppIds.add(i);
            }
        }
        system.debug('primeAppIds = '+primeAppIds);
        if(primeAppIds.size()>0){
            list<Application3__c> subApps = new list<Application3__c>([Select Id,Status__c, Grantee_Status__c from Application3__c where Prime_Application__c in :primeAppIds and RecordTypeId = :appRTId and Status__c = 'Pending Prime Award Approval']);            
            if(subApps.size()>0){
                for(Application3__c a: subApps){
                    //a.Grantee_Status__c = 'Awarded'
                    a.Status__c = 'Accepted';
                }
                update subApps; 
            }       
        }
    }
    
    public static void populateProgramDates(map<Id,Prime_Application__c> oldmap,map<Id,Prime_Application__c> newmap){
        set<Id> primeAppIds = new set<Id>();
        Id appRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        for(Id i: newmap.keyset()){
            if(oldmap.get(i).CNCS_Status__c!=newmap.get(i).CNCS_Status__c && newmap.get(i).CNCS_Status__c == 'Closed to Sub-Applicants' ){
                primeAppIds.add(i);
            }
        }
        Map<Id,Date> earliestDateMap = new Map<Id,Date>();
        Map<Id,Date> latestDateMap = new Map<Id,Date>();
        if(primeAppIds.size()>0){
            AggregateResult[] aggrResult = [Select Prime_Application__c,Min(Proposed_Start_Date__c) minD1,Max(Proposed_End_date__c) maxD1 From Application3__c where Prime_Application__c in :primeAppIds group by Prime_Application__c];
            
            for(AggregateResult a:aggrResult){
                
                system.debug('prime Id = '+a.get('Prime_Application__c'));
                Id i = (Id)a.get('Prime_Application__c');               
                if(newmap.get(i)!=null){
                    Prime_Application__c tmpPrm = newmap.get(i);
                    tmpPrm.Program_Start_Date__c = (Date)a.get('minD1');
                    tmpPrm.Program_End_Date__c = (Date)a.get('maxD1');
                }               
            }                   
        }
    }
    
    public static void populateCorpProg(list<Prime_Application__c> primeApps){
    /******** code for populating project title *********************/
       set<id> projectid = new set<id>();
     map<string,string> projectTitlemap = new map<string,string>();
        for(Prime_Application__c p: primeApps) {
        projectid.add(P.Project_Name__c);
        }
        for(Project__c proj : [select id,name,project_title__c from project__c where id in: projectid]) {
         projectTitlemap.put(proj.id,proj.project_title__c);
         }
        for(Prime_Application__c p: primeApps){
        if(projectTitlemap.containskey(p.project_Name__c)){
        p.Title__c = projectTitlemap.get(p.project_Name__c);
        }
  } 
    /****************end of code ********************************************/
        set<Id> nofaIds = new set<Id>();
        for(Prime_Application__c p: primeApps){
            if(p.NOFO_RFP__c!=null && p.CNCS_Corporate_Program__c == null){
                nofaIds.add(p.NOFO_RFP__c);
            }
        }
        if(nofaIds.size()>0){
            map<Id,NOFA__c> nofamap = new map<Id,NOFA__c>([Select Id,CNCS_Corporate_Program__c from NOFA__c where Id in :nofaIds]);
            for(Prime_Application__c p: primeApps){
                p.CNCS_Corporate_Program__c = nofaMap.get(p.NOFO_RFP__c).CNCS_Corporate_Program__c;
            }           
        }
    }
  
        
    /* public static void projectTitleUpdate(list<Prime_Application__c> primeApps){
     
     set<id> projectid = new set<id>();
     map<string,string> projectTitlemap = new map<string,string>();
        for(Prime_Application__c p: primeApps) {
        projectid.add(P.Project_Name__c);
        }
        for(Project__c proj : [select id,name,project_title__c from project__c where id in: projectid]) {
         projectTitlemap.put(proj.id,proj.project_title__c);
         }
          for(Prime_Application__c p: primeApps){
        if(projectTitlemap.containskey(p.project_Name__c)){ 
        p.Title__c = projectTitlemap.get(p.project_Name__c);
        }   
        }
       
     } */
    
}