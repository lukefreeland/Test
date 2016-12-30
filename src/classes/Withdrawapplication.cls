/********************************************************************************************
Class Name: Withdrawapplication
Description: An apex controller for ApplicationDetailpage.
             Displaying NofatoApplicationUI page section based on Checkboxes in NOFA Setup

**********************************************************************************************
Modified By:Prashant 
Modified On:8/10/2015
Purpose:Coomment
**********************************************************************************************/


Public Class Withdrawapplication{

    public Withdrawapplication() {
        appliInput  = new Application3__c();
    }

    public Application3__c applicationInput {get; set;}
    public string userpwd {get;set;}
    public Application3__c appliInput {get; set;}
    //public Application3__c a{get;set;}
    public String id;
    public List<Location__c> locList;
    public List<Application3__c> RectypeId;
    public string Withdrawapp {get;set;}
    public list<Attachment__c> documents{get;set;}
    public String childobjecttypes;
    public boolean RecAwardsView{get;set;}
    public boolean complianceSection{get;set;} 
    public boolean isNonCompliant{get;set;}
    public boolean flagforapp{get;set;}
    public string recordid{get;set;}
    
    public string authrepname {get;set;}
    public boolean terms_conditions {get;set;}
    Public boolean showCancel{get;set;} //added
    public String strNofoId{get;set;}
    public String strNofoBdgFrms{get;set;}
    public boolean displayPopup {get; set;} 
    public Boolean RecAwards {get;set;}
    public Boolean flagMembersSection {get;set;}
    public GroupMember gm {get;set;}
    Public Boolean showPOButton{get;set;}
    Public Boolean showSPOButton{get;set;}
    Public Boolean showGOButton{get;set;}
    Public Boolean showXOButton{get;set;}
    Public Boolean showSGOButton{get;set;}
    
    public Withdrawapplication(ApexPages.StandardController controller){
    try{
               showCancel=False;
               
               applicationInput=new Application3__c(); 
               applicationInput = (Application3__c)controller.getRecord();
               id=Apexpages.currentPage().getParameters().get('id');
               
                try{
                    if(!Test.isRunningTest()){
                        User u = [Select Id,Name,AccountId from User where Id = :userInfo.getUserId()];
                        userpwd  = [select Encryptpassword__c from contact where email =: userinfo.getuseremail() and AccountId = :u.AccountId limit 1].Encryptpassword__c;
                        system.debug('password = '+userpwd);
                    }
                }
                catch (exception e){
                
                }
               If(id!=null && id!='')
                          applicationInput= [Select id,Project_Title__c,Waitlist_Justification__c,Flag_for_ApplicationReturntoRework__c,flagReturnForRework__c,Application__c,Module__c,Application_ID__c,Project_Directors__c,Program_Officers__c,Program_Officer__r.name,
                          Grants_Officer__r.name,NOFO_Record_Type__c,Senior_Grants_Officer__r.name,Executive_Officer__r.name, Sub_Application__c, recordtype.name,NOFA_RFP__r.Other_NCCC_CP__c,
                          Withdraw_Justification__c,NOFA_RFP__r.Standard_CP__c,City__c,Legacy_App_ID__c, Project_Directorss__c,Subject_to_FAPIIS_Review__c ,Date_FAPIIS_Review__c,
                          Mitigating_Circumstances__c,FAPIIS_Review_Comments__c,Information_available_FAPIIS_Review__c,Satisfactory_Record_Executing_Programs__c,
                          Demonstrates_Ethics_Integrity__c,Corporate_Program__c,Application_Feedback_Summary__c,Energy_Efficiency_CP__c, Other_Energy_Efficiency_CP__c, 
                          If_Yes_Please_Explain_Applicant_Deliquen__c , Opt_in_to_the_National_Service_Registry__c,If_Yes_Please_Explain_EO_12372__c ,Former_SPR_Code__c,
                          Addendum_to__c, SPR_Code__c,Project_Priority__c, Disaster_Number_Funding_DOE__c, Partner_Project_Code__c, Team_Mobility__c, Campus__c,
                          Primary_State_of_Service_Activities__c,Approved_Amount__c,Executive_Officer__c,Grants_Officer__c,Senior_Grants_Officer__c,Year_of_Grant__c,
                          Program_Officer__c,Tools_and_Equipment__c,Safety_and_Security__c,Other_Area_Affected_by_Project__c,Comments__c,
                          Cost_Effectiveness_Budget_Adequacy__c,If_other_please_specify_capacity__c,Other_Narrative__c,Name,If_other_please_specify_disaster__c,
                          Other_Application_Organization__c,Target_Populations1__c,NOFA_RFP_Summary__c,Focus_Area__c,If_other_please_specify_education__c,RecordTypeid,
                          Education__c,Characteristics_Priorities__c,Cost_Share__c,If_other_please_specify_Economic__c,Economic_Opportunities__c,If_other_please_specify_Health__c,
                          Capacity_Building__c,Healthy_Futures__c,If_other_please_specify_Enivironment_Ste__c,Environmental_Stewardship__c,Disaster_Services__c,
                          If_other_please_specify_Veterns__c,Veterans_Military_Families__c, AmeriCorps_logo_will_display_on_website__c,Number_of_elevator_speeches_created__c,
                          Number_of_members_wearing_logo_every_day__c,Other_Revenue__c,Number_of_ongoing_volunteers__c,Number_of_episodic_volunteers_generated__c,
                          Total_Match_Dollars__c,Private_Match__c,Local_State_Federal_Government_Match__c,EO_12372_Process__c,Authorized_Representative__c,Point_of_Contact__c,
                          Counties__c,State_and_or_Territories__c,Specify_if_you_want_to_be_in_more_rounds__c,Round__c,Round_Start_date__c,Round_End_Date__c,Disaster_Type__c,
                          How_many_teams_are_being_requested__c,Proposed_End_Date_is__c,Proposed_Start_Date_is__c,Project_website_urls__c,Applicant_User__c,Organization__c,
                          Assignee__c,Grantee_Status__c,Have_funding_history_with_any_CNCS_org__c,How_many_teams_are_being_requested_CP__c, 
                          Number_of_teams_to_complete_this_proj_CP__c,Specify_if_you_want_to_be_in_more_rou_CP__c,Education_CP__c,Other_Education_CP__c ,
                          Veterans_and_Military_Families_CP__c,Disaster_Services_CP__c,Infrastructure_Improvement__c,If_other_please_specify_Enivronment__c,
                          Healthy_Futures_CP__c,Environment_Stewardship_CP__c,Capacity_Building_CP__c,Economic_Opportunities_CP__c,Target_Populations_CP__c,Need1__c,
                          Program_Design__c ,Organizational_Capacity__c ,Strengthen_Communities__c,Evaluation_Summary_or_Plan__c ,Program_Management__c,
                          Intermediary_Justification__c,Need__c,Clarification_Summary__c,Continuation_Changes__c,VISTA_Assignment__c,Summary_of_Accomplishments__c,
                          Leadership_and_Team__c,Organizational_Capability__c,Executive_Summary__c,Other__c,Amendment_Justification__c,
                          Strengthening_Communities__c,Recruitment_and_Development__c,NOFA_RFP__c,Date_Received__c,Status__c,Type_of_Submission__c,Type_of_Application__c,
                          State_Application_Identifier__c,Option__c,Applicant_Delinquent_on_any_Federal_Debt__c,Additional_Information__c,If_Yes_provide_your_explination_here__c,
                          Review_by_State_Under_Executive_Order__c,Date_Received_by_State__c,Prefix__c,Organizational_Affiliation__c,First_Name__c,Title__c,Middle_Name__c,
                          Telephone_Number__c,Last_Name__c,Email__c,Suffix__c,Project__c,Areas_Affected_by_Project_Cities_Coutn__c,Proposed_Start_Date__c,Proposed_End_Date__c,
                          Documents_RSVP_Only__c,of_Unduplicated_Volunteers__c,Documents_Foster_Grandparents_Only__c,Other_Veterans_and_Military_Families_CP__c,
                          If_other_please_specify_Infrastructure__c,Program_Type__c,If_other_please_specify_Energy__c,Environmental_Stewardship_Conservation__c,
                          Otherobjectives__c,Energy_Conservation__c,Natural_and_Other_Disasters__c,Other_Disaster_Services_CP__c,Other_Healthy_Futures_CP__c,
                          Other_Environment_Stewardship_CP__c,Other_Capacity_Building_CP__c,Other_Economic_Opportunities_CP__c,Natural_and_Other_Disasters_CP__c,
                          Other_Natural_and_Other_Disasters_CP__c,Other_Environmental_Steward_Conserv_CP__c,Environmental_Stewardship_Conservation_C__c,Energy_Conservation_CP__c,
                          Other_Energy_Conservation_CP__c,Infrastructure_Improvement_CP__c,Urban_and_Rural_Development_CP__c,NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,
                          Amendable__c,Other_Infrastructure_Improvement_CP__c,Reject_Comments__c,Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development__c,
                          If_other_please_specify_Urban__c,NOFA_RFP__r.Required__c, NOFA_RFP__r.Organization_Docs__c,Submitted_By__c,NOFA_RFP__r.Review_Cycle__c,Submitted_Late__c,
                          Late_Submission_Justification__c,Senior_Program_Officer__c,Program_Office_Director__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,
                          Total_Recommended_MSYs__c,Issue_Area__c,Staff_Decision_Comments__c,Red_Flag_Count__c,Red_Flags__c,CreatedById,NOFA_RFP__r.CNCS_Corporate_Program__r.Name,
                          Organization__r.DUNS__C,Prime_Application__r.Project_Director__c,Prime_Application__r.CreatedBy.Email,Prime_Application__c,
                          Compliance_Determination__c,Staff_Comments__c,Response_TS__c,Compliance_Flag__c,Staff_Verified_TS__c,Response_TypeofOrg__c,Compliance_Flag_TypeofOrg__c,
                          Staff_Verified_TypeofOrg__c,Response_CoA__c,Compliance_Flag_CoA__c,Staff_Verified_CoA__c,Response_Notification__c,Compliance_Flag_Notification__c,
                          Staff_Verified_Notification__c,Response_OC__c,Compliance_Flag_OC__c,Staff_Verified_OC__c,Response_AA__c,Compliance_Flag_AA__c,Staff_Verified_AA__c,
                          Response_Atleast_80_funds__c,Compliance_Flag_Atleast_80_funds__c,Staff_Verified_Atleast_80_funds__c,Response_Match_Met__c,Compliance_Flag_Match_Met__c,
                          Staff_Verified_Match_Met__c,Nofa_Rfp__r.Compliance_Standard_Questions__c,Nofa_Rfp__r.Notice_of_Intent_to_Apply_Submitted__c,
                          Nofa_Rfp__r.Type_of_Organization__c,Nofa_Rfp__r.Award_Amount__c,Nofa_Rfp__r.At_least_80_of_funds__c,Nofa_rfp__r.Compliance_Review_Required__c,
                          Organization__r.O__c,Organization__r.Organization_Type__c,Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c,Nofa_Rfp__r.Eligible_Org_Types__c,
                          Nofa_Rfp__r.Eligible_Org_Characteristics__c,Nofa_Rfp__r.Lower_Threshold__c,Nofa_Rfp__r.Upper_threshold__c,Re_Examination__c, 
                          Non_Compliance_Re_Examination__c,Applicant_User__r.Email,Organization__r.Name,Project_Number__c,DUNS__c,Nofa_Rfp__r.Match_Met__c,Nofa_Rfp__r.Timely_Submission__c,rank__c,
                          Nofa_Rfp__r.Organization_Characteristics__c ,NOFA_RFP__r.Performance_Measures__c,NOFA_RFP__r.Standard_Information__c,NOFA_RFP__r.EIN_Information__c,
                          NOFA_RFP__r.Site_Date_Information__c,NOFA_RFP__r.Site_Type__c,NOFA_RFP__r.Additional_Operating_Site_Information__c,
                          NOFA_RFP__r.Volunteer_Information__c,NOFA_RFP__r.Focus_Area_and_Objectives_Location__c,NOFA_RFP__r.School_Information__c,
                          NOFA_RFP__r.ConfiguredBudgetForms__c,Parent_Application__c , Competitive_or_Formula_new__c,
                          NOFA_RFP__r.Site_Type_and_Summer_Associates__c,NOFA_RFP__r.Lodging_Information__c,Prime_Application__r.Competitive_or_Formula__c,
                          Prime_Application__r.CNCS_Status__c, Application_Signed__c,NOFA_RFP__r.Cash_Grants_Awards__c,Assurances_Clicked__c, Certifications_Clicked__c,Other_Target_Populations_CP__c, NOFA_RFP__r.State_Commission_Input_Application__c,NOFA_RFP__r.State_Commission_Input_Concept_Paper__c,NOFA_RFP__r.NCCC_All__c,NOFA_RFP__r.NCCC_All_Concept_Paper__c,NOFA_RFP__r.NCCC_Traditional__c,NOFA_RFP__r.NCCC_Traditional_Concept_paper__c,
                          NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c,NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c,Could_contracted_labor_be_used_Concept__c,Funds_available_for_contracted_labor_Con__c,
                          Will_the_project_replace_staff_Concept__c,Could_inclement_weather_impact_plan_Con__c,Additional_background_checks_Concept__c,Describe_additional_background_checks_co__c,Possible_hazardous_waste_exposure_concep__c,
                          Possible_work_with_hazardous_chemicl_Con__c,Possible_health_restrictions_Concept__c,Project_permissions_permits_secured_Con__c,Number_of_episodic_volunteers_Concept__c,Possible_hazardous_waste_exposure_Con__c,
                          Possible_work_with_hazardous_chemicl_Co__c,Possible_health_restrictions_Con__c,Project_permissions_permits_secured_Co__c,How_many_teams_are_being_requested_Con__c,Number_of_weeks_to_complete_project_Con__c,
                          Ability_to_sustain_project_s_outcomes_Co__c,Could_contracted_labor_be_used_App_Setup__c,Funds_available_for_contracted_labor_App__c,Will_the_project_replace_staff_App__c,Could_inclement_weather_impact_plan_App__c,Additional_background_checks_App__c,Describe_additional_background_checks_Ap__c,Possible_hazardous_waste_exposre_App_Sec__c,Possible_work_with_hazardous_chemicl_App__c,Possible_health_restrictions_App__c,Project_permissions_permits_secured_App__c,
                          Number_of_ongoing_volunteers_App__c,Possible_hazardous_waste_exposure_App__c,Possible_work_with_hazardous_chemical_Ap__c,Possible_health_restrictions_Ap__c,Project_permissions_permits_secured_Ap__c,Ability_to_sustain_project_s_outcomes_Ap__c,
                          NOFA_RFP__r.NOFA_Type__c,Submitted_to_Prime_Applicant__c,How_many_teams_are_being_requested_App__c,Level_of_evidence_for_project_model__c,Level_of_evidence_for_project_model_cp__c,Disaster_Type_Con_Paper__c,Disaster_Type_App__c,Number_of_weeks_to_complete_project_App__c,
                          Parent_Application_Match_Year__c ,Match_Year_Field_2_App__c,Disaster_Type_CP__c,Project__r.Project_State__c,Partner_Project_Code_Application__c,Request_Priority_Application__c,Team_Mobility_Application__c,Disaster_Number_Application__c,Funding_Code_Application__c,Disaster_Type_Application__c,
                          Partner_Project_Code_ConceptPaper__c,Request_Priority_ConceptPaper__c,Team_Mobility_ConceptPaper__c,Disaster_Number_ConceptPaper__c,Funding_Code_ConceptPaper__c,Disaster_Type_ConceptPaper__c,NOFA_RFP__r.NCCC_Partner_Concept_paper__c,NOFA_RFP__r.NCCC_Partner__c

                          FROM Application3__c where id = :id]; 
            
               System.debug('***applicationInput***'+applicationInput.NOFA_RFP__r.Performance_Measures__c);        
               RecAwardsView =false;
               complianceSection = false;
               isNonCompliant = false;
               flagMembersSection=isRequiredTotalRecommendedMSYs(id);
               
               if(applicationInput!=null ){
                   strNofoId=(applicationInput!=null && applicationInput.NOFA_RFP__c!=null)?(applicationInput.NOFA_RFP__c):'';
                   strNofoBdgFrms=(applicationInput!=null && applicationInput.NOFA_RFP__c!=null && applicationInput.NOFA_RFP__r.ConfiguredBudgetForms__c!=null ) 
                                                           ? (applicationInput.NOFA_RFP__r.ConfiguredBudgetForms__c) :'';
               } 
    }
    catch(Exception exc){
        System.debug('***withDrawApp constructor ***'+exc);

    }   
   }

// code added for visibility of buttons to profiles --sowmya 11/29/2016
  Public void initMethod(){
  
  List<String> grouplist = new List<String>{'PO Group','GO Group','SPO Group','XO Group','SGO Group'};
  List<GroupMember> gmlist=[Select Id, UserOrGroupId, group.name From GroupMember where group.name IN: grouplist];
  showPOButton=False;
  showSPOButton=False;
  Set<String> POGroupUserlist = new Set<String>();
  Set<String> SPOGroupUserlist = new Set<String>();
  Set<String> GOGroupUserlist = new Set<String>();
  Set<String> XOGroupUserlist = new Set<String>();
  Set<String> SGOGroupUserlist = new Set<String>();
  String loggedinUserId = Userinfo.getuserid();
  
  for(groupmember gm:gmlist)
  {
    if(gm.group.name == 'PO Group')
       POGroupUserlist.add(gm.UserOrGroupid);
    if(gm.group.name == 'SPO Group')
       SPOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name == 'GO Group')  
       GOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='XO Group')
       XOGroupUserlist.add(gm.UserOrGroupid);  
    if(gm.group.name=='SGO Group')
       SGOGroupUserlist.add(gm.UserOrGroupid);  
      }   
 
  If(POGroupUserlist.contains(loggedinUserId))
  showPOButton=True;
  system.debug('####123');
  If(SPOGroupUserlist.contains(loggedinUserId))
  showSPOButton=True;
  
   If(GOGroupUserlist.contains(loggedinUserId))
   showGOButton=True;
   
    If(XOGroupUserlist.contains(loggedinUserId))
   showXOButton=True;
   
    If(SGOGroupUserlist.contains(loggedinUserId))
   showSGOButton=True;
  }
 // end of code -- sowmya  11/29/2016 
    public PageReference reopen1() {   
        PageReference Redirect;
        try{
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
        applicationInput.Grantee_Status__c='None';
        update applicationInput;
        return Redirect;
        }
        }catch(Exception exc){
           System.debug('***exc***'+exc);
        }
        return null;
    }
    
  
   // Logic for repopn button on Application detial page and status getting changed to 'None' and redirecting to application edot page
    public PageReference reopen() {                                  
        System.debug('Prashant#########'+Withdrawapp); 
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id+'/e?retURL=%2F'+id);
             applicationInput.Grantee_Status__c='In Progress';
             applicationInput.Status__c='In Progress';
            update applicationInput;
            return Redirect;
        }

        return null;
    }

    // Logic for repopn button on Application detial page and status getting changed to 'None'
    public PageReference reopenIntent() {                            
       System.debug('Prashant#########'+Withdrawapp);
       applicationInput.Status__c = 'None';
       PageReference Redirect;
       If(id!=null && id!=''){
         Redirect = new PageReference('/apex/NotificationEditpage?id='+applicationInput.id);
         update applicationInput;
         return Redirect;
       }
       return null;
    }

    public PageReference withdraw(){  
        PageReference Redirect; 
        try{
            system.debug('Prashant&&&&&&&&&&&&&&&');
            applicationInput.Status__c = 'Withdrawn';
            applicationInput.Grantee_Status__c = 'Withdrawn';
            applicationInput.Withdraw_Justification__c = Withdrawapp;
            System.debug('applicationInput.Withdraw_Justification__c'+applicationInput.Withdraw_Justification__c);
            Redirect = new PageReference('/_ui/core/email/author/EmailAuthor?&template_id=00Xr0000000QJDY&p2_lkid='+applicationinput.Email__c+'&p3_lkid='+applicationInput.id);
            update applicationInput;
            Redirect = new PageReference('/'+id);
        }
        catch(Exception exc){
            system.debug('exc'+exc);
        }
        return Redirect;
    }


    // Approved for Award - 10.2.15. KY - Modified 12/7/15
    public PageReference ApprovedforAward(){  
    try{
        system.debug('&&&&*******prashant'+applicationInput.Demonstrates_Ethics_Integrity__c+'@@@@@@@@^^^^^pra'+applicationInput.Satisfactory_Record_Executing_Programs__c+'$$$$$$$$$$)))))'+applicationInput.Demonstrates_Ethics_Integrity__c+'^^^^^^^^^'+applicationInput.FAPIIS_Review_Comments__c+'+++++++++'+applicationInput.Date_FAPIIS_Review__c);
        if((applicationInput.Information_available_FAPIIS_Review__c=='Yes' && applicationInput.Satisfactory_Record_Executing_Programs__c==null)
                    ||(applicationInput.Information_available_FAPIIS_Review__c=='Yes' && applicationInput.Demonstrates_Ethics_Integrity__c==null)
                    || (applicationInput.Subject_to_FAPIIS_Review__c=='Yes' && applicationInput.Information_available_FAPIIS_Review__c==null)
                    ||(applicationInput.Subject_to_FAPIIS_Review__c=='Yes'&& applicationInput.Date_FAPIIS_Review__c==null) 
                    || (applicationInput.Demonstrates_Ethics_Integrity__c=='No' && applicationInput.Mitigating_Circumstances__c==null) 
                    || (applicationInput.Satisfactory_Record_Executing_Programs__c=='No' && applicationInput.FAPIIS_Review_Comments__c==null)){
                        system.debug('got here in approve for award');
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please Enter the Required Field in FAPIIS Review Section'));
                        return null;
        }
        
        if((applicationInput.Recommended_Award_Amount__c == null) && ((applicationInput.NOFA_RFP__r.Cash_Grants_Awards__c=='Yes') || (applicationInput.NOFA_RFP__r.Cash_Grants_Awards__c=='Optional' && applicationInput.Program_Type__c=='Support Grant' ) || (applicationInput.NOFA_RFP__r.Cash_Grants_Awards__c=='Optional' && applicationInput.Program_Type__c=='Program Grant'))){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter Recommended Award Amount'));
            return null;            
        } 
        
        if(applicationInput.Prime_Application__c!=null && (applicationInput.Prime_Application__r.Competitive_or_Formula__c == 'Competitive' 
                                                    || applicationInput.Prime_Application__r.Competitive_or_Formula__c == 'Formula')){
            if(applicationInput.Prime_Application__r.CNCS_Status__c == 'Closed to Sub-Applicants' || applicationInput.Prime_Application__r.CNCS_Status__c == 'Submitted to CNCS'){
                applicationInput.Status__c = 'Pending Prime Award Approval';
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Prime Application Should be Submitted to CNCS in order to Recommend for Award'));
                return null;
            }                
        }                          
        else{
            applicationInput.Status__c = 'Accepted'; 
        }
        PageReference Redirect;
        If(id!=null && id!=''){
           Redirect = new PageReference('/'+id);
        }
        update applicationInput;
        RecAwardsView = false;
        return Redirect;
        }
    catch(Exception ex){
            ApexPages.addMessages(ex);
        }
        return null;
    }
    
    // logic for rendering buttons for po and spo   --sowmya
    
  
  // end of code -- sowmya
    // Logic for Approve button on Application detial page and user redirected to Standrad event page/Email template     
    public PageReference Approve() { 
                                                        
            System.debug('Prashant#########'+Withdrawapp+'&&&'+applicationInput.id);
            Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
            PageReference Redirect;
            String tmpName = 'Concept_Paper_Approved';
            String status = 'Accepted';
            
            If(id!=null && id!=''){
             
                if(applicationInput.Grantee_Status__c == 'Accepted'){                    
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Approved'));
                     return null;
                }       
             
              
                list<User> submittedBy = new list<User>();  
                if(applicationInput.Prime_Application__c!=null){
                    /**/
                    if(userInfo.getProfileId()==stateCommisionProfile.Id){                      
                        applicationInput.status__c = 'Recommended to CNCS';
                        applicationInput.Grantee_Status__c = 'Recommended to CNCS';
                        Redirect = new PageReference('/statecommission/apex/CombinedDetailPage?id='+applicationInput.id);
                    }
                    else{
                        Redirect = new PageReference('/'+id);
                        system.debug('got here in approve method of concept paper for PO');
                        EmailTemplate emailTemplate = [Select e.DeveloperName,e.Subject, e.Name, e.Id, e.Description, e.Body From EmailTemplate e where DeveloperName = 'Sub_Applicant_Concept_paper_Approved']; 
                        String subject = emailTemplate.subject;    
                        String body = emailTemplate.body;
                        if(body.contains('{!User.Name}'))
                            body = (null == applicationInput.Prime_Application__r.Project_director__c) ? body : body.replace('{!User.Name}',applicationInput.Prime_Application__r.Project_director__c); 
                        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                        list<String> addressesToSend = new list<String>();        
                        addressesToSend.add(applicationInput.Prime_Application__r.CreatedBy.Email);                                       
                        email.setSubject( subject );
                        email.setToAddresses( addressesToSend );
                        email.setPlainTextBody( body );                                                                   
                        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
                        applicationInput.status__c = 'Accepted';
                        applicationInput.Grantee_Status__c = 'Accepted';
                    }
                    update applicationInput;
                    
                }else{
                    if(applicationInput.CreatedById!=null){             
                            /*Integer i = applicationInput.Submitted_By__c.indexOf(' ');
                            String lName = applicationInput.Submitted_By__c.left(i);            
                            String fName = applicationInput.Submitted_By__c.right(applicationInput.Submitted_By__c.length()-(i+1));  */                     
                            submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1];
                             if(submittedBy.size()>0){ 
                                if(UserInfo.getProfileId()==stateCommisionProfile.Id){
                                    Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                                }else{
                                    Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                                }                     
                             }
                    }           
                }
                return Redirect;
            }
           
            return null;
       }
       
       
    public PageReference OnHold() {                  
        Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
        PageReference Redirect;
        String tmpName = 'Hold_Pending_Resources_Email';
        String status = 'On Hold Pending Resources';
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);       
            if(applicationInput.Grantee_Status__c == 'On Hold Pending Resources'){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already On Hold'));
                 return null;
            }      
            //update applicationInput;        
            list<User> submittedBy = new list<User>();  
            if(applicationInput.CreatedById!=null){             
                    submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1]; 
                    if(submittedBy.size()>0){
                        if(UserInfo.getProfileId()==stateCommisionProfile.Id){
                            Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                        }else{
                            Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                        }  
                    }                   
            }           
            return Redirect;
        }
        return null;                           
    }
       
       
    

    public PageReference Reject() {
    try{
        
        Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
        PageReference Redirect;
        String tmpName = 'Concept_Paper_Rejected_Email';
        String Status = 'Rejected';
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);       
            if(applicationInput.Grantee_Status__c == 'Rejected'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Rejected'));
                return null;
            }     
                   
            list<User> submittedBy = new list<User>(); 
            if(applicationInput.Prime_Application__c!=null){
                if(userInfo.getProfileId()==stateCommisionProfile.Id){
                    try{
                        Contact c = [Select Id,Name,Email from Contact where id = :applicationInput.Point_of_Contact__c];                        
                        Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+c.Email+'&appId='+applicationInput.Id+'&status='+status);
                    }
                    catch(Exception e){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'No Point of Contact on Application/Concept Paper'));                    
                        return null;
                    }
                }else{
                    EmailTemplate emailTemplate = [Select e.DeveloperName,e.Subject, e.Name, e.Id, e.Description, e.Body From EmailTemplate e where DeveloperName = 'Sub_Applicant_Concept_paper_Rejected']; 
                    String subject = emailTemplate.subject;    
                    String body = emailTemplate.body;
                    if(body.contains('{!User.Name}'))
                        body = (null == applicationInput.Prime_Application__r.Project_director__c) ? body : body.replace('{!User.Name}',applicationInput.Prime_Application__r.Project_director__c); 
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
                    list<String> addressesToSend = new list<String>();        
                    addressesToSend.add(applicationInput.Prime_Application__r.CreatedBy.Email);                                       
                    email.setSubject( subject );
                    email.setToAddresses( addressesToSend );
                    email.setPlainTextBody( body );                                                                   
                    Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});  
                }                    
                applicationInput.status__c = 'Rejected';
                applicationInput.Grantee_Status__c = 'Rejected';
                update applicationInput;
                
            }else{ 
                if(applicationInput.CreatedById!=null){             
                        submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1]; 
                        if(submittedBy.size()>0){
                            if(UserInfo.getProfileId()==stateCommisionProfile.Id){                   
                                Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                            }else{
                                Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                            }                     
                        }
                }        
            }   
            return Redirect;
        }
    }catch(Exception exc){
        System.debug('exc'+exc);
    }   
        return null;

    }
    
    
    public PageReference Clone1(){
      
         PageReference Redirect;
         Redirect = new PageReference('/apex/ClonePlus1?id='+applicationInput.Id +'&childobjecttypes=Attactment__c' + '&applicationInput.Status__c=None');
         return Redirect;
    }
    
    
    
    public boolean retrievebudgetStatusForApplication(){
        boolean flag=false;
        try{
            
            List<Application3__c> lstApp=[select id,name,(select id,Parent__c,cb3__Status__c from Budget_Applications__r) from Application3__c where Id=: ApexPages.currentPage().getParameters().get('Id')];
            System.debug('***lstApp***'+ lstApp );
            
            for (Application3__c objApp :lstApp){
                
               if(objApp.Budget_Applications__r.size()==0){
                   flag=true;
               }
               else{                
                   for(cb3__Budget__c objBudgetApp : objApp.Budget_Applications__r)    {
                        if(objBudgetApp.cb3__Status__c != 'Completed'){
                          flag=true;
                          break;
                        }
                    }  
               }           
            }
        }catch(exception exc){
            system.debug('exc'+exc);
        }
            return flag;             
        }
        
    public void updateAwardForReturnForAwrd(List<Award__c> lstAward){
          for(Award__c iterAward   :lstAward){
             iterAward.Grant_Status__c='Awaiting PO Certification';
          }
          try{
               if(lstAward!=null && lstAward.size()>0){
                  update lstAward;
               }
          }
        catch(DMLException dmlExc){
            System.debug('updateAwardForReturnForAwrd DMLexception***'+dmlExc.getMessage());
        }
        catch(Exception exc){
         System.debug('updateAwardForReturnForAwrd exception***'+exc.getMessage());
        } 
    }
       
    // Logic for Submit button on Application detial page and status getting changed to 'Submittede'
    public PageReference Submitdetail() {  
         
        PageReference Redirect;
            try{
            System.debug('Over Validate method inside Submit detail.....' +Validate());
                if(Validate()) { 
                    if(id!=null && id!='') {
                System.debug('Below Validate Method inside Validate.....'    +Validate());   
               // alert ('Consultation with the state commission(s) is required for each state where activities have been proposed. Please contact your state commission(s) to complete the consultation.');
                system.debug('applicationInput.Application_Signed__c = '+applicationInput.Application_Signed__c);
                system.debug('rt = '+applicationInput.RecordTypeId);
                system.debug('app rt = '+Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId());
                if (applicationInput.Nofa_Rfp__r.State_Commission_Input_Application__c == 'Yes' || applicationInput.Nofa_Rfp__r.State_Commission_Input_Concept_Paper__c == 'Yes' ) {
                    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Consultation with the state commission(s) is required for each state where activities have been proposed. Please contact your state commission(s) to complete the consultation.'));
                    
                }
                if(applicationInput.Application_Signed__c==false && applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId()) {
                    system.debug('got here in not signed');
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please Sign Application before Submitting'));
                    return null;
                }
                List<Award__c> lstAward =[select id,name,Grant_Status__c,Application_ID__r.name,Application_ID__c from award__c where Application_ID__c= :applicationInput.id ];
                string RequiredDocs;  
                map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
                map<String,Boolean> checkRequiredFocusFields = new map<String,Boolean>();
                map<String,Boolean> FocusFieldsonNofa = new map<String,Boolean>();
                map<String,Boolean> NarrativeFieldsonNofa = new map<String,Boolean>();
                System.debug('Prashant#########'+Withdrawapp);
                String conceptPaperId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
                system.debug('========='+conceptPaperId);
                Id profileid = UserInfo.getProfileId();
                Profile p = [Select Id,Name from Profile p where Id = :profileId];
                System.debug('p = ' +p);
                System.debug('******************Profile ID' +profileid);
                if(applicationInput.RecordTypeId != Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() 
                        && applicationInput.Nofa_Rfp__r.ConfiguredBudgetForms__c!=null){
                    Boolean budgetStatus=retrievebudgetStatusForApplication();
                    if(budgetStatus){
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Validate Budget before submitting application'));
                      return null;
                    }
                }
             
                
                
                
                if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId()){
                locList = [Select Id,State__c  from Location__c WHERE Application__c = : applicationInput.Id];
                
                if(applicationInput.recordtype.name=='Application' && locList != null && locList.isEmpty() && (applicationInput.NOFA_RFP__r.Standard_Information__c == true || 
                                                                                                              applicationInput.NOFA_RFP__r.EIN_Information__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Site_Date_Information__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Site_Type__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Additional_Operating_Site_Information__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Volunteer_Information__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Focus_Area_and_Objectives_Location__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.School_Information__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Site_Type_and_Summer_Associates__c == true ||
                                                                                                              applicationInput.NOFA_RFP__r.Lodging_Information__c == true)) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please add a location to this application prior to submitting'));
                        return null;
                }   
                
                for(Location__c l:locList){
                    if(!applicationInput.State_and_or_Territories__c.contains(l.state__c)){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'One of the locations entered was not identified in the “Areas Affected by the Project” section of your application. '+ 
                        +'Please review this information and revise as needed'));
                        return null;
                    }
                }
              }
               
                if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() 
                          && applicationInput.NOFA_RFP__r.Performance_Measures__c){
                    Boolean goAheadFlag;
                    String status_cd = invokeValidatePM();
                    if(status_cd !=null && status_cd !='' && status_cd.equalsignoreCase('Ok')){
                         goAheadFlag=true;
                         
                    }else{
                          goAheadFlag=false;
                          //throw new CNCS_ObjectUtility.CustomException('Exception -> '+ status_cd +' .'); 
                    }
                    if(!goAheadFlag){
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Exception -> '+ status_cd +' .'));                    
                         return null;
                    }
                    
                }
                If(id!=null && id!=''){
                    Redirect = new PageReference('/'+id);
                    RequiredDocs = checkRequiredDocsAttached();
                    if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId()){
                        FocusFieldsonNofa = ApplicationCheck.appFocusAreaFieldsonNofa(applicationInput.NOFA_RFP__c);
                        //NarrativeFieldsonNofa = ApplicationCheck.appNarrativeFieldsonNofa(applicationInput.NOFA_RFP__c);
                        checkRequiredNarrativeFields = ApplicationCheck.checkNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
                        checkRequiredFocusFields = ApplicationCheck.checkAppFocusAreaFields(applicationInput,applicationInput.NOFA_RFP__c);
                    }
                    if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId()){
                        FocusFieldsonNofa = ApplicationCheck.cpFocusAreaFieldsonNofa(applicationInput.NOFA_RFP__c);
                       // NarrativeFieldsonNofa = ApplicationCheck.cpNarrativeFieldsonNofa(applicationInput.NOFA_RFP__c);
                        checkRequiredNarrativeFields = ApplicationCheck.checkCPNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
                        checkRequiredFocusFields = ApplicationCheck.checkCPFocusAreaFields(applicationInput,applicationInput.NOFA_RFP__c);
                    }
                    system.debug('checkRequiredFocusFields = '+checkRequiredFocusFields);
                    if(FocusFieldsonNofa.size()>0 && checkRequiredFocusFields.size()<1){
                        /*string fieldNames = '';
                        for(String fieldName: checkRequiredFocusFields.keyset()){
                            fieldNames += fieldName +', ';
                        }*/
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application/Concept Paper cannot be Submitted, Due to the following reason: Please enter values in atleast 1 Focus Area fields'));                    
                        return null;
                    }
                            
                    if(checkRequiredNarrativeFields.size()>0){
                        string fieldNames = '';
                        for(String fieldName: checkRequiredNarrativeFields.keyset()){
                            fieldNames += fieldName +', ';
                        }
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application/Concept Paper cannot be Submitted, Due to the following reason: Please enter Narrative fields: '+fieldNames));                    
                        return null;
                    }
                    
                    if(RequiredDocs != null && RequiredDocs != ''){
                      if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId()){                  
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Application cannot be Submitted, Due to the following reason: Required Document not attached to Application: '+RequiredDocs));
                          return null;
                      }
                    }
                    if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId()){
                     applicationInput.Status__c='Submitted';
                             applicationInput.Grantee_Status__c='Submitted';
                             update applicationInput;
                             }
                    else{
                          system.debug('****'); 
                          system.debug('return to rework = '+applicationInput.flagReturnForRework__c);       
                          if(applicationInput.NOFA_RFP__r.CNCS_Corporate_Program__r.Name!=null){
                                String cpName = applicationInput.NOFA_RFP__r.CNCS_Corporate_Program__r.Name;
                                system.debug('cpName = '+cpName);
                                    if(!cpName.contains('NCCC')){
                                   if(applicationInput.Organization__c !=null && applicationInput.Organization__r.DUNS__c==null && applicationInput.recordtype.name=='Application' ){
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter a Duns number on Organization and Submit'));
                                        return null;                            
                                    }   
                                }          
                          } 
                          if(applicationInput.Sub_Application__c=='Yes' && (p.Name=='Applicant' || p.Name == 'Grantee Admin')){       
                             System.debug('Prashant@@ in applicant');
                             applicationInput.Status__c='Submitted to Prime';
                             applicationInput.Grantee_Status__c='Submitted to Prime';
                             applicationInput.Submitted_to_Prime_Applicant__c = Date.today();
                            if(applicationInput.flagReturnForRework__c==True){ 
                                 applicationInput.Status__c='Accepted';
                                  applicationInput.Grantee_Status__c='Accepted';
                                 updateAwardForReturnForAwrd(lstAward);
                             }
                          }
                          else if(applicationInput.Sub_Application__c=='Yes' && p.Name=='State Commission Profile'){
                           System.debug('Prashant@@ in state commission');
                            applicationInput.Status__c='Submitted to CNCS';
                            applicationInput.Grantee_Status__c = 'Submitted to CNCS';
                             if(applicationInput.flagReturnForRework__c==True){ 
                                applicationInput.Status__c='Accepted';
                                  applicationInput.Grantee_Status__c='Accepted';
                                updateAwardForReturnForAwrd(lstAward );
                             }
                          }
                          else if(applicationInput.flagReturnForRework__c==True){
                                    applicationInput.Status__c = 'Accepted';
                                    applicationInput.Grantee_Status__c='Accepted';
                                    updateAwardForReturnForAwrd(lstAward );
                          }
                          else{
                                  applicationInput.Grantee_Status__c = 'Submitted';
                                  applicationInput.Status__c = 'Submitted';
                              
                          }
                          
                          update applicationInput;
                         
                          //add attachments to organization when app is submitted      
                          if(applicationInput.NOFA_RFP__r.Organization_Docs__c!=null){
                                ApplicationCheck.attachOrgDocs(applicationInput, applicationInput.NOFA_RFP__r.Organization_Docs__c);
                          }
                    }         
                return Redirect;
                }
             }
                }
         }
        catch(System.DMLException e){
            ApexPages.addMessages(e);
            System.debug('exc'+e);
            return null;
        
        }       
        return null;
    }

    public String invokeValidatePM(){
                HttpResponse hResp;
                String json='';
                                    
                String strWSname='ValidatePM';
                String  endPointuri='';
                String  uName='';
                String  upassword='';
                String  httpMethodName='';
                String  contenttype='';
                String  status_cd;
                CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
                try{
                            Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                            System.debug(objIntgr_MuleSoft);
                            if(objIntgr_MuleSoft==null){
                                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service Performance Measures is not setUp'));
                                throw new CNCS_ObjectUtility.CustomException();
                            }
                            if(objIntgr_MuleSoft!=null){
                                endPointuri=objIntgr_MuleSoft.endPointuri__c;
                                uName=objIntgr_MuleSoft.uName__c;
                                upassword=objIntgr_MuleSoft.upassword__c;
                                httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                                contenttype=objIntgr_MuleSoft.contenttype__c;
                            }
                           
                            String strBody=composeBodyForValidatePMWithgrnt_id();
                            System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                            hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                            System.debug('***hResp***'+hResp);
                            // the service is returning a line feed so parse it out
                            json = hResp.getBody().replace('\n', '');
                            System.debug('***json***'+json );
                            
                            
                            if(json!=null  &&  json!='' &&  json.length()>0){
                               if(!json.SubString(0,1).equals('[')){
                                  json='['+json+']';
                               }
                             }  
                               
                            //above block of conditional stat need to be commented after resp update 
                            ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                            ParseJSONUtil.ValidatePMForgrnt_idJSON    objValidatePMForgrnt_idJSON= new ParseJSONUtil.ValidatePMForgrnt_idJSON();
                            objValidatePMForgrnt_idJSON= objParseJSONUtil.parseValidatePMForgrnt_idJSON(json);
                            System.debug('***objValidatePMForgrnt_idJSON'+objValidatePMForgrnt_idJSON);
                            List<ParseJSONUtil.ValidatePMForgrnt_id> lstValidatePMForgrnt_id=objValidatePMForgrnt_idJSON.lstData;
                            System.debug('***lstValidatePMForgrnt_id'+lstValidatePMForgrnt_id);
                            //updateMomentumDataForFFRAwardReporting(lstGrantCloseOutForSuppMechCD);
                            status_cd = updateStatusinvokeValidatePM(lstValidatePMForgrnt_id);
                            return status_cd;
                           
                          
                        }catch(CalloutException exc){
                            System.debug('***exc***'+exc);
                            System.debug('***exc.getMessage()***'+exc.getMessage());
                            return null;
                        }
                        catch(CNCS_ObjectUtility.CustomException custExc){
                            System.debug('***custExc***'+custExc);
                            System.debug('***custExc.getMessage()***'+custExc.getMessage());
                            return null;
                        }
                        catch(Exception exc){
                            System.debug('***exc***'+exc);
                            System.debug('***exc.getMessage()***'+exc.getMessage());
                            return null;
                        }
        
        }
    
    public String composeBodyForValidatePMWithgrnt_id(){
           String strGrantId=applicationInput.name;
           String strBody ='{ "grnt_id":'+'"'+ strGrantId+'" }';
           return strBody;
    }
         
         
    public String updateStatusinvokeValidatePM(List<ParseJSONUtil.ValidatePMForgrnt_id> lstValidatePMForgrnt_id){
        Boolean goAheadFlag=false;
        try{
            String status_cd;
            if(lstValidatePMForgrnt_id!=null && lstValidatePMForgrnt_id.size() >0){
                 status_cd = lstValidatePMForgrnt_id[0].status_cd;
                    /*if(status_cd !=null && status_cd !='' && status_cd.equalsignoreCase('Ok')){
                         //goAheadFlag=true;
                         return status_cd;
                    }else{
                          //goAheadFlag=false;
                          //throw new CNCS_ObjectUtility.CustomException('Exception -> '+ status_cd +' .'); 
                          return status_cd;
                    } */
             }
             /*if(goAheadFlag){
                 //update stat
                 applicationInput.Grantee_Status__c='Submitted';
                 applicationInput.Status__c='Submitted';
                 update applicationInput;
             }*/
              return status_cd;
             
        }
        catch(DMLException exc){
            System.debug('***exc***'+exc);
            System.debug('***exc.getMessage()***'+exc.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
            return null;
        }
        catch(CNCS_ObjectUtility.CustomException  custExc) {
             // throw new CNCS_ObjectUtility.CustomException(custExc.getmessage());
              System.debug('Custom Exception '+ custExc);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
              return null;
        }
        catch(Exception exc){
            System.debug('***exc***'+exc);
            System.debug('***exc.getMessage()***'+exc.getMessage());
            return null;
        }
    }
         
    //Attachment 
    public String checkRequiredDocsAttached(){
           
        string RequiredDocs = '';
        try{    
            
            boolean check = true; 
            
            String s;
            string allAttachmentTypes='';

            if(applicationInput.NOFA_RFP__c!=null && applicationInput.NOFA_RFP__r.Required__c !=null){
                system.debug('boolean in !=null = '+check);
            
                s = applicationInput.NOFA_RFP__r.Required__c;
                list<String> docTypes = s.split(';');
            
            
                list<Attachment__c> attachments = new list<Attachment__c>([Select Id,Type__c from Attachment__c where Application__c = :applicationInput.Id]);
                
                if(attachments.size()>0){           
                    for(Attachment__c a: attachments){              
                        if(a.Type__c!=null)
                        {   
                            allAttachmentTypes += a.Type__c+';';                    
                        }                   
                    }
                    system.debug('allAttachmentTypes '+allAttachmentTypes);
                }
                
                system.debug('docTypes ='+docTypes);
                for(String dType: docTypes){
                    if(allAttachmentTypes!=null && allAttachmentTypes != ''){
                        system.debug('allAttachmentTypes ='+allAttachmentTypes);
                        system.debug('docType ='+dType);
                        if(allAttachmentTypes.Contains(dType)){
                            check = true;
                        }else{
                            check = false;      
                            requiredDocs += dType + ', ';          
                        }
                    }else{
                        system.debug('allAttachmentTypes ='+allAttachmentTypes);
                        requiredDocs += dType + ', '; 
                    }
                    
                }
            }
            system.debug('RequiredDocs = '+RequiredDocs);
            
        }
        catch(Exception exc){
            System.debug('exc'+exc);
        }
        return requiredDocs;
    
    }

    // Add locations from Application
    public PageReference AddLocations() {
     
        PageReference Redirect;        
        Redirect = new PageReference('/apex/LocationCreationPage?applicationid='+id);  
        //list<Location__c> locationList = new list<Location__c>([select id,name,Application__c from Location__c where id IN: id]);
         //Location__c loc = new Location__c();
         //loc.Application__c = applicationInput.id;  
        return Redirect;
    }
    
    public PageReference HldforFormula() {
         
        PageReference Redirect;
        If(id!=null && id!=''){         
            applicationInput.Status__c='Held For Formula';
            applicationInput.Grantee_Status__c='Held For Formula';
            update applicationInput;
            Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
            System.debug('app;lication values-->'+applicationInput.status__c);
            Redirect.setRedirect(true);
            return Redirect;
        }
            
        return null;
    }
     
    public PageReference Reject5() {
         
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
            applicationInput.Status__c='Rejected';
            applicationInput.Grantee_Status__c='Rejected';
            update applicationInput;
            System.debug('app;lication values-->'+applicationInput);
            Redirect.setRedirect(true);
            return Redirect;
        }
            
        return null;
    }
    
    public pageReference returntoRework(){       
    try{
        Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1]; 
        PageReference Redirect;
        String tmpName = 'Returned_for_Rework_Email';
        String status = 'Returned for Rework';
        If(id!=null && id!=''){
            Redirect = new PageReference('/'+id);       
            if(applicationInput.Grantee_Status__c == 'Returned for Rework'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Returned for Rework'));
                return null;
            }     
                  
            list<User> submittedBy = new list<User>();  
            if(applicationInput.CreatedById!=null){             
                submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1];
                if(submittedBy.size()>0){
                    if(UserInfo.getProfileId()==stateCommisionProfile.Id){                   
                        Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }else{
                        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);
                    }                     
                }
            }           
        return Redirect;
        }
    }catch(Exception exc){
          System.debug('exc'+exc);
    }
    return null;        
    }
    
    // End here

    // Concept Paper Edit Button 
    public pageReference returntoReworkApp(){  
        PageReference Redirect;
        try{    
            Profile stateCommisionProfile = [Select Id from Profile where Name = 'State Commission Profile' limit 1];
            
            String tmpName = 'Application_Return_to_Rework';
            String status = 'Returned for Rework';
            EmailTemplate tmp = [Select Id,Name from EmailTemplate where DeveloperName = 'Application_Return_to_Rework'];
            list<User> submittedBy = new list<User>();  
            If(id!=null && id!=''){         
                if(applicationInput.Grantee_Status__c == 'Returned for Rework'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info, 'Concept Paper is already Returned for Rework'));
                    return null;
                }
                if(applicationInput.CreatedById!=null){
                    submittedBy = [Select Id,Email from User where Id = :applicationInput.CreatedById limit 1];
                    if(submittedBy.size()>0){
                         if(UserInfo.getProfileId()==stateCommisionProfile.Id){  
                            Redirect = new PageReference('/apex/statecommission/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);                    
                         }else{
                            Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+submittedBy[0].Email+'&appId='+applicationInput.Id+'&status='+status);    
                                                               
                         }
                    } 
                    Redirect.setRedirect(true);
                    return Redirect;
                }              
            }
        }
        catch(exception exc){
            System.debug('exc'+exc);
        }   
        return null;
    }
    
    
    
    public void closePopup(){       
        displayPopup = false;   
    }    
    public void showPopup(){   
        displayPopup = true; 
    }
    
    public PageReference appEdit(){
        PageReference Redirect;
        If(id!=null && id!=''){                     
            Redirect = new PageReference('/apex/ApplicationEditpage?id='+applicationInput.id);
            return Redirect;
        }
        return null;    
    }
    
    public PageReference ConceptContinueBtn(){
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
            return Redirect;
        }
        return null;    
    }
  
    public PageReference ConceptContinueBtnforStaff(){
        PageReference Redirect;
        If(id!=null && id!=''){
            Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
            return Redirect;
        }
        return null;    
    }
  
    // New Requirement on 4 Sep 15
    public PageReference RecAwardsMethod(){
        RecAwardsView = true;  
        system.debug('recommend for award method'+applicationInput.id);  
        if(applicationInput.Prime_Application__c!=null && applicationInput.Prime_Application__r.CNCS_Status__c!='Submitted to CNCS'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Prime Application Should be Submitted to CNCS in order to Recommend for Award'));
            return null;
        }else{ 
            applicationInput.Status__c = 'Recommended For Award'; 
        }
        system.debug('upset in recommend for award method'+applicationInput);   
        PageReference Redirect;
        Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
          
        return Redirect;
        
    }
    
   // End here   
   // New Requirement on 16 Oct 2015
    public PageReference saveAward(){    
        applicationInput.Status__c = 'Approved For Award'; 
    try {
        update applicationInput;
        system.debug('update approved for award method'+applicationInput);  
        PageReference Redirect;
        Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
        RecAwards = false;
        return Redirect;
    }
    catch(Exception ex){
            ApexPages.addMessages(ex);
    }
    return null;
  }
  // End here  
  
    public PageReference contApp(){
        try{
            Application3__c newApp = new Application3__c();                 
            newApp = applicationInput.Clone(); 
            newApp.NOFA_RFP__c = null;   
            newApp.Rank__c = null;       
            newApp.Type_of_Application__c = 'Continuation'; 
            newApp.Grantee_Status__c = 'In Progress';
            newApp.Status__c = 'In Progress';
            newApp.Parent_Application__c = applicationInput.Id;
            newApp.Parent_Application_Match_Year__c = applicationInput.Match_Year_Field_2_App__c;
            insert newApp;
            PageReference pg = new PageReference('/apex/NofaSelection?id='+newApp.Id);
            pg.getParameters().put('isContinuingApp','true');
            pg.getParameters().put('parentId',applicationInput.Id);
            pg.setRedirect(true);
            return pg;   
        }
        catch(Exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
             return null;
        }   
        return null;
    }    
    
    
    public pageReference cloneApp(){
        try{
            Application3__c newApp = new Application3__c();                 
            newApp = applicationInput.Clone(); 
            newApp.NOFA_RFP__c = null;  
            newApp.Rank__c = null;    
            insert newApp;
            PageReference pg = new PageReference('/apex/NofaSelection?id='+newApp.Id);
            pg.getParameters().put('isContinuingApp','false');
            pg.getParameters().put('parentId',applicationInput.Id);
            pg.setRedirect(true);
            return pg;   
        }
        catch(Exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
             return null;
        }   
        return null;
    }
    
    public PageReference completeComplianceReview(){
    try{
        complianceSection = true;
        if(applicationInput.Nofa_Rfp__r.Timely_Submission__c){
            applicationInput.Response_TS__c = String.valueOf(Date.today());
            if(Date.today() > applicationInput.Application_Due_Date__c)
                applicationInput.Compliance_Flag__c = 'Flagged';
            else
                applicationInput.Compliance_Flag__c = 'Not Flagged';
        }                
        if(applicationInput.Nofa_Rfp__r.Organization_Characteristics__c){
            applicationInput.Response_OC__c = applicationInput.Organization__r.O__c;
            if(applicationInput.Organization__r.O__c!=null){
                    list<String> characteristics = applicationInput.Response_OC__c.split(';');
                    for(String s: characteristics){
                      if(applicationInput.Nofa_Rfp__r.Eligible_Org_Characteristics__c!=null){   
                        if(applicationInput.Nofa_Rfp__r.Eligible_Org_Characteristics__c.contains(s))
                            applicationInput.Compliance_Flag_OC__c = 'Not Flagged';
                        else
                            applicationInput.Compliance_Flag_OC__c = 'Flagged';
                      }
                    }   
                }
            
        }
        if(applicationInput.Nofa_Rfp__r.Type_of_Organization__c){
            applicationInput.Response_TypeofOrg__c = applicationInput.Organization__r.Organization_Type__c;
            if(applicationInput.Organization__r.Organization_Type__c!=null){
                    list<String> types = applicationInput.Response_TypeofOrg__c.split(';');
                    for(String s: types){
                      if(applicationInput.Nofa_Rfp__r.Eligible_Org_Types__c!=null){ 
                       if(applicationInput.Nofa_Rfp__r.Eligible_Org_Types__c.contains(s))
                          applicationInput.Compliance_Flag_TypeofOrg__c = 'Not Flagged';
                       else
                          applicationInput.Compliance_Flag_TypeofOrg__c = 'Flagged';
                      }
                    }  
                }            
        }
        
        //
        String intentToApplyRTId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Notification of Intent to Apply').getRecordTypeId();
        list<Application3__c> intenttoApply = [select Id,Name from Application3__c where Organization__c = :applicationInput.Organization__c and recordTypeId = :intentToApplyRTId];
        if(applicationInput.Nofa_Rfp__r.Notice_of_Intent_to_Apply_Submitted__c){
            if(applicationInput.Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c == 'Required' && intenttoApply.size()>0 /* && atleast intent to apply records */ ){
                applicationInput.Response_Notification__c = 'Submitted';
            }
            if(applicationInput.Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c == 'Required' && intentToApply.size()==0/* && no intent to apply records */){
                applicationInput.Response_Notification__c = 'Not Submitted';
            }
            if(applicationInput.Response_Notification__c == 'Not Submitted' && applicationInput.Nofa_Rfp__r.Notification_of_Intent_to_Apply_Required__c == 'Required'){
                applicationInput.Compliance_Flag_Notification__c = 'Flagged';
            }else{
                applicationInput.Compliance_Flag_Notification__c = 'Not Flagged';
            }
        }
        
        List<AggregateResult> aggregateAmounts = [Select SUM(CB3__CTOTAL__C)grandTotal,cb3__BudgetApplication__c from cb3__BudgetLine__c where cb3__BudgetApplication__r.Parent__r.Id = :applicationInput.Id group by cb3__BudgetApplication__c];
        if(applicationInput.NOFA_RFP__r.Award_Amount__c){
                if(aggregateAmounts.size()>0){
                        applicationInput.Response_AA__c = String.valueOf(aggregateAmounts[0].get('grandTotal'));
                        Decimal d = (Double)aggregateAmounts[0].get('grandTotal');
                        if(d >applicationInput.Nofa_Rfp__r.Lower_threshold__c && d < applicationInput.NOFA_RFP__r.Upper_threshold__c){
                                applicationInput.Compliance_Flag_AA__c = 'Not Flagged';
                        }else{
                                applicationInput.Compliance_Flag_AA__c = 'Flagged';
                        }
                }
                
        }
        
        List<AggregateResult> aggregateAmountsSubGrants = [Select SUM(CB3__CTOTAL__C)grandTotal,cb3__BudgetApplication__c from cb3__BudgetLine__c where cb3__BudgetApplication__r.Parent__r.Id = :applicationInput.Id and CB3__BUDGETSECTION__r.cb3__SectionName__c = 'Subgrant/Pass-through Costs' group by cb3__BudgetApplication__c];
        if(applicationInput.Nofa_Rfp__r.At_least_80_of_funds__c){
                if(aggregateAmountsSubGrants.size()>0){
                        Decimal d = (Double)aggregateAmountsSubGrants[0].get('grandTotal')/(Double)aggregateAmounts[0].get('grandTotal');
                        applicationInput.Response_Atleast_80_funds__c = string.valueOf(d);
                        if(d>0.8){
                                applicationInput.Compliance_Flag_Atleast_80_funds__c = 'Not Flagged';
                        }else{
                                applicationInput.Compliance_Flag_Atleast_80_funds__c = 'Flagged';
                        }
                }
        }
        List<AggregateResult> aggregateAmountsGrantee = [Select SUM(CB3__CQ2__C)granteetotal,SUM(CB3__CTOTAL__C)grandTotal,cb3__BudgetApplication__c from cb3__BudgetLine__c where  cb3__BudgetApplication__r.Parent__r.Id = :applicationInput.Id group by cb3__BudgetApplication__c];
        List<cb3__BudgetLine__c> budgetLine = [Select Id,cb3__SelectedIndirectCostRate__c from cb3__BudgetLine__c where cb3__BudgetApplication__r.Parent__r.Id = :applicationInput.Id];
        if(applicationInput.NOFA_RFP__r.Match_Met__c){
            if(aggregateAmountsGrantee.size()>0){
                Decimal d = (Double)aggregateAmountsGrantee[0].get('granteetotal')/(Double)aggregateAmountsGrantee[0].get('grandTotal');
                Decimal a = d * 100;
                applicationInput.Response_Match_Met__c = string.valueOf(a)+'%';
                if(budgetLine.size()>0){
                    system.debug('a = '+a);
                    system.debug('cost rate = '+budgetLine[0].cb3__SelectedIndirectCostRate__c);
                    if(budgetLine[0].cb3__SelectedIndirectCostRate__c!=null){
                        if(a>budgetLine[0].cb3__SelectedIndirectCostRate__c){
                            applicationInput.Compliance_Flag_Match_Met__c = 'Not Flagged';
                        }else{
                            applicationInput.Compliance_Flag_Match_Met__c = 'Flagged';
                        }
                    }
                }
            }
        }
        }catch(Exception exc){
           System.debug('exc'+exc);
        }
        
        PageReference pg;
        pg = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
        return pg;
    }
    
    public PageReference saveComplianceInfo(){
        try{
                if(applicationInput.Non_Compliance_Re_Examination__c=='Appeal-Accepted')
                        applicationInput.Compliance_Determination__c = 'Compliant';
            update applicationInput;
            PageReference Redirect;
            Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
            complianceSection = false;
            return redirect;
        }
        catch(exception e){
            ApexPages.addMessages(e);           
        }
         
        return null;
    }
    
    public boolean Validate(){
    system.debug('Inside Validate Method');
                          if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Infrastructure_Improvement_CP__c!=null && applicationInput.Infrastructure_Improvement_CP__c.contains( 'Other' ) && applicationInput.Other_Infrastructure_Improvement_CP__c == Null) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Infrastructure Improvement'));
                                 return false;
                            }
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Infrastructure_Improvement__c != null && applicationInput.Infrastructure_Improvement__c.contains( 'Other' ) && applicationInput.If_other_please_specify_Infrastructure__c == Null  ) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Infrastructure Improvement'));
                                return false;
                            }
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Energy_Conservation_CP__c != null && applicationInput.Energy_Conservation_CP__c.contains( 'Other') && applicationInput.Other_Energy_Conservation_CP__c== Null )  {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Energy Conservation'));
                                return false;
                            }
                            if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Energy_Conservation__c != null && applicationInput.Energy_Conservation__c.contains( 'Other') && applicationInput.If_other_please_specify_Energy__c == Null )  {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Energy Conservation'));
                                 return false;
                            }
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Environmental_Stewardship_Conservation_C__c!=null && applicationInput.Environmental_Stewardship_Conservation_C__c.contains( 'Other') && applicationInput.Other_Environmental_Steward_Conserv_CP__c == Null)  {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Environmental Stewardship Conservation'));
                                 return false;
                            }
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Environmental_Stewardship_Conservation__c!=null && applicationInput.Environmental_Stewardship_Conservation__c.contains( 'Other') && applicationInput.If_other_please_specify_Enivironment_Ste__c == Null ){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Environmental Stewardship Conservation'));
                                  return false;
                             }
                             if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Urban_and_Rural_Development_CP__c!=null && applicationInput.Urban_and_Rural_Development_CP__c.contains( 'Other') && applicationInput.Other_Urban_and_Rural_Development_CP__c== Null ){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Urban and Rural Development'));
                                  return false;
                             }
                             if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Urban_and_Rural_Development__c!=null && applicationInput.Urban_and_Rural_Development__c.contains( 'Other') && applicationInput.If_other_please_specify_Urban__c== Null ){
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Urban and Rural Development'));
                                  return false;
                             }
                           if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Natural_and_Other_Disasters__c!=null && applicationInput.Natural_and_Other_Disasters__c.contains( 'Other') && applicationInput.If_other_please_specify_disaster__c== Null )  {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Natural and Other Disasters'));
                                 return false;
                            }
                           if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Natural_and_Other_Disasters_CP__c !=null && applicationInput.Natural_and_Other_Disasters_CP__c.contains( 'Other') && applicationInput.Other_Natural_and_Other_Disasters_CP__c== Null ) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Other Natural and Other Disasters'));
                                 return false;
                            }
 
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.Ability_to_sustain_project_s_outcomes_Ap__c!=null && applicationInput.NOFA_RFP__r.NCCC_All__c ==true && applicationInput.Ability_to_sustain_project_s_outcomes_Ap__c.contains( 'Yes') && applicationInput.Level_of_evidence_for_project_model__c== Null ) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'If Yes is selected in Ability to sustain projects outcomes then Level of evidence for project model is required '));
                                 return false;
                            }
                            if( applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.Ability_to_sustain_project_s_outcomes_Co__c!=null && applicationInput.NOFA_RFP__r.NCCC_All_Concept_Paper__c ==true && applicationInput.Ability_to_sustain_project_s_outcomes_Co__c.contains( 'Yes') && applicationInput.Level_of_evidence_for_project_model_cp__c== Null ) {
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'If Yes is selected in Ability to sustain projects outcomes then Level of evidence for project model is required '));
                                 return false;
                            }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Natural_and_Other_Disasters__c != null && applicationInput.Disaster_Type__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An option must be selected in the “Disaster Type” field when an objective from the “Natural and Other Disaster” focus area is selected.'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Natural_and_Other_Disasters__c == null && applicationInput.Disaster_Type__c != null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An option cannot be selected in the “Disaster Type” field if an objective from the “Natural and Other Disaster” focus area is not selected.'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Natural_and_Other_Disasters_CP__c!= null && applicationInput.Disaster_Type_CP__c== null){
                            System.debug('Inside Natural Disaster CP');
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An option must be selected in the “Disaster Type” field when an objective from the “Natural and Other Disaster” focus area is selected.'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Natural_and_Other_Disasters_CP__c== null && applicationInput.Disaster_Type_CP__c!= null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An option cannot be selected in the “Disaster Type” field if an objective from the “Natural and Other Disaster” focus area is not selected.'));
                            return false;
                          }
                         if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Additional_background_checks_Concept__c=='Yes' && applicationInput.Describe_additional_background_checks_co__c== null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a description of the additional background checks.'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Additional_background_checks_App__c== 'Yes' && applicationInput.Describe_additional_background_checks_Ap__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a description of the additional background checks.'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Additional_background_checks_Concept__c=='No' && applicationInput.Describe_additional_background_checks_co__c!= null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You can not enter a Description of the Additional Background Checks if additional back ground check is "NO"'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Additional_background_checks_App__c== 'No' && applicationInput.Describe_additional_background_checks_Ap__c != null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You can not enter a Description of the Additional Background Checks if additional back ground check is "NO"'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Funding_Code_ConceptPaper__c==null && applicationInput.Disaster_Number_ConceptPaper__c==null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Either a Funding Code or a Disaster Number must be entered in order to submit a concept paper'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Natural_and_Other_Disasters_CP__c == null && applicationInput.Disaster_Type_ConceptPaper__c != null ) {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'A Disaster Type cannot be selected if an objective from the Natural and Other Disasters focus area is not selected.'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Natural_and_Other_Disasters_CP__c != null && applicationInput.Disaster_Type_ConceptPaper__c == null ) {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'A Disaster Type must be selected if an objective from the Natural and Other Disasters focus area is selected.'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Possible_health_restrictions_Con__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Possible_work_with_hazardous_chemicl_Con__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner_Concept_paper__c==true && applicationInput.Possible_hazardous_waste_exposure_Con__c == null){
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
                          return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Possible_health_restrictions_App__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Possible_work_with_hazardous_chemicl_App__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Possible_hazardous_waste_exposure_App__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Funding_Code_Application__c==null && applicationInput.Disaster_Number_Application__c==null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Either a Funding Code or a Disaster Number must be entered in order to submit a concept paper'));
                            return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Natural_and_Other_Disasters__c == null && applicationInput.Disaster_Type_Application__c != null ) {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'A Disaster Type cannot be selected if an objective from the Natural and Other Disasters focus area is not selected.'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() && applicationInput.NOFA_RFP__r.NCCC_Partner__c==true && applicationInput.Natural_and_Other_Disasters__c != null && applicationInput.Disaster_Type_Application__c == null ) {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'A Disaster Type must be selected if an objective from the Natural and Other Disasters focus area is selected.'));
                             return false;
                          }
                          if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All__c==true && applicationInput.How_many_teams_are_being_requested_App__c == null){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for How many teams required'));
                            return false;
                            }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All__c==true && applicationInput.Number_of_weeks_to_complete_project_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Number of weeks to complete project'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All__c==true && applicationInput.Ability_to_sustain_project_s_outcomes_Ap__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Ability to sustain projects outcome'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Could_contracted_labor_be_used_App_Setup__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Could Contracted labour be used'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Funds_available_for_contracted_labor_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Funds available for contracted labor'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Will_the_project_replace_staff_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Will the project replace staff'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Could_inclement_weather_impact_plan_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Could inclement weather impact plan'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Additional_background_checks_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Additional background checks'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Possible_hazardous_waste_exposre_App_Sec__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Possible_work_with_hazardous_chemicl_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Possible_health_restrictions_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional__c==true && applicationInput.Project_permissions_permits_secured_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Project Permissions permits secured'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c==true && applicationInput.Disaster_Type_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Disaster Type'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c==true && applicationInput.Possible_hazardous_waste_exposure_App__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c==true && applicationInput.Possible_work_with_hazardous_chemical_Ap__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c==true && applicationInput.Possible_health_restrictions_Ap__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response__c==true && applicationInput.Project_permissions_permits_secured_Ap__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Project Permissions permits secured'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All_Concept_Paper__c==true && applicationInput.How_many_teams_are_being_requested_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for How many teams required'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All_Concept_Paper__c==true && applicationInput.Number_of_weeks_to_complete_project_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Number of weeks to complete project'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_All_Concept_Paper__c==true && applicationInput.Ability_to_sustain_project_s_outcomes_Co__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Ability to sustain projects outcome'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Could_contracted_labor_be_used_Concept__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Could Contracted labour be used'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Funds_available_for_contracted_labor_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Funds available for contracted labor'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Will_the_project_replace_staff_Concept__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Will the project replace staff'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Could_inclement_weather_impact_plan_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Could inclement weather impact plan'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Additional_background_checks_Concept__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Additional background checks'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Possible_hazardous_waste_exposure_concep__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Possible_work_with_hazardous_chemicl_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Possible_health_restrictions_Concept__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Concept_paper__c==true && applicationInput.Project_permissions_permits_secured_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Project Permissions permits secured'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c==true && applicationInput.Disaster_Type_Con_Paper__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Disaster Type'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c==true && applicationInput.Possible_hazardous_waste_exposure_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Hazardous Waste Exposure'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c==true && applicationInput.Possible_work_with_hazardous_chemicl_Co__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible work with Hazardous Chemicals'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c==true && applicationInput.Possible_health_restrictions_Con__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Possible Health Restrictions'));
        return false;
    }
