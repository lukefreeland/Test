public without sharing class ApplicationHelper {
    public static void checkApplicationforSameYr(list<Application3__c> newApps){
        
        system.debug('checkApplicationforSameYr');
        set<Id> projectIds = new set<Id>();
        list<Application3__c> appToUpdate = new list<Application3__c>();
        set<Id> nofaIds = new set<Id>();
        list<Project__c> projects = new list<Project__c>();              
        Id appRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        Id cpRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
        map<Id,Project__c> pMap = new map<Id,Project__c>();
        system.debug('newApps= '+newApps);        
        for(Application3__c a: newApps){                
          if(a.Project__c != null && appRecordTypeId == a.RecordTypeId  && a.Type_of_Application__c == 'New'){
             projectIds.add(a.Project__c);
          }
          if(a.Project__c != null && cpRecordTypeId == a.RecordTypeId){
             projectIds.add(a.Project__c);
          }
        } 
        if(projectIds!=null && projectIds.size()>0){       
            projects = [Select p.Name, p.Id,p.Organization__c,Project_Title__c, (Select Id, Name,NOFA_RFP__c,Project_Title__c,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Fiscal_Yr__c,Project__c,RecordTypeId From Application__r) From Project__c p where Id in : projectIds];        
            
            for(Project__c p: projects){ 
                pMap.put(p.Id,p);                                  
                if(p.Application__r!=null && p.Application__r.size()>0){
                    for(Application3__c a: p.Application__r){
                      if(a.RecordTypeId == appRecordTypeId || a.RecordTypeId == cpRecordTypeId) {
                        nofaIds.add(a.NOFA_RFP__c);
                      }  
                    }
                    
                }
            }
            
            for(Application3__c newApp: newApps){
                newApp.Project_Title__c = pMap.get(newApp.Project__c).Project_Title__c;
                if(newApp.NOFA_RFP__c!=null){
                 nofaIds.add(newApp.NOFA_RFP__c);
                }
            }
            system.debug('nofaIds = '+nofaIds);
            if(nofaIds!=null && nofaIds.size()>0){
                Map<Id,Nofa__c> nofaFiscalYrs = new Map<Id,Nofa__c>([Select Id,Fiscal_Yr__c,Corporate_Program__r.Short_Code__c from NOFA__c where Id in :nofaIds]);   
          
              
           
                for(Project__c p: projects){                
                    for(Application3__c newApp: newApps){                                     
                        if(p.Application__r!=null && p.Application__r.size()>0){                            
                            for(Application3__c a: p.Application__r){                                   
                                if(a.RecordTypeId == appRecordTypeId || a.RecordTypeId == cpRecordTypeId){                                  
                                  if(a.RecordTypeId == newApp.RecordTypeId){                                                                  
                                    if(a.Project__c == newApp.Project__c && newApp.NOFA_RFP__c!=null && a.NOFA_RFP__c == newApp.NOFA_RFP__c && (a.NOFA_Fiscal_Yr__c != '' && a.Nofa_Fiscal_yr__c != null) && a.NOFA_Fiscal_Yr__c == nofaFiscalYrs.get(newApp.NOFA_RFP__c).Fiscal_Yr__c){                            
                                        newApp.adderror('A project can only be attached to a single application/concept paper in a fiscal year');                           
                                    }
                                  }
                                }
                             } 
                        
                        }
                             
                    
                    }
                }
            }
        }
        
        
    
        
        
    } 
      
    
    
    
    
    public static void shareApplicationsWithStateComission(list<Application3__c> newApps,map<Id,Application3__c> oldmap){
        //Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];       
        list<Application3__Share> appShares = new list<Application3__Share>();        
        list<AccountShare> accShares = new list<AccountShare>();
       
            set<Id> primeAppIds = new set<Id>();
            for(Application3__c a:newApps){
                
                if(a.Prime_Application__c!=null && oldmap != null && oldmap.get(a.Id).Grantee_Status__c == 'In Progress' && a.Grantee_Status__c != 'In Progress' ){
                    primeAppIds.add(a.Prime_Application__c);                    
                }
                if(a.Prime_Application__c!=null && oldmap == null && a.Grantee_Status__c != 'In Progress' ){
                    primeAppIds.add(a.Prime_Application__c);                    
                }
            
            }
            if(primeAppIds.size()>0){  
                Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];    
                if(userInfo.getProfileId()!=p.Id){
                 
                    Map<Id,Prime_Application__c> primeApps = new Map<Id,Prime_Application__c>([Select Id,createdById,Project_Name__r.Organization__c from Prime_Application__c where id in :primeAppids]);              
                    if(primeApps.size()>0){
                        for(Application3__c a:newApps){
                            if(a.Prime_Application__c!=null && primeApps.get(a.Prime_Application__c).createdById != userInfo.getUserId()){
                                Application3__Share aShare = new Application3__Share();
                                aShare.ParentId = a.Id;
                                aShare.userorgroupId = primeApps.get(a.Prime_Application__c).createdById;
                                aShare.AccessLevel = 'Edit';
                                appShares.add(aShare);
                                
                                /*AccountShare accShare = new AccountShare();
                                accShare.AccountId = a.Organization__c;
                                accShare.userorgroupId = primeApps.get(a.Prime_Application__c).createdById;
                                accShare.AccountAccessLevel = 'Read';
                                accShare.OpportunityAccessLevel = 'Read';
                                accShares.add(accShare);*/
                            }
                        }
                    }
                    if(appShares.size()>0){
                        insert appShares;
                    }
                
                }
            }
    }
    
    public static void shareSCIApplications(list<Application3__c> newApps){
        try{
            set<String> states = new set<String>();
            Id stateCommissionRTId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('State Commission').getRecordTypeId();
            Id stateOfficeRTId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('State Office').getRecordTypeId();
            Id intentToApplyRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Notification of Intent to Apply').getRecordTypeId();
            list<Application3__c> appsToShare = new list<Application3__c>();
            list<Application3__Share> appShares = new list<Application3__Share>();
            set<Id> conIds = new set<Id>();
            for(Application3__c a: newApps){
                if(a.SCI__c == 'Yes' && a.RecordTypeId != intentToApplyRTId){
                    if(a.State_and_or_Territories__c != null){
                        String[] tmpString = a.State_and_or_Territories__c.split(';');
                        states.addall(tmpString);
                        appsToShare.add(a);                     
                    }
                }
            }
            system.debug('states = '+states);
            if(states.size()>0){
                list<Account> accounts = new list<Account>([Select (Select Id, LastName, FirstName, Name,AccountId From Contacts) From Account where States__c in :states and (recordTypeId = :stateCommissionRTId or 
                                                                        recordTypeId = :stateOfficeRTId)]);
                system.debug('accounts = '+accounts);                                                                     
                if(accounts.size()>0){
                    for(Account a: accounts){
                         if(a.Contacts.size()>0){
                            for(Contact c: a.Contacts){                              
                               conIds.add(c.id);                                                    
                            }
                         }                         
                    }                    
                }
                system.debug('conIds = '+conIds);
                list<State_Commission_Input__c> scis = new list<State_Commission_Input__c>();
                if(conIds.size()>0){
                    /*for(Application3__c a: appsToShare){
                         State_Commission_Input__c sci = new State_Commission_Input__c();
                         sci.Application_ID__c = a.Id;
                         scis.add(sci);
                    }*/
                    list<User> users = new list<User>([Select isActive,State__c,Id,FirstName,LastName,Name,userRoleId,Email,ContactId from User where ContactId in :conIds]);
                    map<Id,Application3__c> UserIdtoApp = new map<Id,Application3__c>();
                    map<Id,String> UserIdtoAppName = new map<Id,String>();
                    for(User u: users){                     
                        if(u.IsActive == true){
                            for(Application3__c a: appsToShare){                                
                                if(a.State_and_or_Territories__c.contains(u.State__c)){
                                    Application3__Share aShare = new Application3__Share();
                                    aShare.ParentId = a.Id; 
                                    aShare.userorgroupId = u.Id;
                                    aShare.AccessLevel = 'Read';
                                    appShares.add(aShare);   
                                    
                                    UserIdtoApp.put(u.Id,a);        
                                    String appName = a.NOFA_Fiscal_Yr__c.substring(2,4)+a.Corp_Program_Short_Code__c + a.AutoNumber1__c;
                                    UserIdtoAppName.put(u.Id,appName);                                                                 
                                }
                            }
                        }
                    }
                    if(appShares.size()>0){
                        insert appShares;
                    }
                    /*map<Id,Id> sciMap = new map<Id,Id>();
                    if(scis.size()>0){
                        insert scis;
                        for(State_Commission_Input__c sci: scis){
                            sciMap.put(sci.Application_ID__c,sci.Id);
                        }
                    }
                    list<String> addressesToSend = new list<String>();  */
                    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
                    for(User u:users){
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                        list<String> addressesToSend = new list<String>();     
                        addressesToSend.add(u.Email);                                    
                                
                        String subject = 'Please Enter State Commission Input for the Application';        
                        String body = 'Dear '+u.FirstName+' '+u.LastName+'<br/> <br/>';
                        body += 'Please Enter the State Input for the Application: '+UserIdtoAppName.get(u.Id)+'<br/> <br/>';
                        body += 'The link to State Commission Input: <a href="'+URL.getSalesforceBaseUrl().toExternalForm()+'/statecommission/ApplicationForSCInput?id='+UserIdtoApp.get(u.Id).Id+'&retUrl=%/statecommission/ApplicationForSCInput?id="'+UserIdtoApp.get(u.Id).Id+'>Click here </a> <br/> <br/>';           
                        body += 'Thanks <br/> <br/>';
                        body += 'CNCS';             
                        email.setSubject( subject );
                        email.setToAddresses(addressesToSend);
                        email.setHtmlBody(body);
                        mails.add(email);
                        
                    }                   
                                                                                     
                    Messaging.sendEmail(mails);
                    
                }
                
               
                
                
            }
        }
        catch(Exception e){
            system.debug('exception = '+e);
        }
    }
    
    public static void shareApplications(list<Application3__c> newApps){
        //Profile p = [Select Id,Name from Profile where Name = 'System Administrator'];
        //if(userInfo.getProfileId()!=p.Id){
            set<Id> orgIds = new set<Id>();         
            set<Id> conIds = new set<Id>();
            map<Id,Application3__c> accIdtoAppId = new map<Id,Application3__c>();
            map<Id,Id> conNametoAccId = new map<Id,Id>();
            list<Application3__Share> appShares = new list<Application3__Share>();
            for(Application3__c a: newApps){
                if(a.Organization__c != null){
                    orgIds.add(a.Organization__c);
                    accIdtoAppId.put(a.Organization__c,a);
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
                          if(u.isActive && u.Id!=userInfo.getUserId() && accIdtoAppId.get(conNametoAccId.get(u.ContactId))!= null && accIdtoAppId.get(conNametoAccId.get(u.ContactId)).OwnerId != u.Id){                               
                            Application3__Share aShare = new Application3__Share();
                            aShare.ParentId = accIdtoAppId.get(conNametoAccId.get(u.ContactId)).Id;
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
        //}
    }
    
    public static void populateBudgetMatchRequired(list<Application3__c> apps){
        list<Application3__c> appsToUpdate = new list<Application3__c>();
        for(Application3__c app: apps){         
            system.debug('app.Type_of_Application__c = '+app.Type_of_Application__c);
            system.debug('app.Budget_Match_Required__c = '+app.Budget_Match_Required__c );
            if(app.Type_of_Application__c == 'New' || app.Type_of_Application__c == 'Continuation'){                
                if(app.Budget_Match_Required__c == null){
                    system.debug('app.Budget_Match_Schedule_1__c = '+app.Budget_Match_Schedule_1__c);
                    system.debug('app.Budget_Match_Schedule_2__c = '+app.Budget_Match_Schedule_2__c);
                    system.debug('app.Budget_Match_Schedule_3__c = '+app.Budget_Match_Schedule_3__c);
                    if(app.Budget_Match_Schedule_1__c != null){
                        app.Budget_Match_Required__c = app.Budget_Match_Schedule_1__c;
                    }
                    if(app.Budget_Match_Schedule_2__c != null){
                        app.Budget_Match_Required__c = app.Budget_Match_Schedule_2__c;
                    }
                    if(app.Budget_Match_Schedule_3__c != null){
                        app.Budget_Match_Required__c = app.Budget_Match_Schedule_3__c;
                    }
                }               
            }
        }       
    }
}