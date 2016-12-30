/********************************************************************************************
Class Name: ApplicationEditpageExt
Description: An apex controller for ApplicationEditpage.
             Displaying NofatoApplicationUI page section based on Checkboxes in NOFA Setup and after edit/Reopen the application detials page 

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:Coomment
**********************************************************************************************/





Public Class ApplicationEditpageExt{

    public Application3__c applicationInput {get; set;}
    public Boolean displayMsg{get;set;}
    public String id;
    Public NOFA__c Nofa{get;set;}
   //public ComponentData TargetPopulations {get;set;}
    public Boolean isContinuingApp {get;set;}
    public string selectedRound{get;set;}

    public ApplicationEditpageExt getThis(){
     return this;
    }

    public ApplicationEditpageExt(ApexPages.StandardController controller){
          applicationInput=new Application3__c();
          displayMsg=False;
          id=Apexpages.currentPage().getParameters().get('id'); 
          String isContinuing = apexPages.currentPage().getParameters().get('isContinuingApp');
          isContinuingApp = false; 
          if(isContinuing == 'true')
             isContinuingApp = true;          
              
          If(id!=null && id!='')
             applicationInput=[Select id,NOFA_RFP__r.Name,Amendable__c,Withdraw_Justification__c,Flag_for_ApplicationReturntoRework__c,Legacy_App_ID__c,Application_Feedback_Summary__c,Former_SPR_Code__c, Opt_in_to_the_National_Service_Registry__c,Addendum_to__c, SPR_Code__c, If_Yes_Please_Explain_Applicant_Deliquen__c ,If_Yes_Please_Explain_EO_12372__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,Other_Area_Affected_by_Project__c,Project_Director__c,Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Cost_Effectiveness_Budget_Adequacy__c,If_other_please_specify_Infrastructure__c,
                              Infrastructure_Improvement__c,Other_Narrative__c,If_other_please_specify_Enivronment__c,Environmental_Stewardship_Conservation__c,Organizational_Capability__c,
                              If_other_please_specify_Energy__c,Energy_Conservation__c,Focus_Area__c,Otherobjectives__c,Natural_and_Other_Disasters__c,If_other_please_specify_capacity__c ,
                              If_other_please_specify_education__c ,If_other_please_specify_disaster__c,Program_Design__c ,Cost_Share__c,Need__c,VISTA_Assignment__c ,Characteristics_Priorities__c,
                              Program_Type__c,If_other_please_specify_Economic__c,AmeriCorps_logo_will_display_on_website__c,Economic_Opportunities__c,Number_of_elevator_speeches_created__c,
                              Capacity_Building__c,Number_of_members_wearing_logo_every_day__c,If_other_please_specify_Health__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,
                              Environmental_Stewardship__c,Disaster_Services__c,If_other_please_specify_Veterns__c,Education__c,Veterans_Military_Families__c,Strengthening_Communities__c,Number_of_ongoing_volunteers__c,
                              Number_of_episodic_volunteers_generated__c,Other_Revenue__c,Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,Have_funding_history_with_any_CNCS_org__c,EO_12372_Process__c,
                              Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Disaster_Type__c,How_many_teams_are_being_requested__c,/*Select_a_round__c,*/Proposed_End_Date_is__c,
                              Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Assignee__c,Authorized_Representative__c,Point_of_Contact__c,Grantee_Status__c,Organization__c,Summary_of_Accomplishments__c ,
                              Intermediary_Justification__c ,Leadership_and_Team__c ,NOFA_RFP__r.Proposed_Dates__c,Comments__c,

                              NOFA_RFP__r.Natural_and_Other_Disasters_App__c,NOFA_RFP__r.Energy_Conservation_App__c,NOFA_RFP__r.Environmental_Stewardship_Conservati_App__c,
                              Executive_Summary__c ,Target_Populations1__c,If_other_please_specify_Urban__c,Urban_and_Rural_Development__c,Organizational_Capacity__c, Cost_Effectiveness_and_Budget_Adequacy__c ,Clarification_Summary__c ,Continuation_Changes__c ,
                              Amendment_Justification__c,Strengthen_Communities__c ,Evaluation_Summary_or_Plan__c,Recruitment_and_Development__c  ,
                              Program_Management__c ,NOFA_RFP__r.id,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                              State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                              Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                              Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,rank__c,
                              Proposed_End_Date__c,Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,NOFA_RFP__r.Required__c,NOFA_RFP__r.Organization_Docs__c,NOFA_RFP__r.Review_Cycle__c,City__c,
                              Application_Signed__c,Certifications_Clicked__c,Assurances_Clicked__c,Round__c,NOFA_RFP__r.NCCC_Partner__c,NOFA_RFP__r.NCCC_Traditional__c,NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c,NOFA_RFP__r.NCCC_All__c,Could_contracted_labor_be_used_App_Setup__c,Funds_available_for_contracted_labor_App__c,
                              Will_the_project_replace_staff_App__c,Additional_background_checks_App__c,Possible_hazardous_waste_exposre_App_Sec__c,Possible_work_with_hazardous_chemicl_App__c,Possible_health_restrictions_App__c,Project_permissions_permits_secured_App__c,Number_of_ongoing_volunteers_App__c,
                              Possible_hazardous_waste_exposure_App__c,Possible_work_with_hazardous_chemical_Ap__c,Possible_health_restrictions_Ap__c,
                              Project_permissions_permits_secured_Ap__c,How_many_teams_are_being_requested_App__c,Number_of_weeks_to_complete_project_App__c,Ability_to_sustain_project_s_outcomes_Ap__c,Could_inclement_weather_impact_plan_App__c,
                              Describe_additional_background_checks_Ap__c,NOFA_RFP__r.Application_Maximum_Characters__c,Level_of_evidence_for_project_model__c,Disaster_Type_App__c,
                              Partner_Project_Code_Application__c,Request_Priority_Application__c,Team_Mobility_Application__c,Disaster_Number_Application__c,Funding_Code_Application__c,Disaster_Type_Application__c,Sub_Application__c
                              
                              FROM Application3__c where id = :id]; 
           if(applicationInput.Round__c!=null){
            selectedRound = applicationInput.Round__c;
           }
    }
    
    
     
    
    
     
     
     
    public PageReference edit() {                                                //Edit button logic 
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);
            update applicationInput;
            return Redirect;
        }       
        return null;
    }

    List<Profile> profile = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String UserProfile = profile[0].Name;

    public PageReference SaveAsDraft(){
         PageReference Redirect;      
         try{ 
             String charCountCheckMsg = charCountCheckForSave();
             if(charCountCheckMsg!=null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,charCountCheckMsg));
                return null;
             }
             if(applicationInput.Application_Signed__c && (UserProfile == 'Applicant' || UserProfile == 'Grantee Admin')){
                applicationInput.Application_Signed__c = false;
                applicationInput.Authorized_Representative__c = null;
                applicationInput.Grantee_Status__c = 'In Progress';
                applicationInput.Certifications_Clicked__c = false;
                applicationInput.Assurances_Clicked__c = false;
             }                
             applicationInput.Round__c = selectedRound;
             if(applicationInput.NOFA_RFP__r.NCCC_Partner__c==true){
            if(applicationInput.Request_Priority_Application__c==null){
            applicationInput.Request_Priority_Application__c.addError('Enter Request Priority');
            }
            if(applicationInput.Team_Mobility_Application__c==null){
            applicationInput.Team_Mobility_Application__c.addError('Enter Team Mobility');    
            }
         }
             update applicationInput;
             Redirect = new PageReference('/'+applicationInput.id);
             
             return Redirect;
         }
         catch(DMLException e){
            System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
  
         return null;
         
    }

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
                    if(applicationInput.NOFA_RFP__r.Application_Maximum_Characters__c != null){                     
                            
                            Integer i = Integer.valueOf(applicationInput.NOFA_RFP__r.Application_Maximum_Characters__c);                        
                            Integer Difference = i - charCount;
                            if(Difference>=0){
                                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: '+Difference));
                            }else{
                                errorMsg = 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: 0';                         
                            }
                            return errorMsg;                        
                            
                            
                        
                    }
                    
            }  
            return null; 
    } 
    public pageReference charCountCheck(){ 
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
                    
                    if(applicationInput.NOFA_RFP__r.Application_Maximum_Characters__c != null){                     
                            
                            Integer i = Integer.valueOf(applicationInput.NOFA_RFP__r.Application_Maximum_Characters__c);                        
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
        if((applicationInput.Proposed_End_Date_is__c==null ||  applicationInput.Proposed_Start_Date_is__c==null) &&(applicationInput.NOFA_RFP__r.Proposed_Dates__c!=True)) 
        {
           applicationInput.Counties__c.addError('counties');
           applicationInput.Proposed_End_Date_is__c.addError('');
           applicationInput.Proposed_Start_Date_is__c.addError('');              
           return false;  
        }
 
        else
           return true;
    }
     
     
    public PageReference cancel(){
        PageReference pg; 
        system.debug('isContinuingApp = '+isContinuingApp);
        if(isContinuingApp){
            delete applicationInput;
            pg = new PageReference('/'+Apexpages.currentPage().getParameters().get('parentId'));
        }else{
            system.debug('got here 2');
            pg = new PageReference('/'+applicationInput.Id);  
        }               
        pg.setRedirect(true);
        return pg;
        
    }
    
    public List<Selectoption> roundList{
        set;
        get{
            if(applicationInput.Nofa_Rfp__c!=null){
                list<RFP_Class_year__c> rfpClassYrs = new list<RFP_Class_year__c>([Select Id,Name,Class_Year__c,NOFO_RFP__c from RFP_Class_year__c where NOFO_RFP__c = :applicationInput.NOFA_RFP__c]);
                set<Id> classYrIds = new set<Id>();
                for(RFP_Class_year__c r: rfpClassYrs){
                    if(r.Class_Year__c!=null){
                        classYrIds.add(r.Class_Year__c);
                    }
                }
                list<Round__c> rounds=new list<Round__c>([Select r.Round_Start_Date__c, r.Round_Number__c, r.Round_End_Date__c, r.RFP__c, r.Name, r.Id, r.Class__r.RFP__c,r.Class__c, r.Class_Number__c From Round__c r where Class__c in :classYrIds]);
                
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