if(applicationInput.RecordTypeId == Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId() &&applicationInput.NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c==true && applicationInput.Project_permissions_permits_secured_Co__c == null){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter a value for Project Permissions permits secured'));
        return false;
    }
    
    
                          return true;
    }
  // methods added for withdraw justification popup and new buttons--sowmya 11/29/2016  
    public boolean outputpanelwithdrawrender{get;set;}
     public void waitlist()
    {
   outputpanelwithdrawrender = true;
    }
    
    public pagereference panelsave()
    {
     applicationInput.Status__c = 'Waitlisted';
    applicationInput.Grantee_Status__c  = 'Waitlisted'; 
    update applicationInput;
    Pagereference Redirect;
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
    outputpanelwithdrawrender = false;
     redirect.setredirect(true);
            return redirect;
    }
    
    public void cancelButton(){
    outputpanelwithdrawrender = false;
    }
    
    public pagereference deny()
    {
    applicationInput.Status__c = 'Denied';
    applicationInput.Grantee_Status__c  = 'Denied'; 
    update applicationInput;
    Pagereference Redirect;
    Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
           redirect.setredirect(true);
            return redirect;
    }
    
    public pagereference approveForNCCC()
    {
      applicationInput.status__c = 'SPO Approval/Denial Waitlist';
       applicationInput.Grantee_Status__c  = 'SPO Approval/Denial Waitlist'; 
               update applicationInput;
               Pagereference Redirect;
               Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
               redirect.setredirect(true);
                 return redirect;
              }
        
  
    
  // end of code -- sowmya 11/29/2016
    
    public PageReference sendNCNotification(){
        Pagereference Redirect;
        String tmpName = 'Non_Compliant_Notification';
        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+applicationInput.Applicant_User__r.Email+'&appId='+applicationInput.Id);
        return Redirect;
    }
    
    public PageReference sendNCAfterReExam(){
        Pagereference Redirect;
        String tmpName = 'Non_Compliance_After_Re_Examination';
        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+applicationInput.Applicant_User__r.Email+'&appId='+applicationInput.Id);
        return Redirect;
    }
    
    public PageReference sendAcceptedEmail(){
        Pagereference Redirect;
        String tmpName = 'Appeal_Approved_Notification';
        Redirect = new PageReference('/apex/CustomSendEmail?tmpName='+tmpName+'&toAddresses='+applicationInput.Applicant_User__r.Email+'&appId='+applicationInput.Id);
        return Redirect;
    }
    
    // Approval action for Sub-Applications. US # 2723. KY. 1.19.16  
    public pageReference RecommendedtoCNCS(){
        try{ 
            PageReference Redirect;
            If(id!=null && id!=''){         
                applicationInput.Status__c='Recommended to CNCS';
                applicationInput.Grantee_Status__c='Recommended to CNCS';
                update applicationInput;
                Redirect = new PageReference('/apex/CombinedDetailPage?id='+id);
                Redirect.setRedirect(true);
                return Redirect;
            }
         }catch(exception exc){
             System.debug('exc'+exc);
         }   
        return null;
    }
    // End actions for sub-applications. 
    
    Public pageReference confirmsign(){
        // esign
        Recordid = ApexPages.currentPage().getParameters().get('id');
        Application3__c App = [select Organization__c,Authorized_Representative__c,Assurances_Clicked__c,Certifications_Clicked__c,Application_Signed__c,Status__c,Grantee_Status__c from Application3__c where id =: Recordid];
        System.debug('user is'+userinfo.getuseremail());
        string emailvalue = userinfo.getuseremail();
        try{
            Contact cont = [select id from contact where email =: emailvalue and accountId = :App.Organization__c limit 1];
            system.debug('Assurances_Clicked__c = '+app.Assurances_Clicked__c+' Certifications_Clicked__c = '+app.Certifications_Clicked__c);
            if(app.Certifications_Clicked__c && app.Assurances_Clicked__c){
                App.Authorized_Representative__c = cont.id;
                App.Application_Signed__c = true;            
                App.Grantee_Status__c = 'Signed';
                try{
                     update App;
                     PageReference p = new PageReference('javascript:window.opener.history.go(0);self.close();');
                     p.setRedirect(true);
                     return p;
                }
                Catch(exception e){
                     System.debug('The following exception has occurred: ' + e.getMessage());
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You must view the Assurances and Certifications before you can confirm your electronic signature.'));
                return null;
            }
            return null;
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You must view the Assurances and Certifications before you can confirm your electronic signature.'));
            return null;
        }
    }

    Public pagereference reload(){
        PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public void setAssurances(){
        system.debug('app '+applicationInput);
        if(applicationInput!=null){
            applicationInput.Assurances_Clicked__c = true;
            update applicationInput;
        }
        system.debug('Assurances_Clicked__c = '+applicationInput.Assurances_Clicked__c+' Certifications_Clicked__c = '+applicationInput.Certifications_Clicked__c);
    }
    
    public void setCertifications(){
        system.debug('app '+applicationInput);
        Recordid = ApexPages.currentPage().getParameters().get('id');
        Application3__c App = [select Authorized_Representative__c,Assurances_Clicked__c,Certifications_Clicked__c from Application3__c where id =: Recordid];
        if(App!=null){
            App.Certifications_Clicked__c = true;
            update App;
        }
        system.debug('Assurances_Clicked__c = '+App.Assurances_Clicked__c+' Certifications_Clicked__c = '+App.Certifications_Clicked__c);
    }
    
    public Boolean isRequiredTotalRecommendedMSYs(String strAppId){
    Boolean flagMembersSection=false;

                try{
                List<cb3__Budget__c> lstBdgApps=[SELECT id,name,cb3__Title__c,cb3__BudgetForCurrentApplicationYear__c,
                (SELECT id,name   
                FROM cb3__BudgetApplicationBudgetLines__r 
                WHERE cb3__BudgetSection__r.cb3__isMembers__c=true ) 
                FROM cb3__Budget__c
                WHERE Parent__c= :strAppId 
                and cb3__BudgetForCurrentApplicationYear__c=true];

                System.debug('***lstBdgApps'+lstBdgApps);
                for(cb3__Budget__c objBdgApp :lstBdgApps){
                System.debug('***objBdgApp'+objBdgApp);
                    if(objBdgApp.cb3__BudgetApplicationBudgetLines__r!=null && objBdgApp.cb3__BudgetApplicationBudgetLines__r.size()>0){
                     flagMembersSection=true;
                     break;
                    }
                 }
                 }
                    catch(QueryException qryExc){
                                    System.debug('QueryException in method isRequiredTotalRecommendedMSYs'+ qryExc.getMessage());
                    }
                    catch(Exception exc){
                                    System.debug('Exception in method isRequiredTotalRecommendedMSYs'+ exc.getMessage());
                    }
                    return flagMembersSection;
}


}