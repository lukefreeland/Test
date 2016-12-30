/********************************************************************************************
Class Name: NOFAtoApplicationUIExt
Description: An apex controller that supports Nofa set up and configuration.
             Rendering NofatoApplicationUI page section based on Checkboxes in NOFA Setup

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:To populate organization filed form organization
**********************************************************************************************/

public with sharing  class NOFAtoApplicationUIExt 
{
    Public Application3__c applicationInput{get;set;}
    Public Id tempid;
    Public String rectype{get;set;}
   // Public String rectypename{get;set;}
    public boolean isDraft{get;set;}
    public String id;
    public Boolean displayMsg{get;set;}
    Public Project__c pro{get;set;}
    Public NOFA__c Nofa{get;set;}
   // Public String proj;
  //  Public Project__c pro{get;set;}
   // public list<selectOption> availableList {get;set;}     
    public list<selectOption> chosenList {get;set;}
    public boolean isLate{get;set;}
    public string selectedRound{get;set;}
    
    public NOFAtoApplicationUIExt getThis(){
        return this;
    }
    
    public NOFAtoApplicationUIExt (ApexPages.StandardController controller) 
    {
            isDraft = false;
            isLate = false;
            applicationInput= new Application3__c();
            applicationInput.Type_of_Application__c = 'New';
            displayMsg=False;
            chosenList =  new list<SelectOption>();
            tempid=controller.getRecord().id;
            id=Apexpages.currentPage().getParameters().get('id');
            String projectid = Apexpages.currentPage().getParameters().get('projectid'); 
            String lateSubmission = Apexpages.currentPage().getParameters().get('submittedLate'); 
            if(lateSubmission!=null && lateSubmission == 'Yes'){
                isLate = true;
                applicationInput.Submitted_Late__c = true;               
            }
            String primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId'); 
            if(primeApplicationId!=null){
                applicationInput.Prime_Application__c = primeApplicationId;
            }
                
            // proj=Apexpages.currentPage().getParameters().get('proj');
            If(projectid!=null) 
                applicationInput.Project__c=projectid;
               //  System.debug('testing'+pro.Project_Director__c);
          pro=[select id,name,Project__c.Project_Director__c,Organization__c,Project_Start_Date__c,Project_End_Date__c,Project_Site_URL__c from Project__c where id=:projectid];
            System.debug('testing'+pro.Project_Director__c);
           applicationInput.Project_Directorss__c=pro.Project_Director__c;
           applicationInput.Proposed_Start_Date__c = pro.Project_Start_Date__c;
           applicationInput.Proposed_End_Date__c = pro.Project_End_Date__c;
           applicationInput.Project_Directorss__c=pro.Project_Director__c;
           applicationInput.Project_website_urls__c=pro.Project_Site_URL__c;
            applicationInput.Applicant_User__c = Userinfo.getUserId();
            applicationInput.Grantee_Status__c='In Progress';
            applicationInput.Status__c='In Progress';
            
            User loggedinUser = [Select name,isPortalEnabled,contactid,contact.AccountId from user where id=:userinfo.getUserId()];
              // if(loggedinUser.isPortalEnabled)
            applicationInput.Organization__c = pro.Organization__c;
          
          
            
            If(id!=null && id!='')
                 Nofa=[Select Id,NOFA_name__c,Natural_and_Other_Disasters_App__c,Energy_Conservation_App__c,Environmental_Stewardship_Conservati_App__c,Infrastructure_Improvement_App__c,CNCS_Corporate_Program__r.Module__c,SC_Other__c,NCCC_Other__c,Other_other_section__c,Focus_Areas_and_Objectives_AP__c,Economic_Opportunities_AP__c,Education_AP__c,Veterans_Military_Families_AP__c,Capacity_Building_AP__c,Disaster_Services_AP__c,
                 Required__c,Organization_Docs__c,Environmental_Stewardship_AP__c,Healthy_Futures_AP__c,Standard__c,Safety_and_Security_AP__c,Tools_and_Equipment_AP__c,S_N__c,SIF__c,VISTA__c,Characteristics_and_Priorities__c,
                 Organization__c,NOFA_Type__c,Proposed_Dates__c,Target_Populations__c,NCCC_Dates_and_Questions__c,NCC_for_Focus_Areas_and_Objectives__c,Other_for_Focus_Areas_and_Objectives__c,Intermediary_Justification__c,Need__c,
                 Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,Leadership_and_Team__c,Cost_Effectiveness_and_Budget_Adequacy__c,Organizational_Capability__c,
                 Executive_Summary__c,Other__c,Amendment_Justification__c,Strengthening_Communities__c,Recruitment_and_Development__c,Foster_Grandparents_Only__c,Evaluation_Summary_of_Plan__c,Standard_424__c,Program_Design__c,
                 Program_Management__c,RSVP_Only__c,Review_Cycle__c,Urban_and_Rural_Development_App__c,NCCC_Traditional__c,NCCC_Traditional_Disaster_Response__c,NCCC_All__c,NCCC_Partner__c,Application_Maximum_Characters__c from NOFA__c where id=:id];
            System.debug('Valueofid'+id+'$$$$$'+Nofa.Foster_Grandparents_Only__c);  
            rectype=[Select id,name from Recordtype where SObjectType='Application3__c' and name='Application'].id;     
          // pro=[select id,name,Project_Director__c from Project__c where id=:id];
     applicationInput.Module__c=nofa.CNCS_Corporate_Program__r.Module__c;
  }
   
   Public PageReference SaveAsDraft(){                              //Save as draft - Overide the required field 
         PageReference Redirect;
     
         try{
         applicationInput.recordtypeid=rectype;
         applicationInput.NOFA_RFP__c=id;
         applicationInput.Grantee_Status__c='In Progress';
         applicationInput.Round__c = selectedRound;
         String charCountCheckMsg = charCountCheckForSave();
         if(charCountCheckMsg!=null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,charCountCheckMsg));
            return null;
         }
        /* if(nofa.NCCC_Partner__c=true){
            if(applicationInput.Request_Priority_Application__c==null||applicationInput.Request_Priority_Application__c==''){
                system.debug('got here ');
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a Value in Request Priority field in NCCC Application Section'));
                applicationInput.Request_Priority_Application__c.addError('Enter Request Priority');                
                return null;
            }
            if(applicationInput.Team_Mobility_Application__c==null||applicationInput.Team_Mobility_Application__c==''){
                applicationInput.Team_Mobility_Application__c.addError('Enter Team Mobility'); 
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a Value in Team Mobility field in NCCC Application Section')); 
                return null;   
            }
         } */
             insert applicationInput;
             Redirect = new PageReference('/'+applicationInput.id);
             
             return Redirect;
            }
         Catch(DMLException e){
          System.debug('@@@@@@@@!!!!!'+e.getmessage());
        }
  
        return null;
         
       }
        public pagereference createProject(){                                    //Project lookup from project object 
         return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
          }      
   
   /*public PageReference save1(){
         //boolean checkAllRequiredDocs = true;  
         map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
       //  applicationInput.Grantee_Status__c='Submitted';
        // applicationInput.Status__c='Submitted';
         string RequiredDocs;
         PageReference Redirect;
         try{
    if(!Validate())
  return null;
       
                                  
              
              checkRequiredNarrativeFields = ApplicationCheck.checkNarrativeFields(applicationInput,Nofa.Id);
              if(checkRequiredNarrativeFields.size()>0){
                    string fieldNames = '';
                    for(String fieldName: checkRequiredNarrativeFields.keyset()){
                      fieldNames += fieldName +', ';
                    }
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application----- cannot be Submitted, Due to the following reason: Please enter values for Required fields: '+fieldNames));                    
                    return null;
              } 
              RequiredDocs = checkRequiredDocsAttached();
              //system.debug('check = '+checkAllRequiredDocs);
        
             if(RequiredDocs != null  && RequiredDocs != ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Required Document not attached to Application: '+RequiredDocs));
                return null;
             }
             
             if(Nofa.Review_Cycle__c == 'Rolling'){
                applicationInput.Grantee_Status__c = 'Submitted';
                applicationInput.Status__c = 'Submitted';
              }
              else if(Nofa.Review_Cycle__c == 'Post-Deadline'){
                applicationInput.Grantee_Status__c = 'Pre - Submitted';
                applicationInput.Status__c = 'Pre - Submitted';
              }
              
             applicationInput.recordtypeid=rectype;
             applicationInput.NOFA_RFP__c=id;
             Insert applicationInput;
             
              //add attachments to organization when app is submitted      
             if(applicationInput.NOFA_RFP__r.Organization_Docs__c!=null){
                ApplicationCheck.attachOrgDocs(applicationInput, Nofa.Organization_Docs__c);
             }
              
             Redirect = new PageReference('/'+applicationInput.id);
             return Redirect;
         }
         Catch(DMLException e){
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         }*/
  
    public String charCountCheckForSave(){
        
        
         if(applicationInput.Organizational_Capability__c!=null || applicationInput.Program_Design__c != null || applicationInput.Program_Management__c != null || applicationInput.Cost_Effectiveness_Budget_Adequacy__c != null ||
                applicationInput.Recruitment_and_Development__c != null || applicationInput.Evaluation_Summary_or_Plan__c != null && applicationInput.Strengthen_Communities__c != null ||
                applicationInput.Other_Narrative__c != null || applicationInput.Intermediary_Justification__c != null || applicationInput.Tools_and_Equipment__c != null || applicationInput.Need__c != null || applicationInput.Safety_and_Security__c != null){               
                    
                    Integer oc = String.isNotBlank(applicationInput.Organizational_Capability__c)?applicationInput.Organizational_Capability__c.length():0;
                    Integer pd = String.isNotBlank(applicationInput.Program_Design__c)?applicationInput.Program_Design__c.length():0;
                    Integer pm = String.isNotBlank(applicationInput.Program_Management__c)?applicationInput.Program_Management__c.length():0;
                    Integer ce = String.isNotBlank(applicationInput.Cost_Effectiveness_Budget_Adequacy__c)?applicationInput.Cost_Effectiveness_Budget_Adequacy__c.length():0;
                    Integer rd = String.isNotBlank(applicationInput.Recruitment_and_Development__c)?applicationInput.Recruitment_and_Development__c.length():0;
                    Integer es = String.isNotBlank(applicationInput.Evaluation_Summary_or_Plan__c)?applicationInput.Evaluation_Summary_or_Plan__c.length():0;
                    Integer sc = String.isNotBlank(applicationInput.Strengthen_Communities__c)?applicationInput.Strengthen_Communities__c.length():0;
                    Integer oNar = String.isNotBlank(applicationInput.Other_Narrative__c)?applicationInput.Other_Narrative__c.length():0;
                    Integer ij = String.isNotBlank(applicationInput.Intermediary_Justification__c)?applicationInput.Intermediary_Justification__c.length():0;
                    Integer te = String.isNotBlank(applicationInput.Tools_and_Equipment__c)?applicationInput.Tools_and_Equipment__c.length():0;
                    Integer ne = String.isNotBlank(applicationInput.Need__c)?applicationInput.Need__c.length():0;
                    Integer ss = String.isNotBlank(applicationInput.Safety_and_Security__c)?applicationInput.Safety_and_Security__c.length():0;
                    
                    Integer charCount = oc + pd + pm + ce + rd + es + sc + oNar + ij + te + ne + ss ; 
                    String errorMsg;                    
                    system.debug('charCount = '+charCount);
                    system.debug('Nofa.Application_Maximum_Characters__c = '+Nofa.Application_Maximum_Characters__c);
                    if(Nofa.Application_Maximum_Characters__c != null){
                            system.debug('Nofa.Application_Maximum_Characters__c = '+Nofa.Application_Maximum_Characters__c);
                            Integer i = Integer.valueOf(Nofa.Application_Maximum_Characters__c);                        
                            Integer Difference = i - charCount;
                            if(Difference>=0){
                                //errorMsg = 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: '+Difference;
                            }else{
                                errorMsg = 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: 0';                         
                            }
                            return errorMsg;                        
                    }
           }
           
           return null;
    
        
    }
    public PageReference charCountCheck(){
        
         if(applicationInput.Organizational_Capability__c!=null || applicationInput.Program_Design__c != null || applicationInput.Program_Management__c != null || applicationInput.Cost_Effectiveness_Budget_Adequacy__c != null ||
                applicationInput.Recruitment_and_Development__c != null || applicationInput.Evaluation_Summary_or_Plan__c != null && applicationInput.Strengthen_Communities__c != null ||
                applicationInput.Other_Narrative__c != null || applicationInput.Intermediary_Justification__c != null || applicationInput.Tools_and_Equipment__c != null || applicationInput.Need__c != null || applicationInput.Safety_and_Security__c != null){               
                    
                    Integer oc = String.isNotBlank(applicationInput.Organizational_Capability__c)?applicationInput.Organizational_Capability__c.length():0;
                    Integer pd = String.isNotBlank(applicationInput.Program_Design__c)?applicationInput.Program_Design__c.length():0;
                    Integer pm = String.isNotBlank(applicationInput.Program_Management__c)?applicationInput.Program_Management__c.length():0;
                    Integer ce = String.isNotBlank(applicationInput.Cost_Effectiveness_Budget_Adequacy__c)?applicationInput.Cost_Effectiveness_Budget_Adequacy__c.length():0;
                    Integer rd = String.isNotBlank(applicationInput.Recruitment_and_Development__c)?applicationInput.Recruitment_and_Development__c.length():0;
                    Integer es = String.isNotBlank(applicationInput.Evaluation_Summary_or_Plan__c)?applicationInput.Evaluation_Summary_or_Plan__c.length():0;
                    Integer sc = String.isNotBlank(applicationInput.Strengthen_Communities__c)?applicationInput.Strengthen_Communities__c.length():0;
                    Integer oNar = String.isNotBlank(applicationInput.Other_Narrative__c)?applicationInput.Other_Narrative__c.length():0;
                    Integer ij = String.isNotBlank(applicationInput.Intermediary_Justification__c)?applicationInput.Intermediary_Justification__c.length():0;
                    Integer te = String.isNotBlank(applicationInput.Tools_and_Equipment__c)?applicationInput.Tools_and_Equipment__c.length():0;
                    Integer ne = String.isNotBlank(applicationInput.Need__c)?applicationInput.Need__c.length():0;
                    Integer ss = String.isNotBlank(applicationInput.Safety_and_Security__c)?applicationInput.Safety_and_Security__c.length():0;
                    
                    Integer charCount = oc + pd + pm + ce + rd + es + sc + oNar + ij + te + ne + ss ; 
                                        
                    system.debug('charCount = '+charCount);
                    system.debug('Nofa.Application_Maximum_Characters__c = '+Nofa.Application_Maximum_Characters__c);
                    if(Nofa.Application_Maximum_Characters__c != null){
                            system.debug('Nofa.Application_Maximum_Characters__c = '+Nofa.Application_Maximum_Characters__c);
                            Integer i = Integer.valueOf(Nofa.Application_Maximum_Characters__c);                        
                            Integer Difference = i - charCount;
                            if(Difference>=0){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: '+Difference));
                            }else{
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: 0'));                         
                            }
                            return null;                        
                    }
           }
           
           return null;
    }  
    
    public boolean Validate()                                                                               //Required filed method for save as draft
     {
    if((((applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && (applicationInput.Request_Priority_Application__c==null ||applicationInput.Team_Mobility_Application__c==null)) || applicationInput.Authorized_Representative__c==null || applicationInput.Proposed_End_Date_is__c==null ||applicationInput.Proposed_Start_Date_is__c==null) &&(Nofa.Proposed_Dates__c!=True))||(applicationInput.Proposed_Start_Date__c==null || applicationInput.Proposed_End_Date__c==null)||((applicationInput.Number_of_members_wearing_logo_every_day__c==null||applicationInput.Number_of_ongoing_volunteers__c==null|| applicationInput.AmeriCorps_logo_will_display_on_website__c  == null || applicationInput.Other_Revenue__c==null ||applicationInput.Number_of_elevator_speeches_created__c==null || applicationInput.Number_of_episodic_volunteers_generated__c==null || applicationInput.Total_Match_Dollars__c==null ||applicationInput.Private_Match__c==null ||applicationInput.Local_State_Federal_Government_Match__c==null) && Nofa.S_N__c )||((applicationInput.How_many_teams_are_being_requested__c==null || applicationInput.Primary_State_of_Service_Activities__c==null || /*applicationInput.Select_a_round__c==null ||*/ applicationInput.Specify_if_you_want_to_be_in_more_rounds__c==null) && Nofa.NCCC_Dates_and_Questions__c)||((applicationInput.Counties__c==null||applicationinput.State_and_or_Territories__c==null||applicationInput.Other_Area_Affected_by_Project__c==null)&& Nofa.Standard__c)) 
         {
        // applicationInput.Counties__c.addError('Counties');
           applicationInput.Request_Priority_Application__c.addError('Enter Request Priority');
           applicationInput.Team_Mobility_Application__c.addError('Enter Team Mobility');
           applicationInput.Authorized_Representative__c.addError('Authorized Representative');
           applicationInput.Proposed_Start_Date__c.addError('Proposed Start Date');
           applicationInput.Proposed_End_Date__c.addError('Proposed End daate');
           applicationInput.Proposed_End_Date_is__c.addError('');
           applicationInput.Proposed_Start_Date_is__c.addError('Proposed Start Date is');
           applicationInput.AmeriCorps_logo_will_display_on_website__c.addError('');
           applicationInput.Number_of_elevator_speeches_created__c.addError('No of Elevator Speeches');
           applicationInput.Number_of_episodic_volunteers_generated__c.addError('No of Eposodic Volunteers Generated');
           applicationInput.Total_Match_Dollars__c.addError('Total Match Dolloars');
           applicationInput.Private_Match__c.addError('Private Match');
           applicationInput.Local_State_Federal_Government_Match__c.addError('Local State Federal Governmnet Match');
            applicationInput.Other_Revenue__c.addError('Other Revenue');
             applicationInput.Number_of_ongoing_volunteers__c.addError('No of ongoin Volunteers');
          applicationInput.Number_of_members_wearing_logo_every_day__c.addError('No of Members wearing logo evry day');
           applicationInput.Counties__c.addError('Country');
     applicationInput.State_and_or_Territories__c.addError('State and Territories');
      applicationInput.Other_Area_Affected_by_Project__c.addError('Other Area affected by project');
      applicationInput.How_many_teams_are_being_requested__c.addError('How many team are being requested');
       applicationInput.Primary_State_of_Service_Activities__c.addError('Primary State Service Activities');
        //applicationInput.Select_a_round__c.addError('Select A Round');
         applicationInput.Specify_if_you_want_to_be_in_more_rounds__c.addError('Specify if you want to be in more rounds');
   return false;
    }
    else
    return true;
    }
      /*public String checkRequiredDocsAttached(){                                                                   //Attachment 
        
        boolean check = true; 
        string requiredDocs = '';
        String s;
        string allAttachmentTypes='';
    
        if(Nofa.Required__c !=null){
            system.debug('boolean in !=null = '+check);
        
            s = Nofa.Required__c;
            list<String> docTypes = s.split(';');
        
            system.debug('app Id = '+applicationInput.Id);
            list<Attachment__c> attachments = new list<Attachment__c>();
            if(applicationInput.Id!=null)
                 attachments = new list<Attachment__c>([Select Id,Type__c from Attachment__c where Application__c = :applicationInput.Id]);
            
            if(attachments.size()>0){           
                for(Attachment__c a: attachments){              
                    if(a.Type__c!=null)
                    {   
                        allAttachmentTypes += a.Type__c+';';                    
                    }                   
                }
                system.debug('allAttachmentTypes '+allAttachmentTypes);
            }else{
                check = false;
            }
            
            system.debug('docTypes ='+docTypes);
            for(String dType: docTypes){
                if(allAttachmentTypes!=null){
                    if(allAttachmentTypes.Contains(dType)){
                        check = true;
                    }else{
                        check = false;    
                        requiredDocs += dType + ', ';                
                    }
                }else{
                    check = false; 
                }
            }
        }
    
         return requiredDocs;
     } */
     
     public List<Selectoption> roundList{
        set;
        get{
            system.debug('got here in round list');
            if(Nofa!=null){
                list<RFP_Class_year__c> rfpClassYrs = new list<RFP_Class_year__c>([Select Id,Name,Class_Year__c,NOFO_RFP__c from RFP_Class_year__c where NOFO_RFP__c = :Nofa.Id]);
                set<Id> classYrIds = new set<Id>();
                for(RFP_Class_year__c r: rfpClassYrs){
                    if(r.Class_Year__c!=null){
                        classYrIds.add(r.Class_Year__c);
                    }
                }
                list<Round__c> rounds=new list<Round__c>([Select r.Round_Start_Date__c, r.Round_Number__c, r.Round_End_Date__c, r.RFP__c, r.Name, r.Id, r.Class__r.RFP__c,r.Class__c, r.Class_Number__c From Round__c r where Class__c in :classYrIds]);
                system.debug('rounds= '+rounds);
                roundList = new list<SelectOption>();
                roundList.add(new Selectoption('','--None--'));
                for(Round__c r:rounds){
                    if(r.Round_Start_Date__c!=null && r.Round_End_Date__c!=null){                   
                        string startDate = String.valueOf(r.Round_Start_Date__c);
                        string endDate = String.valueOf(r.Round_End_Date__c);
                        roundList.add(new Selectoption(r.Id,r.Name+' '+r.Round_Number__c+' '+startDate+' '+endDate));
                    }
                }
            }
            return roundList;
        }
    }

 }