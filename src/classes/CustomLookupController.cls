public with sharing class CustomLookupController {
    
 
  public List<Application3__c> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  public Id parentId{get;set;}
  static public string sObjType;
  public list<sObject> sobjResults{get;set;}
  public string sObj{get;set;}
  public List<NOFA__c> nofas{get;set;}
  public List<Region__c> campuses{get;set;}
  
  public CustomLookupController() {
    
    // get the current search string
    searchString = System.currentPageReference().getParameters().get('lksrch');
    parentId = System.currentPageReference().getParameters().get('parentId');
    system.debug('ParentId = '+parentId);    
    runSearch();  
  }
   
  // performs the keyword search
  public PageReference search() {
    runSearch();
    return null;
  }
  
  // prepare the query and issue the search command
  private void runSearch() {
    // TODO prepare query string for complex serarches & prevent injections
    system.debug('searchString = '+searchString);
    sobjResults = new list<sObject>();
    sobjResults = performSearch(searchString);  
    if(sObjResults.getSObjectType() == Application3__c.sObjectType){
        results = (list<Application3__c>)(sObjResults);
    }else if(sObjResults.getSObjectType() == NOFA__c.sObjectType){
        nofas = (list<NOFA__c>)(sObjResults);
    }else if(sObjResults.getSObjectType() == Region__c.sObjectType){
        campuses = (list<Region__c>)(sObjResults);
    }
    system.debug('sObjResults = '+sObjResults);  
  } 
  
  // run the search and return the records found. 
  private List<sObject> performSearch(string searchString) {
    
    try{
    
    String soql = 'select id, name '; 
    String soql1 = 'select id, name '; 
    string t1='\'';
    string t2= '\'';
    Id recTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
    Id recTypeId1 = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
    profile scProfile = [Select Id,Name from Profile where Name = 'State Commission Profile'];
    set<String> statusofApp = new Set<String>{'Submitted','Submitted to CNCS'};

  
    soql = soql + ', Nofa_RFP__c, Organization__c, Grantee_Status__c, Status__c, Submitted_By__c from Application3__c where (Grantee_Status__c in :statusofApp or status__c in :statusofApp) ';      
  
    if(parentId != null){
      sObjType = parentId.getsObjectType().getDescribe().getName();
      system.debug('ParentId in search = '+parentId);
      
      system.debug('got here = '+sObjType);
      sobj = sObjType;
      if(sObjType == 'Paneling__c'){        
        
        set<Id> nofaIds = new set<Id>();
        Paneling__c parent = [Select Id, Name, Stage_Number__r.NOFA_Group__r.Id from Paneling__c where Id = :parentId];
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
          system.debug('size = '+nofaIds.size());
          if(nofaIds.size()>0)
          {
             if(nfGrp.Review_of__c == 'Applications')
             { 
                    system.debug('soql = '+soql);
                    soql = soql +  ' and NOFA_RFP__c in : nofaIds and recordTypeId = '+t1+recTypeId+t2;
                    //  soql1 = soql1 +  ' and NOFA_RFP__c in : nofaIds';
                    if(searchString != '' && searchString != null)
                    {
                        soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
                    }
             }
             else if(nfGrp.Review_of__c == 'Concept papers')
             {  
                   soql = soql +  ' and NOFA_RFP__c in : nofaIds and recordTypeId = '+t1+recTypeId1+t2;                                                             
                   if(searchString != '' && searchString != null)
                   {
                      soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
                   }
             } 
           }else if(nofaIds.size()==0){
                if(searchString != '' && searchString != null)
                {
                    soql = soql +  ' and name LIKE \'%' + searchString +'%\'';
                }
           }
           return database.query(soql); 
        }
      }else if(sObjType == 'Application3__c'){
        Application3__c parentapp = [Select Id,Name,Nofa_RFP__r.CNCS_Corporate_Program__c,Nofa_RFP__c from Application3__c where Id = :parentId];           
        soql = 'Select Id,Name,NOFA_Type__c,CNCS_Corporate_Program__c,  NOFA_Active_Inactive__c from NOFA__c where CNCS_Corporate_Program__c = '+t1+parentApp.Nofa_RFP__r.CNCS_Corporate_Program__c+t2+' and NOFA_Active_Inactive__c = true and (NOFA_Type__c = '+t1+'New & Continuation'+t2+' or NOFA_Type__c = '+t1+'Continuation'+t2+')';      
        if(userInfo.getProfileId()==scProfile.Id){
            soql = 'Select Id,Name,NOFA_Type__c,CNCS_Corporate_Program__c,Allow_Prime_Applicants_and_Sub_Applicant__c,  NOFA_Active_Inactive__c from NOFA__c where Allow_Prime_Applicants_and_Sub_Applicant__c = '+t1+'Yes'+t2+' CNCS_Corporate_Program__c = '+t1+parentApp.Nofa_RFP__r.CNCS_Corporate_Program__c+t2+' and NOFA_Active_Inactive__c = true and (NOFA_Type__c = '+t1+'New & Continuation'+t2+' or NOFA_Type__c = '+t1+'Continuation'+t2+')';      
        
        }
        return database.query(soql);
      }else if(sObjType == 'NOFA_Group__c'){
        system.debug('got here in stages loop');
        set<Id> nofaIds = new set<Id>();
        //Stages__c stage = [Select Id, Name, NOFA_Group__c from Stages__c where Id = :parentId];
        NOFA_Group__c nfGrp = [Select n.Name, n.Id,Review_of__c, (Select Id, NOFA__c From NOFA_Member__r) From NOFA_Group__c n where Id = :parentId];
        if(nfgrp != null && nfGrp.NOFA_Member__r != null)
        {
            for(NOFA_Member__c nm: nfGrp.NOFA_Member__r)
            {
                nofaIds.add(nm.Nofa__c);
            }
        }
        list<RFP_Class_year__c> rfpClassYrs = [Select Id,Name,Class_Year__c from RFP_Class_year__c where NOFO_RFP__c in :nofaIds];
        set<Id> clsYrIds = new set<Id>();
        for(RFP_Class_year__c cy: rfpClassYrs){
            clsYrIds.add(cy.Class_Year__c);
        }
        list<Class__c> clsYrs = [Select Id,Name,Region__c from Class__c where Id in :clsYrIds];
        set<Id> campusIds = new set<Id>();
        for(Class__c clsYr: clsYrs){
            campusIds.add(clsYr.Region__c);
        }
        soql = 'Select Id, Name, Region_Assigned_States_Territories__c, Region__r.Name from Region__c where Id in : campusIds';
        return database.query(soql); 
      }        
    }
    
    if(parentId == null && (searchString != '' && searchString != null)){
       soql = soql +  ' name LIKE \'%' + searchString +'%\'';
    }
    soql = soql + ' limit 100';   
    System.debug(soql);
    return database.query(soql); 
    
    }catch(Exception e){
    	system.debug('e '+e);
    	return null;
    }

  }
  
    
  // used by the visualforce page to send the link to the right dom element
  public string getFormTag() {
    return System.currentPageReference().getParameters().get('frm');
  }
    
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBox() {
    return System.currentPageReference().getParameters().get('txt');
  }
 
}