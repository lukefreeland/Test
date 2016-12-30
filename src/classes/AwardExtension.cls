Public Class AwardExtension{

    public AwardExtension() {

    }

public Award__c awarddetail {get; set;}
// public Award__c awardinput {get; set;}
Public List<Application3__c> app_Clonedfrom_List;
public Application3__c applicationInput {get; set;}
public String id;
public String appid;
public GroupMember gm {get;set;}
Public Boolean showPOButton{get;set;}
Public Boolean showSPOButton{get;set;}
Public Boolean showGOButton{get;set;}
Public Boolean showXOButton{get;set;}
Public Boolean showSGOButton{get;set;}
Public Boolean showEditButton{get;set;}
public List<Team_Assignment__c> TAList;
public List<Attachment__c> AttachList;

 public string userpwd {get;set;}

  // esign
  public string  Name{get;set;}
  public Boolean Check{get;set;}
  Public Id Recordid{get;set;}  
  // esign
  
  
  public String strAwardName;    //added for MomIntg

Public Awardextension(ApexPages.StandardController controller){
 awarddetail=new Award__c();
 if (!Test.isRunningTest())
 {
   controller.addFields(new List<String>{'name','Grant_Number__c','Budget_Period_Start__c','Budget_Period_End__c','Master_Award__c','Master_Award__r.name',
                                         'Committed__c','Grant_Status__c','Application_Type__c','Prime_Application_Type__c','NOFA_Name__r.Cooperative_Agreement__c',
                                         'Application_ID__r.Type_of_Application__c','NOFA_Name__r.Cash_Grants_Awards__c','Application_ID__r.Program_Type__c',
                                         'Application_ID__c','Master_Parent__c','Prime_Application__c','RecordTypeId'});
 }
 awarddetail = (Award__c)controller.getRecord();
 
 id=Apexpages.currentPage().getParameters().get('id');
 appid=Apexpages.currentPage().getParameters().get('appid');
 System.debug('emails'+appid +'jhjh'+id);
 System.debug('emails'+userinfo.getuseremail());
 strAwardName=awarddetail.name;                   //added for MomIntg
 System.debug('***strAwardName***'+strAwardName); //added for MomIntg

 try{
 
 if(userinfo.getuseremail()!=null){
    User u = [Select Id,Name,AccountId from User where Id = :userInfo.getUserId()];
    userpwd  = [select Encryptpassword__c from contact where email =: userinfo.getuseremail() and AccountId = :u.AccountId limit 1].Encryptpassword__c;    
    System.debug('userpwdd'+userpwd);
 }
 }
 catch(exception e)
 {
 }
 String gmid = Apexpages.currentPage().getParameters().get('gmid'); 
List<String> allGroupIDs = new List<String>();
for (GroupMember gm : [SELECT Id, group.id, group.name, group.type FROM GroupMember where (UserOrGroupId = :UserInfo.getUserId() AND group.type='Regular')]){
allGroupIDs.add(gm.group.id);
system.debug('tets@@'+gm);
}
gmid=userinfo.getUserId();
  If(gmid!=null) 
 List<GroupMember> gm=[Select id,UserOrGroupId from GroupMember where UserOrGroupId=:gmid];
 System.debug('@@@groupmember'+gmid);
 //For(GroupMember m:[Select id,UserOrGroupId from GroupMember where GroupId=:gmid]){
 //System.debug('@@@groupmember'+m);
 //}
 // User loggedinUser = [Select id,name from user where id=:userinfo.getUserId()];
     //awarddetail.PO__c = loggedinUser;
 //awarddetail.PO__c= Userinfo.getUserId();
   
  If(id!=null && id!='')
  awarddetail=[select id,Name,Can_I_amend__c,Organization__c,Project_Title__c,Grants_Office_Comments__c,Approved_Amount__c,Application_ID__r.NOFA_RFP__r.Fiscal_Yr__c, Application_ID__r.NOFA_RFP__r.Corporate_Program__r.Short_Code__c,Corporate_Program1__c,Prime_Application__c,RecordTypeId,Master_Award__c,Being_Committed__c,Application_ID__r.Satisfactory_Record_Executing_Programs__c,Application_ID__r.Organization__r.Name,Application_ID__r.Demonstrates_Ethics_Integrity__c,Application_ID__r.Mitigating_Circumstances__c,Organization_re_Signature__c,Application_ID__r.Organization__r.Registration_Active_until__c,Application_ID__r.Organization__r.CCR_Verified__c,Award_Flow__c,Application_ID__r.Type_of_Application__c,Max_of_sub_budgets_per_application__c,Obligated__c,eSigned__c,Awaiting_SGO_Approval__c,Match_Status__c,Sub_budgets_for_multi_year_grants__c,Budget_Period_End__c,Budget_Period_Start__c,Amendment__c,NOFA_Name__r.Corporate_Program__c,NOFA_Name__r.Cash_Grants_Awards__c,Grant_Performance_Period_Start__c,Grant_Performance_Period_End__c,Sponsor_e_Signature__c,NOFA_Name__r.Cooperative_Agreement__c ,Committed__c, Amendment_Reason__c,OwnerId,Amendment_Type__c,Application_ID__c,
  Cost_Share__c,Application_Type__c,Award_Description__c,Executive_Officer__c,XO_CSHR__c,Fund_Commitment_Comments__c,Grant__c,Grants_Officer__c,Grant_Status__c,NOFA_Name__c,Corporate_Program__c,CNCS_Corporate_Program__c,Organization_Legal_Name__c,
  POs__c,PO__c,PO_Certification_Date__c,PO_Comments__c,Program_Officer__c,Project_End_Date__c,Project_Name__c,Project_Start_Date__c,Senior_Grants_Officer__c,Senior_Program_Officer__c,SPO__c,SPO_Certification_Date__c,
  Red_Flag_Count__c, Red_Flags__c,  Year_of_Grant__c,FAPIIS_Review_Comments__c,Application_ID__r.Organization__r.IG_Audit_in_progress__c,Mitigating_Circumstances__c,Information_Available__c,Subject_to_FAPIIS_Review__c,FAPIIS_Review_Date__c,Demonstrates_Ethics_Integrity__c,Satisfactory_Record_Executing_Programs__c,Master_Award__r.name,
  Application_ID__r.Executive_Summary__c,Application_ID__r.Organizational_Capability__c,Application_ID__r.Program_Design__c,Application_ID__r.Program_Management__c,Application_ID__r.Evaluation_Summary_or_Plan__c,
Application_ID__r.Recruitment_and_Development__c,Application_ID__r.Strengthen_Communities__c,Application_ID__r.Continuation_Changes__c,Application_ID__r.Clarification_Summary__c,Application_ID__r.Cost_Effectiveness_Budget_Adequacy__c,
Application_ID__r.Need__c,Application_ID__r.Intermediary_Justification__c,Application_ID__r.Tools_and_Equipment__c,Application_ID__r.Safety_and_Security__c,Application_ID__r.Other_Narrative__c,Application_ID__r.Summary_of_Accomplishments__c,Application_ID__r.VISTA_Assignment__c,Application_ID__r.Natural_and_Other_Disasters__c,Application_ID__r.Otherobjectives__c,Application_ID__r.Energy_Conservation__c,
Application_ID__r.If_other_please_specify_Energy__c,Application_ID__r.Environmental_Stewardship_Conservation__c,Application_ID__r.If_other_please_specify_Enivronment__c,Application_ID__r.Infrastructure_Improvement__c,Application_ID__r.If_other_please_specify_Infrastructure__c,Application_ID__r.Urban_and_Rural_Development__c,
Application_ID__r.If_other_please_specify_Urban__c,Application_ID__r.Education__c,Application_ID__r.If_other_please_specify_education__c,Application_ID__r.Veterans_Military_Families__c,Application_ID__r.If_other_please_specify_Veterns__c,Application_ID__r.Disaster_Services__c,
Application_ID__r.If_other_please_specify_disaster__c,Application_ID__r.Environmental_Stewardship__c,Application_ID__r.If_other_please_specify_Enivironment_Ste__c,Application_ID__r.Healthy_Futures__c,Application_ID__r.If_other_please_specify_Health__c,Application_ID__r.Economic_Opportunities__c,
Application_ID__r.If_other_please_specify_Economic__c,Application_ID__r.Capacity_Building__c,Application_ID__r.If_other_please_specify_capacity__c,Application_ID__r.Target_Populations1__c,Application_ID__r.Characteristics_Priorities__c,
Application_ID__r.NOFA_RFP_Summary__c,Application_ID__r.Organization__c,Application_ID__r.Authorized_Representative__c,Application_ID__r.Point_of_Contact__c,Application_ID__r.Assignee__c,Application_ID__r.Applicant_User__c,Application_ID__r.Withdraw_Justification__c,Application_ID__r.Amendment_Justification__c,
Application_ID__r.Project__c,Application_ID__r.Project_website_urls__c,Application_ID__r.Project_Directorss__c,Application_ID__r.Proposed_Start_Date_is__c,Application_ID__r.Proposed_End_Date_is__c,Application_ID__r.Select_a_round__c,Application_ID__r.How_many_teams_are_being_requested__c,Application_ID__r.Disaster_Type__c,
Application_ID__r.Campus__c,Application_ID__r.Project_Priority__c,Application_ID__r.Disaster_Number_Funding_DOE__c,Application_ID__r.Team_Mobility__c,Application_ID__r.Specify_if_you_want_to_be_in_more_rounds__c,Application_ID__r.Partner_Project_Code__c,
Application_ID__r.State_and_or_Territories__c,Application_ID__r.Counties__c,Application_ID__r.Other_Area_Affected_by_Project__c,Application_ID__r.EO_12372_Process__c,Application_ID__r.Additional_Information__c,Application_ID__r.Applicant_Delinquent_on_any_Federal_Debt__c,
Application_ID__r.If_Yes_provide_your_explination_here__c,Application_ID__r.State_Application_Identifier__c,Application_ID__r.Have_funding_history_with_any_CNCS_org__c,
Application_ID__r.Local_State_Federal_Government_Match__c,Application_ID__r.Private_Match__c,Application_ID__r.Total_Match_Dollars__c,Application_ID__r.Other_Revenue__c,Application_ID__r.Number_of_episodic_volunteers_generated__c,Application_ID__r.Number_of_ongoing_volunteers__c,
Application_ID__r.Number_of_members_wearing_logo_every_day__c,Application_ID__r.Number_of_elevator_speeches_created__c,Application_ID__r.AmeriCorps_logo_will_display_on_website__c,Application_ID__r.Focus_Area__c,Application_ID__r.Program_Type__c,Application_ID__r.Cost_Share__c,
Prime_Application__r.CNCS_Corporate_Program__c,Prime_Application__r.Competitive_or_Formula__c,Prime_Application__r.Project_Name__c,Prime_Application__r.Project_Title__c,Prime_Application__r.Program_Start_Date__c,Prime_Application__r.Program_End_Date__c,
Prime_Application__r.EO_12372_Process__c,Prime_Application__r.If_yes_please_explain__c,Prime_Application__r.Applicant_Delinquent_on_any_Federal_Debt__c,Application_ID__r.flagReturnForRework__c,
Prime_Application__r.If_yes_please_explain_app_delinque__c,Prime_Application__r.Sub_Concept_Paper_Due_Date__c,Prime_Application__r.Sub_Application_Due_Date__c,Application_ID__r.Status__c,
NOFO_RFP_Name_New__c,Issuing_Officer__c,of__c,Total_Recommended_MSYs__c,Application_ID__r.Parent_MSYs__c,Application_ID__r.Total_Recommended_MSYs__c,NOFA_Name__r.Issuing_Officer__c,Application_ID__r.Parent_CNCS_Share__c,Application_ID__r.Recommended_Award_Amount__c,
Application_ID__r.Sub_Application__c,Sub_Award__c,NOFO_RFP_Name_Prime__c,Prime_Application_Type__c,Issuing_Office__c,Organization_Legal_Name_Prime__c,Project_Title_Prime__c,Corporate_Program_Prime__c,Fiscal_Year_Prime__c,
Agreement_Period_Start_Date__c,Agreement_Period_End_Date__c,Grant_Performance_Period_Start_Date__c,Grant_Performance_Period_End_Date__c,Enrollment_Period_Start_Date__c,Enrollment_Period_End_Date__c,Project__c,Sent_to_XO_for_De_Commitment__c,VISTA_Approval_Flow__c,Master_Parent__c,Grants_Officer_Comments__c,Fund_Obligation_Comments__c,Prime_Application__r.Program_Type__c,Prime_Application__r.Type_of_Application__c,
Grants_Officer_Review_Completed__c,CCR_Verified__c,Registration_Active_Until__c,Excluded_Party_List_On__c,Verified_Via__c,Previous_Cycle_Closed__c,Financial_Management_Capability__c,Fed_Audit_Clearinghouse__c,DHHS_Print_Mgmt_System_c__c,Guidestar__c,SAM__c,FAPIIS__c
from Award__c where id=:id];

  if ((awarddetail.Grant_Status__c == 'Awaiting SPO Approval') || (awarddetail.Grant_Status__c == 'Awaiting SPO Award') ){
  awarddetail.OwnerId = awarddetail.Senior_Program_Officer__c;
  }
  else if(awarddetail.Grant_Status__c == 'Being Committed')  {
   awarddetail.OwnerId = awarddetail.Executive_Officer__c;
   }
   else if(awarddetail.Grant_Status__c == 'Awaiting GO Certification'){
   awarddetail.OwnerId = awarddetail.Grants_Officer__c;
   }
   else if((awarddetail.Grant_Status__c == 'Awaiting SGO Approval') || (awarddetail.Grant_Status__c == 'De-Obligated')){
   awarddetail.OwnerId = awarddetail.Senior_Grants_Officer__c;
   }  
   /* 
   else if(awarddetail.Grant_Status__c == 'Awaiting XO CSHR Approval'){
   awarddetail.OwnerId = awarddetail.XO_CSHR__c;
   system.debug('@@@@@PRASS');
   } 
   */
   else if(awarddetail.Grant_Status__c == 'Awaiting PO Certification'){
   awarddetail.OwnerId = awarddetail.Program_Officer__c;
   }  
   else
  {
awarddetail.OwnerId = awarddetail.OwnerId;
  }
  }
 //Rendering Logic----
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
  if( awarddetail.Ownerid==loggedinUserId)
  showEditButton=True;
  If(POGroupUserlist.contains(loggedinUserId))
  showPOButton=True;
  
  If(SPOGroupUserlist.contains(loggedinUserId))
  showSPOButton=True;
  
   If(GOGroupUserlist.contains(loggedinUserId))
   showGOButton=True;
   
    If(XOGroupUserlist.contains(loggedinUserId))
   showXOButton=True;
   
    If(SGOGroupUserlist.contains(loggedinUserId))
   showSGOButton=True;
   
    invokeNGAReports();
  }
    
 
 /*Award Action  
  public PageReference AwardApp() {           
if (awarddetail.Grant_Status__c != 'Obligated' || awarddetail.Grant_Status__c != 'Awaiting SGO Award'){
  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  return null;
}
else {
    awarddetail.Grant_Status__c='Awarded';
    }
update awarddetail;
//return Redirect;
return null;
} */

//Award Action  

//Amedment Button and method award and/or application has "Yes" for the "Allow Prime and Sub Applications,"
public PageReference Amend(){
    PageReference pg;
    Id SubAward = Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('Sub App Award').getRecordTypeId();
    Id AppAward= Schema.SObjectType.Award__c.getRecordTypeInfosByName().get('App Award').getRecordTypeId();
    List<Application3__c> app_List = new List<Application3__c>();
    Application3__c applicationInput;
           // List<Application3__c> awd=new List<Application3__c>();     
            app_List=[select id,Name,NOFA_RFP__r.Fiscal_Yr__c,NOFA_Name__c ,Grantee_Status__c,Executive_Summary__c,Organizational_Capability__c,Program_Design__c,Program_Management__c,Evaluation_Summary_or_Plan__c,
            Recruitment_and_Development__c,Strengthen_Communities__c,Amendment_Justification__c,Continuation_Changes__c,Clarification_Summary__c,Cost_Effectiveness_Budget_Adequacy__c,Need__c,Intermediary_Justification__c,
            Tools_and_Equipment__c,Safety_and_Security__c,Other_Narrative__c,Summary_of_Accomplishments__c,VISTA_Assignment__c,Natural_and_Other_Disasters__c,Otherobjectives__c,Energy_Conservation__c,If_other_please_specify_Energy__c,
            Environmental_Stewardship_Conservation__c,If_other_please_specify_Enivronment__c,Infrastructure_Improvement__c,If_other_please_specify_Infrastructure__c,Urban_and_Rural_Development__c,If_other_please_specify_Urban__c,
            Education__c,If_other_please_specify_education__c,Veterans_Military_Families__c,If_other_please_specify_Veterns__c,Disaster_Services__c,If_other_please_specify_disaster__c,Environmental_Stewardship__c,
            If_other_please_specify_Enivironment_Ste__c,Healthy_Futures__c,If_other_please_specify_Health__c,Economic_Opportunities__c,If_other_please_specify_Economic__c,Capacity_Building__c,If_other_please_specify_capacity__c,
            Target_Populations1__c,Characteristics_Priorities__c,NOFA_RFP_Summary__c,Organization__c,Authorized_Representative__c,Point_of_Contact__c,Assignee__c,Applicant_User__c,Withdraw_Justification__c,
            Project__c,Project_website_urls__c,Project_Directorss__c,Proposed_Start_Date_is__c,Proposed_End_Date_is__c,Select_a_round__c,How_many_teams_are_being_requested__c,Disaster_Type__c,Campus__c,Project_Priority__c,Disaster_Number_Funding_DOE__c,
            Partner_Project_Code__c,Team_Mobility__c,Specify_if_you_want_to_be_in_more_rounds__c,State_and_or_Territories__c,Counties__c,Other_Area_Affected_by_Project__c,EO_12372_Process__c,
            Additional_Information__c,Applicant_Delinquent_on_any_Federal_Debt__c,If_Yes_provide_your_explination_here__c,State_Application_Identifier__c,Have_funding_history_with_any_CNCS_org__c,Local_State_Federal_Government_Match__c,
            Private_Match__c,Total_Match_Dollars__c,Other_Revenue__c,Number_of_episodic_volunteers_generated__c,Number_of_ongoing_volunteers__c,Number_of_members_wearing_logo_every_day__c,Number_of_elevator_speeches_created__c,
            AmeriCorps_logo_will_display_on_website__c,Focus_Area__c,Program_Type__c,Cost_Share__c,Total_Recommended_MSYs__c,Recommended_Award_Amount__c,Parent_Application__c,Master_Parent__c,Module__c,Application_Signed__c,
            Certifications_Clicked__c,Assurances_Clicked__c,
            (Select Name, RecordTypeId, Accessible_for_people_with_disablities__c, Application__c, Beds_Provided__c, 
                                        CNCS_Funds_Requested__c, Capacity_Building__c, City__c, Description_of_Accessibility__c, Disaster_Services__c, 
                                        Distance_to_Location_of_Service__c, Economic_Opportunities__c, Education__c, Environmental_Stewardship__c, 
                                        Healthy_Futures__c, Is_this_a_K_12_school__c,   Kitchen__c, Laundry__c, 
                                        Legacy_Location_Id__c, Location_EIN__c, Location_Type__c, Lodging_Arrival_Date__c, Lodging_Category__c, 
                                        Lodging_Departure_Date__c, Lodging_Description__c, Lodging_Type__c, NCES_IDs__c, NOFA1__c, NOFA__c, 
                                        Number_of_Unduplicated_Volunteers__c, Number_of_Volunteers__c, Other_Capacity_Building__c, 
                                        Other_Disaster_Services__c, Other_Economic_Opportunities__c, Other_Education__c, Other_Environmental_Stewardship__c, 
                                        Other_Healthy_Futures__c, Other_Station_Type__c, Other_Veterans_Military_Families__c, Projected_End_Date__c, 
                                        Projected_Start_Date__c, Refrigerator_Microwave__c, School_City__c, School_ID_NCES__c, School_Name__c, School_State__c, 
                                        School_Street_Address_1__c, School_Street_Address_2__c, School_Zip__c, Shower__c, Site_Type__c, Slots__c, 
                                        State__c, Station_Type__c, Street_Address_1__c, Street_Address_2__c, Summer_Associates__c, Supervisor_Email__c, 
                                        Supervisor_Name__c, Supervisor_Organization__c, Supervisor_Phone_Number_Extension__c, Supervisor_Phone_Number__c, 
                                        Undisclosed_Location__c, Veterans_Military_Families__c, Veterans_Served__c, Zip__c, CNCS_Corporate_Structure__c, Latitude__c, 
                                        Longitude__c, NCES_ID__c, School_City_new__c, School_Zip_new__c, School_Street_Address_new__c, School_State_new__c
                                        From Locations__r),
                                        (Select   cb3__Title__c,  cb3__Status__c, cb3__BudgetYear__c,  cb3__BudgetForCurrentApplicationYear__c,  cb3__Application_Budget_Template__c,  
                                        cb3__ApplicationBudgetSettings__c, Parent__c,  Name,  Id  From Budget_Applications__r)       
            from Application3__c where id=:awarddetail.Application_ID__c];
            
            system.debug('pp#'+awarddetail.Recordtypeid);  
                if(SubAward==awarddetail.Recordtypeid && awarddetail.Application_ID__c!=null){
                 system.debug('%%%%%*****prashant'+SubAward);
                    for(Application3__c aa:app_List){ 
                        aa.Grantee_Status__c='In Progress';
                        aa.Type_of_Application__c='Amendment';
                    }
           
                   if(!app_List.isEmpty()){
                   update app_List;
                   pg = new PageReference('/'+app_List[0].id+'/e');
                   return pg;
                   }       
                return null;
                } 
    //Logic to clone prime application and relatedsub application
                else if(awarddetail.Prime_Application__c!=null){ 
                    List<Prime_Application__c> pa=new List<Prime_Application__c>(); 
                    app_Clonedfrom_List = new List<Application3__c>();             
                    List<Award__c> paw=new List<Award__c>();
                    Award__c primeappCloneFrom;
                    Prime_Application__c primeapp;
                    Prime_Application__c newClonedprimeapp = new Prime_Application__c();
                    System.debug('######@@@@#'+newClonedprimeapp);
  
                    newClonedprimeapp.clone(false,true);
                    newClonedprimeapp.Prime_Application_ID_Number__c=awarddetail.Name+'FromAwd';
                    newClonedprimeapp.NOFO_RFP__c=awarddetail.NOFA_Name__c;
                    newClonedprimeapp.Type_of_Application__c='Amendment';
                    newClonedprimeapp.CNCS_Status__c='In Progress';
    
                    Insert newClonedprimeapp;
                    System.debug('New_Cloned_Record_ID'+newClonedprimeapp.id);
  //Sub Application clone      

                     app_Clonedfrom_List = [Select id,name,Prime_Application__c from Application3__c where Prime_Application__c=:awarddetail.Prime_Application__c];
                     system.debug('######@@@@#'+awarddetail.Prime_Application__c);
                     system.debug('############'+app_Clonedfrom_List.Size());
                     for(Application3__c app : app_Clonedfrom_List){
                         system.debug('############'+app.name);
                         Application3__c appCopy = app.clone(false,true);
                         appCopy.name = app.name + '-Cloned';
                         appCopy.Prime_Application__c = newClonedprimeapp.Id;
                         appCopy.Amendable__c=true;
                         app_List.add(appCopy);
                     } 
                        if(!app_List.isEmpty())
                        Insert app_List;
                          
                       if(!app_Clonedfrom_List.isEmpty())  
                       Update app_Clonedfrom_List;
                            
                       pg= new PageReference('/'+newClonedprimeapp.id);
                       system.debug('pp#');
                      return pg;   
                    }
                      if(AppAward==awarddetail.Recordtypeid && awarddetail.Application_ID__c!=null){
                      PageReference pag;
                      for(Application3__c aap:app_List){                      
                          list<cb3__Budget__c> newBAs = new list<cb3__Budget__c>();
                          set<Id> baIds = new set<Id>();
                          map<String,Id> baNametoId = new map<String,Id>();
                          list<cb3__BudgetLine__c> newBls = new list<cb3__BudgetLine__c>();
                          list<cb3__BudgetLine3Lvl__c> newBlls = new list<cb3__BudgetLine3Lvl__c>();
                          
                          applicationInput= aap.clone(false,true);
                          applicationInput.Name=awarddetail.Application_ID__r.NOFA_RFP__r.Fiscal_Yr__c+ awarddetail.Application_ID__r.NOFA_RFP__r.Corporate_Program__r.Short_Code__c;
                          applicationInput.Status__c='In Progress'; 
                          applicationInput.Grantee_Status__c='In Progress';
                          applicationInput.Type_of_Application__c='Amendment';
                          applicationInput.Parent_Application__c = awarddetail.Application_ID__c;
                          applicationInput.Master_Parent__c = awarddetail.Master_Parent__c; 
                          if(applicationInput.Application_Signed__c){
                              applicationInput.Application_Signed__c = false;
                              applicationInput.Authorized_Representative__c = null;                           
                              applicationInput.Certifications_Clicked__c = false;
                              applicationInput.Assurances_Clicked__c = false;
                          }
                          //system.debug ('MasterParent'+awarddetail.Master_Parent__r.Id);
                          //applicationInput.Master_Parent__c = awarddetail.Master_Parent__r.Id;
                          /*
                          applicationInput.Executive_Summary__c = awarddetail.Application_ID__r.Executive_Summary__c;
                          applicationInput.Organizational_Capability__c = awarddetail.Application_ID__r.Organizational_Capability__c;
                          applicationInput.Program_Design__c = awarddetail.Application_ID__r.Program_Design__c;
                          applicationInput.Program_Management__c = awarddetail.Application_ID__r.Program_Management__c;
                          applicationInput.Evaluation_Summary_or_Plan__c = awarddetail.Application_ID__r.Evaluation_Summary_or_Plan__c;
                          applicationInput.Recruitment_and_Development__c = awarddetail.Application_ID__r.Recruitment_and_Development__c;
                          applicationInput.Strengthen_Communities__c = awarddetail.Application_ID__r.Strengthen_Communities__c;
                          applicationInput.Amendment_Justification__c = awarddetail.Application_ID__r.Amendment_Justification__c;
                          applicationInput.Continuation_Changes__c = awarddetail.Application_ID__r.Continuation_Changes__c;
                          applicationInput.Clarification_Summary__c = awarddetail.Application_ID__r.Clarification_Summary__c;
                          applicationInput.Cost_Effectiveness_Budget_Adequacy__c = awarddetail.Application_ID__r.Cost_Effectiveness_Budget_Adequacy__c;
                          applicationInput.Need__c = awarddetail.Application_ID__r.Need__c;
                          applicationInput.Intermediary_Justification__c = awarddetail.Application_ID__r.Intermediary_Justification__c;
                          applicationInput.Tools_and_Equipment__c = awarddetail.Application_ID__r.Tools_and_Equipment__c;
                          applicationInput.Safety_and_Security__c = awarddetail.Application_ID__r.Safety_and_Security__c;
                          applicationInput.Other_Narrative__c = awarddetail.Application_ID__r.Other_Narrative__c;
                          applicationInput.Summary_of_Accomplishments__c = awarddetail.Application_ID__r.Summary_of_Accomplishments__c;
                          applicationInput.VISTA_Assignment__c = awarddetail.Application_ID__r.VISTA_Assignment__c;
                          applicationInput.Natural_and_Other_Disasters__c = awarddetail.Application_ID__r.Natural_and_Other_Disasters__c;
                          applicationInput.Otherobjectives__c = awarddetail.Application_ID__r.Otherobjectives__c;
                          applicationInput.Energy_Conservation__c = awarddetail.Application_ID__r.Energy_Conservation__c;
                          applicationInput.If_other_please_specify_Energy__c = awarddetail.Application_ID__r.If_other_please_specify_Energy__c;
                          applicationInput.Environmental_Stewardship_Conservation__c = awarddetail.Application_ID__r.Environmental_Stewardship_Conservation__c;
                          applicationInput.If_other_please_specify_Enivronment__c = awarddetail.Application_ID__r.If_other_please_specify_Enivronment__c;
                          applicationInput.Infrastructure_Improvement__c = awarddetail.Application_ID__r.Infrastructure_Improvement__c;
                          applicationInput.If_other_please_specify_Infrastructure__c = awarddetail.Application_ID__r.If_other_please_specify_Infrastructure__c;
                          applicationInput.Urban_and_Rural_Development__c = awarddetail.Application_ID__r.Urban_and_Rural_Development__c;
                          applicationInput.If_other_please_specify_Urban__c = awarddetail.Application_ID__r.If_other_please_specify_Urban__c;
                          applicationInput.Education__c = awarddetail.Application_ID__r.Education__c;
                          applicationInput.If_other_please_specify_education__c = awarddetail.Application_ID__r.If_other_please_specify_education__c;
                          applicationInput.Veterans_Military_Families__c = awarddetail.Application_ID__r.Veterans_Military_Families__c;
                          applicationInput.If_other_please_specify_Veterns__c = awarddetail.Application_ID__r.If_other_please_specify_Veterns__c;
                          applicationInput.Disaster_Services__c = awarddetail.Application_ID__r.Disaster_Services__c;
                          applicationInput.If_other_please_specify_disaster__c = awarddetail.Application_ID__r.If_other_please_specify_disaster__c;
                          applicationInput.Environmental_Stewardship__c = awarddetail.Application_ID__r.Environmental_Stewardship__c;
                          applicationInput.If_other_please_specify_Enivironment_Ste__c = awarddetail.Application_ID__r.If_other_please_specify_Enivironment_Ste__c;
                          applicationInput.Healthy_Futures__c = awarddetail.Application_ID__r.Healthy_Futures__c;
                          applicationInput.If_other_please_specify_Health__c = awarddetail.Application_ID__r.If_other_please_specify_Health__c;
                          applicationInput.Economic_Opportunities__c = awarddetail.Application_ID__r.Economic_Opportunities__c;
                          applicationInput.If_other_please_specify_Economic__c = awarddetail.Application_ID__r.If_other_please_specify_Economic__c;
                          applicationInput.Capacity_Building__c = awarddetail.Application_ID__r.Capacity_Building__c;
                          applicationInput.If_other_please_specify_capacity__c = awarddetail.Application_ID__r.If_other_please_specify_capacity__c;
                          applicationInput.Target_Populations1__c = awarddetail.Application_ID__r.Target_Populations1__c;
                          applicationInput.Characteristics_Priorities__c = awarddetail.Application_ID__r.Characteristics_Priorities__c;
                          applicationInput.NOFA_RFP_Summary__c = awarddetail.Application_ID__r.NOFA_RFP_Summary__c;
                          applicationInput.Organization__c = awarddetail.Application_ID__r.Organization__c;
                          applicationInput.Authorized_Representative__c = awarddetail.Application_ID__r.Authorized_Representative__c;
                          applicationInput.Point_of_Contact__c = awarddetail.Application_ID__r.Point_of_Contact__c;
                          applicationInput.Assignee__c = awarddetail.Application_ID__r.Assignee__c;
                          applicationInput.Applicant_User__c = awarddetail.Application_ID__r.Applicant_User__c;
                          applicationInput.Withdraw_Justification__c = awarddetail.Application_ID__r.Withdraw_Justification__c;
                          applicationInput.Amendment_Justification__c = awarddetail.Application_ID__r.Amendment_Justification__c;
                          applicationInput.Project__c = awarddetail.Application_ID__r.Project__c;
                          applicationInput.Project_website_urls__c = awarddetail.Application_ID__r.Project_website_urls__c;
                          applicationInput.Project_Directorss__c = awarddetail.Application_ID__r.Project_Directorss__c;
                          applicationInput.Proposed_Start_Date_is__c = awarddetail.Application_ID__r.Proposed_Start_Date_is__c;
                          applicationInput.Proposed_End_Date_is__c = awarddetail.Application_ID__r.Proposed_End_Date_is__c;
                          applicationInput.Select_a_round__c = awarddetail.Application_ID__r.Select_a_round__c;
                          applicationInput.How_many_teams_are_being_requested__c = awarddetail.Application_ID__r.How_many_teams_are_being_requested__c;
                          applicationInput.Disaster_Type__c = awarddetail.Application_ID__r.Disaster_Type__c;
                          applicationInput.Campus__c = awarddetail.Application_ID__r.Campus__c;
                          applicationInput.Project_Priority__c = awarddetail.Application_ID__r.Project_Priority__c;
                          applicationInput.Disaster_Number_Funding_DOE__c = awarddetail.Application_ID__r.Disaster_Number_Funding_DOE__c;
                          applicationInput.Partner_Project_Code__c = awarddetail.Application_ID__r.Partner_Project_Code__c;
                          applicationInput.Team_Mobility__c = awarddetail.Application_ID__r.Team_Mobility__c;
                          applicationInput.Specify_if_you_want_to_be_in_more_rounds__c = awarddetail.Application_ID__r.Specify_if_you_want_to_be_in_more_rounds__c;
                          applicationInput.Partner_Project_Code__c = awarddetail.Application_ID__r.Partner_Project_Code__c;
                          applicationInput.State_and_or_Territories__c = awarddetail.Application_ID__r.State_and_or_Territories__c;
                          applicationInput.Counties__c = awarddetail.Application_ID__r.Counties__c;
                          applicationInput.Other_Area_Affected_by_Project__c = awarddetail.Application_ID__r.Other_Area_Affected_by_Project__c;
                          applicationInput.EO_12372_Process__c = awarddetail.Application_ID__r.EO_12372_Process__c;
                          applicationInput.Additional_Information__c = awarddetail.Application_ID__r.Additional_Information__c;
                          applicationInput.Applicant_Delinquent_on_any_Federal_Debt__c = awarddetail.Application_ID__r.Applicant_Delinquent_on_any_Federal_Debt__c;
                          applicationInput.If_Yes_provide_your_explination_here__c = awarddetail.Application_ID__r.If_Yes_provide_your_explination_here__c;
                          applicationInput.State_Application_Identifier__c = awarddetail.Application_ID__r.State_Application_Identifier__c;
                          applicationInput.Have_funding_history_with_any_CNCS_org__c = awarddetail.Application_ID__r.Have_funding_history_with_any_CNCS_org__c;
                          applicationInput.Local_State_Federal_Government_Match__c = awarddetail.Application_ID__r.Local_State_Federal_Government_Match__c;
                          applicationInput.Private_Match__c = awarddetail.Application_ID__r.Private_Match__c;
                          applicationInput.Total_Match_Dollars__c = awarddetail.Application_ID__r.Total_Match_Dollars__c;
                          applicationInput.Other_Revenue__c = awarddetail.Application_ID__r.Other_Revenue__c;
                          applicationInput.Number_of_episodic_volunteers_generated__c = awarddetail.Application_ID__r.Number_of_episodic_volunteers_generated__c;
                          applicationInput.Number_of_ongoing_volunteers__c = awarddetail.Application_ID__r.Number_of_ongoing_volunteers__c;
                          applicationInput.Number_of_members_wearing_logo_every_day__c = awarddetail.Application_ID__r.Number_of_members_wearing_logo_every_day__c;
                          applicationInput.Number_of_elevator_speeches_created__c = awarddetail.Application_ID__r.Number_of_elevator_speeches_created__c;
                          applicationInput.AmeriCorps_logo_will_display_on_website__c = awarddetail.Application_ID__r.AmeriCorps_logo_will_display_on_website__c;
                          applicationInput.Focus_Area__c = awarddetail.Application_ID__r.Focus_Area__c;
                          applicationInput.Program_Type__c = awarddetail.Application_ID__r.Program_Type__c;
                          applicationInput.Cost_Share__c = awarddetail.Application_ID__r.Cost_Share__c;
                          applicationInput.Parent_MSYs__c = awarddetail.Total_Recommended_MSYs__c;
                          applicationInput.Parent_CNCS_Share__c = awarddetail.Recommended_Award_Amount__c;
                          */
                      
                           insert applicationInput;
                           
                           list<Location__c> newLocs = new list<Location__c>();
                           if(aap.Locations__r.size()>0){
                                for(Location__c l: aap.Locations__r){
                                    Location__c newLoc = l.clone();
                                    newLoc.Application__c = applicationInput.Id;
                                    newLocs.add(newLoc);                                                
                                }
                           }
                           if(newLocs.size()>0){
                                insert newLocs;
                           }
                           
                           for(cb3__Budget__c ba: aap.Budget_Applications__r){
                                cb3__Budget__c newBA = ba.clone();
                                newBA.Parent__c = applicationInput.Id;
                                newBA.cb3__Status__c = 'Draft';
                                newBAs.add(newBA);       
                                baIds.add(ba.Id);                               
                           }        
                           if(newBAs.size()>0){
                                insert newBAs;
                                for(cb3__Budget__c ba: newBAs){
                                    baNametoId.put(ba.cb3__Title__c,ba.Id);
                                }
                                
                           } 
        
                           list<cb3__Budget__c> originalBAs = new list<cb3__Budget__c>([Select Id,cb3__Title__c,(Select cb3__inUnits__c, cb3__Total__c, cb3__TotalAmount__c, 
                                                                        cb3__SelectedIndirectCostRate__c, cb3__SectionName__c, cb3__Rate__c, 
                                                                        cb3__RateError__c, cb3__QTotal__c, cb3__Q4__c, cb3__Q3__c, cb3__Q2__c, 
                                                                        cb3__Q1__c, cb3__PreDefined__c, cb3__PlannedTotal__c, cb3__Percentage__c,
                                                                         cb3__PercentageError__c, cb3__P4__c, cb3__P3__c, cb3__P2__c, 
                                                                        cb3__P1__c, cb3__Organization__c, cb3__OnlyTotalError__c, cb3__LinesTotal__c, 
                                                                        cb3__IndirectPercentage__c, cb3__IndirectPercentageError__c, 
                                                                        cb3__IndirectCost__c, cb3__IndirectCostError__c, cb3__Description__c, 
                                                                        cb3__Description2__c, cb3__Col3Error__c, cb3__Col2Error__c, 
                                                                        cb3__Col1Error__c, cb3__CTotal__c, cb3__CQ4__c, cb3__CQ3__c, 
                                                                        cb3__CQ2__c, cb3__CQ1__c, cb3__CP4__c, cb3__CP3__c, cb3__CP2__c, cb3__CP1__c, 
                                                                        cb3__CLinesTotal__c, cb3__BudgetSection__c, cb3__BudgetLine__c, cb3__BudgetApplication__c,
                                                                         cb3__BudgetApplicationName__c, cb3__AttentionMessage__c, 
                                                                        cb3__AmountError__c, cb3__Address__c, cb3__Account__c, cb3__ATotal__c, cb3__A4__c, cb3__A3__c, cb3__A2__c, cb3__A1__c, PrimeApplicationId__c, 
                                                                        Name, BudgetFormCBAPAcct4__c, BudgetFormCBAPAcct3__c, BudgetFormCBAPAcct2__c,
                                                                        BudgetFormCBAPAcct1__c, ApplicationId__c 
                                                                        From cb3__BudgetApplicationBudgetLines__r), 
                                                                                (Select cb3__Total__c, cb3__Description__c, cb3__CTotal__c, cb3__BudgetApplication__c, 
                                                                                cb3__BudgetApplicationSourceType__c, cb3__BudgetApplicationSourceTypeStr__c, 
                                                                                cb3__BudgetApplicationAmountClassification__c, cb3__BudgetApplicationAmountClassificationStr__c, 
                                                                                Name, Id From cb3__BudgetLine3Lvl__r) From cb3__Budget__c c where Id in :baIds]);
                                                                              
                            for(cb3__Budget__c ba: originalBAs){
                                if(ba.cb3__BudgetApplicationBudgetLines__r.size()>0){
                                    for(cb3__BudgetLine__c bl: ba.cb3__BudgetApplicationBudgetLines__r){
                                        cb3__BudgetLine__c newBL = new cb3__BudgetLine__c();
                                        newBL = bl.Clone();
                                        newBL.cb3__BudgetApplication__c = baNametoId.get(ba.cb3__Title__c);
                                        newBLs.add(newBL);
                                    }               
                                }
                                if(ba.cb3__BudgetLine3Lvl__r.size()>0){
                                    for(cb3__BudgetLine3Lvl__c  bll: ba.cb3__BudgetLine3Lvl__r){
                                        cb3__BudgetLine3Lvl__c newbll = new cb3__BudgetLine3Lvl__c();
                                        newbll = bll.clone();
                                        newbll.cb3__BudgetApplication__c = baNametoId.get(ba.cb3__Title__c);
                                        newBlls.add(newbll);
                                    }   
                                }
                            }   
                            if(newBls.size()>0){
                                insert newBls;
                            }    
                            if(newblls.size()>0){
                                insert newBlls;
                            }     
        
                       
                      }
                            pag= new PageReference('/'+applicationInput.id); 
                            return pag;
                      }
                         
                            return null; 
}
   
               

  public PageReference AwardApp() { 
  
      ///invokeMomentumIntgForAward();          
    if ((awarddetail.Grant_Status__c == 'Obligated' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Awaiting SGO Award' && awarddetail.Sponsor_e_Signature__c==true) || (awarddetail.Grant_Status__c == 'Obligated'&& awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='No')){
          //if(awarddetail.Corporate_Program1__c!=null && awarddetail.Corporate_Program1__c.equalsIgnoreCase('AmeriCorps') && (
          
          ///
          //if(validateAwardAsAmericas()){
      
                Boolean goAheadFlag=invokeMomentumIntgForAward();
                if(!goAheadFlag) {
                    return null;
                 } 
          //}
          ///
    
       
        awarddetail.Grant_Status__c='Awarded'; 
        update awarddetail;
    }
    else {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
  
    }
    return null;
   }

    public Boolean invokeMomentumIntgForAward(){
       
       HttpResponse hResp;
       String json='';
       String strWSname='Award';
       String  endPointuri='';
       String  uName='';
       String  upassword='';
       String  httpMethodName='';
       String  contenttype='';
       Boolean goAheadFlag=false;
          
       CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
       try{
            
                Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                System.debug(objIntgr_MuleSoft);
                if(objIntgr_MuleSoft==null){
                        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service momentum integration for Award is not setUp'));
                        throw new CNCS_ObjectUtility.CustomException('Configuration for Web Service momentum integration for Award is not setUp');
                }
                endPointuri=objIntgr_MuleSoft.endPointuri__c;
                uName=objIntgr_MuleSoft.uName__c;
                upassword=objIntgr_MuleSoft.upassword__c;
                httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                contenttype=objIntgr_MuleSoft.contenttype__c;
                String strBody=composeBodyForMomIntgForAward();
                System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                
                hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                System.debug('***hResp***'+hResp);
                // the service is returning a line feed so parse it out
                json = hResp.getBody().replace('\n', '');
                System.debug('***json***'+json );
                
                ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                ParseJSONUtil.AwardForgrnt_idJSON    objAwardForgrnt_idJSON= new ParseJSONUtil.AwardForgrnt_idJSON();
                objAwardForgrnt_idJSON= objParseJSONUtil.parseAwardForgrnt_idJSON(json);
                System.debug('***objAwardForgrnt_idJSON'+objAwardForgrnt_idJSON);
                List<ParseJSONUtil.AwardForgrnt_id> lstAwardForgrnt_id=objAwardForgrnt_idJSON.lstData;
                System.debug('***lstAwardForgrnt_id'+lstAwardForgrnt_id);
                if(lstAwardForgrnt_id!=null && lstAwardForgrnt_id.size() >0){
                     String p_status_cd=lstAwardForgrnt_id[0].p_status_cd;
                     if(p_status_cd!=null && p_status_cd!='' && p_status_cd.equalsignoreCase('Ok')){
                         goAheadFlag=true;
                     }else{
                          goAheadFlag=false;
                          throw new CNCS_ObjectUtility.CustomException('Exception -> '+ p_status_cd+' .'); 
                     } 
                     
                     /* if(p_status_cd!=null && p_status_cd!='' && !p_status_cd.equalsIgnoreCase('~Ok')){
                         throw new CNCS_ObjectUtility.CustomException('Exception -> '+ p_status_cd+' .'); 
                     }*/
                }
              
           }
          catch(System.CalloutException ce) {
              System.debug('Callout error: '+ ce);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,ce.getMessage()));
              //System.debug(resp.toString());
          }
          catch(System.DmlException de) {
              System.debug('Callout error: '+ de);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,de.getMessage()));
         }
         catch(CNCS_ObjectUtility.CustomException custExc) {
              System.debug('Custom Exception '+ custExc);
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
         }
         catch(Exception exc){
            System.debug('***exc***'+exc.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
         }
         return goAheadFlag;
    }
    
    
    
    public String composeBodyForMomIntgForAward(){
        String strBody ='{ "grnt_id":'+'"'+ strAwardName+'" }';
        return strBody;
    
    }
    
    public Boolean validateAwardAsAmericas(){
        Boolean flagAmericas=false;
        
       // List<Account> matchingAccounts = Database.query('SELECT id from Account where Name = \''+String.escapeSingleQuotes(your-account-name-var)+'\'' AND CustomName__c = \''+String.escapeSingleQuotes(your-customer-name-var)+'\''');
    
        String strQry='[ Select id,name,Application_ID__c,Grant_Number__c,Application_ID__r.name,Application_ID__r.NOFA_RFP__r.name,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.id,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__c,';
        strQry+=' Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name';
        strQry+=' FROM Award__c ';
       // strQry+=' WHERE ID='' ';
        strQry+=' WHERE ID=\'' +strAwardName+'\'';   
        strQry+=' ORDER by name]';                            
                                    
         Award__c objAward;
         /*   Award__c objAward= [Select id,name,Application_ID__c,Grant_Number__c,Application_ID__r.name,Application_ID__r.NOFA_RFP__r.name,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.id,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__c,
                                            Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name
                                    FROM Award__c 
                                    WHERE ID=''
                                    ORDER by name]; */
        try{                            
            objAward=    Database.query(strQry);
        } catch(Exception exc){
        
             System.debug('***exc***'+exc.getMessage()); 
        }                 
                                
        System.debug('***objAward***'+objAward);    
        if(objAward!=null &&objAward.Application_ID__r!=null && objAward.Application_ID__r.NOFA_RFP__r!=null  && 
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.name.equalsIgnoreCase('AmeriCorps') &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r!=null &&
                            objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name!=null &&
                            !objAward.Application_ID__r.NOFA_RFP__r.CNCS_Corporate_Program__r.CNCS_Corporate_Program_Name__r.name.contains('NCCC') )    {
            flagAmericas    =true;          
                            
        }
        return flagAmericas;
    
 }
    
/*
 // Approve Agreement by XO - Commit Funds button. 
    public PageReference ApproveAgreementbyXO() {  
        PageReference Redirect; 
         if (awarddetail.Being_Committed__c != True ) {    
          //  if (awarddetail.OwnerId != Userinfo.getUserId()){ // Commented on 6.8.16. Bug 7151
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Commit the Funds. '));                    
            return null;
            }
        else {
              ///
              //if(validateAwardAsAmericas()){
                    Boolean goAheadFlag=invokeMomentumIntgForAward();
                    if(!goAheadFlag) {
                        return null;
                     } 
              //   }
              ///   
               // awarddetail.Grant_Status__c='Awaiting GO Certification'; Status getting updated in "FundCommitmentForAwardCntrl" based on the response from Momentum. 
                awarddetail.Committed__c = True;
             // add new field created by Naveen.   
                update awarddetail;
                Redirect = new PageReference('/'+awarddetail.id);
                return Redirect;
        }
        //return Redirect;
        return null;
    }
    */
 
 //'Reject Application from PO Cert'. Awards can be Rejected only by PO and the when the status is "Awaiting PO Certification"
public PageReference reject() { 
    PageReference Redirect; 
    try { 
        // Check if the Status is 'Awaiting PO Certification'. Else show Error message. 
            if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Reject this Award". '));   
                return null;                 
    }
// If the Status is 'Awaiting PO Certification', change Status to 'Rejected'. 
    else {
            awarddetail.Grant_Status__c='Rejected';
            }
                update awarddetail;
                Redirect = new PageReference('/'+awarddetail.id);
                return Redirect;
    }
    catch(Exception exc){
               System.debug('exc'+exc);
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award for e-Signature due to '+exc));
     }
     return null;   
 }
 
 //'Withdraw Application' - Awards can be Withdrawn only by PO and the when the status is "Awaiting PO Certification". 
public PageReference Withdraw() {  
    PageReference Redirect; 
        try{ 
        // Check if the Status is 'Awaiting PO Certification'. Else show Error message.
            if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Withdraw this Award". '));   
                return null;       
            }
        // If the Status is 'Awaiting PO Certification', change Status to 'Withdrawn'.
            else {
            awarddetail.Grant_Status__c='Withdrawn';
            }
                update awarddetail;
                Redirect = new PageReference('/'+awarddetail.id);
                return Redirect;
        }
        catch (Exception ex){
                System.debug('ex'+ex);
              //  ApexPages.addMessages (new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Withdraw Award due to '+ex)); 
        }
            return null;
}

//'Return to Applicant for Rework'. Awards can be Returned for Re-work only by PO and the when the status is "Awaiting PO Certification". 
//This button changes the Statuses of both Application and Award to "Returned for Rework". 
 public PageReference ReturntoRework() {            
 PageReference Redirect;  
try{
// Check if the Status is 'Awaiting PO Certification'. Else show Error message.
 if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Return this Award to Rework". '));                    
        return null;
    }
    applicationinput =[select id,flagReturnForRework__c,Status__c from Application3__c where id=:awarddetail.Application_ID__c];
    system.debug('^^^^^^Return^^^^^'+applicationinput.flagReturnForRework__c);
    system.debug('^^^^^^Return1^^^^^'+applicationinput.Status__c);
// Update the Status of Award.  
    awarddetail.Grant_Status__c='Returned for Rework';
// Update the Status of Application.  
    applicationinput.Status__c = 'Returned for Rework';
    applicationinput.Grantee_Status__c = 'Return for Re-work';
// Check the below flags to True. 
    applicationinput.Return_For_Rework__c=true;
    applicationinput.flagReturnForRework__c=true;
    update applicationinput;
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    System.debug('*****&&&&&&)))))'+applicationinput.Status__c);
    // return null;
}
catch (exception e){
        System.debug('e'+e);
    //  ApexPages.addMessages (new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Return Award for Re-work due to '+e));    
}
return null;
}

// "Certify Application by PO" (PO, SPO).
 public PageReference CertifiyApplicationbyPO () {    
  PageReference Redirect;
  try{
// Check if the Status is 'Awaiting PO Certification'. Else show Error message.
        if (awarddetail.Grant_Status__c != 'Awaiting PO Certification'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
        return null;
        }
// Logic for Amendments - Issuing_Officer__c = HQ; 
        else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment'&& (awarddetail.Application_ID__r.Parent_MSYs__c == awarddetail.Application_ID__r.Total_Recommended_MSYs__c || awarddetail.Application_ID__r.Parent_CNCS_Share__c == awarddetail.Application_ID__r.Recommended_Award_Amount__c) && awarddetail.NOFA_Name__r.Issuing_Officer__c == 'HQ(Office of Grants Management)') {
            awarddetail.Grant_Status__c='Awaiting GO Certification';
        }
 // Logic for VISTA - Amendment Awards. No change in the Total MSYs or Total CNCS Share and Issuing Office = HQ. PO/SPO sends award directly to GO       
        else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment'&& (awarddetail.Application_ID__r.Parent_MSYs__c == awarddetail.Application_ID__r.Total_Recommended_MSYs__c || awarddetail.Application_ID__r.Parent_CNCS_Share__c == awarddetail.Application_ID__r.Recommended_Award_Amount__c) && awarddetail.NOFA_Name__r.Issuing_Officer__c == 'HQ(Office of Grants Management)' && (awarddetail.Corporate_Program1__c == 'VISTA State' || awarddetail.Corporate_Program1__c == 'VISTA Headquarters')){
            awarddetail.Grant_Status__c='Awaiting GO Certification';
            awarddetail.VISTA_Approval_Flow__c = 'A';
        }
   // Logic for VISTA - Amendment Awards. No change in the Total MSYs or Total CNCS Share and Issuing Office = FFMC.       
       /*   else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment'&& (awarddetail.Application_ID__r.Parent_MSYs__c == awarddetail.Application_ID__r.Total_Recommended_MSYs__c || awarddetail.Application_ID__r.Parent_CNCS_Share__c == awarddetail.Application_ID__r.Recommended_Award_Amount__c) && awarddetail.NOFA_Name__r.Issuing_Officer__c == 'FFMC' && (awarddetail.Corporate_Program1__c == 'VISTA State' || awarddetail.Corporate_Program1__c == 'VISTA Headquarters')){
            awarddetail.Grant_Status__c='Awaiting SPO Approval';
            //awarddetail.VISTA_Approval_Flow__c = 'A';
        }  
        */      
        else  {  
            awarddetail.Grant_Status__c='Awaiting SPO Approval';
        }       
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
    }
    catch(exception e){
         System.debug('e'+e);
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Certify Award due to '+e));
         
    }
    return null;    
}

 // 'Approve Award Previously Certified by PO'. Certify Application by SPO. Status Changes from "Awaiting SPO Approval" to "Being Committed". 
public PageReference ApproveGrantpreviouslycertifiedbyPO () {    
    PageReference Redirect;
try{
// Check if the Award is Committed already. If Yes, show this error message. 
   /* if (awarddetail.Committed__c == True ){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award. '));                    
        return null;
    } */
// The Status should be "Awaiting SPO Approval" before it can be sent to XO User for Fund Commitment. 
     if (awarddetail.Grant_Status__c != 'Awaiting SPO Approval') {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Approve this Award. '));                    
        return null;
    }
    else {
        awarddetail.Grant_Status__c='Being Committed';
    }
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Certify Award due to '+e));         
}
    return null;
}

// 'Certify & Send to Organization for e-Signature'. (PO,SPO) 
// Status changes from "Awaiting PO Certification" to "Awaiting Sponsor e Signature".
// For Cash = Optional or No. 
public PageReference esign() {
PageReference Redirect;
    try{  
    // Check if the Status is 'Awaiting PO Certification'. Else show Error message. 
        if (awarddetail.Grant_Status__c != 'Awaiting PO Certification' ){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award for e-Signature". '));                    
            return null;        
        }
        else{
            awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
            awarddetail.VISTA_Approval_Flow__c = 'B';
        }
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
    }
    catch (exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send this Award for Signature due to '+e));    
    }
        return null;
}

// 'Certify Application Previously Committed' (SPO). For regular Awards, the Committed__c checkbox should be checked. 
// For Amendments, There is "Decrease in Total CNCS Share or Total MSYs" or "No change in Total CNCS Share or Total MSYs (Issuing Office = FFMC)" 
// Status changes from "Awaiting SPO Approval" to "Awaiting GO Certification"
public PageReference CertifyApplicationCommitted () {  
try {
    PageReference Redirect; 
// Check if the Status is 'Awaiting SPO Approval'. Else show Error message.
        if (awarddetail.Grant_Status__c!='Awaiting SPO Approval'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award. '));                    
            return null;  
        }   
// For New and Continuations, Check if the Committed__c checkbox is True and Status is not equal to 'Awaiting SGO Approval'. 
// For Amendments, check the status is not equal to 'Awaiting SGO Approval'. 
        else if ((awarddetail.Application_ID__r.Type_of_Application__c!='Amendment' && awarddetail.Committed__c == True && awarddetail.Grant_Status__c != 'Awaiting SGO Approval')|| (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c != 'Awaiting SGO Approval')) {
            awarddetail.Grant_Status__c='Awaiting GO Certification';
        }
        /*
// For Amendments, check the status is not equal to 'Awaiting SGO Approval'     
        else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c != 'Awaiting SGO Approval') {
            awarddetail.Grant_Status__c='Awaiting GO Certification';
        }   
        */    
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
}
catch (exception e) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Certify Award due to '+e)); 
}
    return null; 
}

// 'Return to SPO'. XO, GO and SGO returns back the Award to SPO. 
public PageReference sendtospo () {  
    PageReference Redirect;
 try{
// Check if the Logged in User is same as the Owner. 
    if (awarddetail.OwnerId != Userinfo.getUserId()){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to SPO. '));                    
        return null;
    }
// Change the Status to 'Awaiting SPO Approval'. 
    else {
        awarddetail.Grant_Status__c='Awaiting SPO Approval';
        }   
    update awarddetail;     
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
 }
 catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to SPO due to '+e));             
 }
    return null;
}

 // 'Return to GO'. SGO returns back the Award to GO. 
 public PageReference sendtoGO () { 
    PageReference Redirect;
// Check if the Logged in User is same as the Owner OR the Status is not ???? 
try{
    if (awarddetail.OwnerId != Userinfo.getUserId() || awarddetail.Grant_Status__c!='Awaiting SGO Approval'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to GO". '));                    
        return null;
    }
// Change the Status to 'Awaiting GO Certification'. 
    else {
        awarddetail.Grant_Status__c='Awaiting GO Certification';
    }
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    //return null;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to GO due to '+e));          
 }
  return null;
 }
 
 // Return to PO. SPO, XO, GO and SGO returns back the Award to PO. 
 public PageReference sendtopo () {  
    PageReference Redirect;
try{
// Check if the Logged in User is same as the Owner.
    if (awarddetail.OwnerId != Userinfo.getUserId()){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to PO. '));                    
        return null;
    }
// Change the Status to 'Awaiting PO Certification'. 
    else {
    awarddetail.Grant_Status__c='Awaiting PO Certification';
    }
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    //return null;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to PO due to '+e));          
 }
    return null;
 }
 
 // 'Return to XO' - GO, SGO sends back the Award to XO. 
public PageReference returntoXO () {  
    PageReference Redirect;     
// Check if the Logged in User is same as the Owner and the Status is 'Awaiting SGO Approval' OR 'Awaiting GO Certification'. 
try{
    if (awarddetail.OwnerId != Userinfo.getUserId() && (awarddetail.Grant_Status__c!='Awaiting SGO Approval' || awarddetail.Grant_Status__c !='Awaiting GO Certification' ) ){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO. '));                    
        return null;
    }
    else {
// Change the Status to 'Being Committed'. 
        awarddetail.Grant_Status__c='Being Committed';
    }
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
 }
 catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to XO due to '+e));          
 }
    return null;
}

// 'Certify, Send to SGO'. GO Certifies and sends the Award to SGO. SGO can also take this action. 
public PageReference CertifytoSGO () {    
PageReference Redirect;
try{
// Added By Pratyusha
   if(awarddetail.Grants_Officer_Review_Completed__c== false )
    {
     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'The “Certify, Send to SGO” button cannot be clicked unless "Grants Officer Review Completed" checkbox is checked.'));                    
        return null;
    }
// The status should be 'Awaiting GO Certification' for the GO/SGO to take this action. 
    if (awarddetail.Grant_Status__c != 'Awaiting GO Certification'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Certify this Award". '));                    
        return null;
    }
// For Amendments and when there is a Decrease in Total CNCS Share or Total MSYs, change the Status to 'Awaiting SGO De-Obligation'. Included for VISTA. 
    else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && (awarddetail.Application_ID__r.Parent_MSYs__c > awarddetail.Application_ID__r.Total_Recommended_MSYs__c || awarddetail.Application_ID__r.Parent_CNCS_Share__c > awarddetail.Application_ID__r.Recommended_Award_Amount__c)){
        awarddetail.Grant_Status__c='Awaiting SGO De-Obligation';       
    }
    /*
    else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment'){
        awarddetail.Grant_Status__c='Awaiting SGO Approval';       
    }
    */
 // For Amendments and when there is a Increase in Total CNCS Share or Total MSYs or No change in Total CNCS Share or Total MSYs, change the Status to 'Awaiting SGO Approval'.  
 // Also for New and Continuations, change the status to 'Awaiting SGO Approval'. 
    else {
        awarddetail.Grant_Status__c='Awaiting SGO Approval';
    }
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to XO due to '+e));          
 }
    return null;
}

// 'Sign and Award Agreement'. SPO Awards the Award from 'Awaiting SPO Award'. 
public PageReference AwardnonCS() { 
    PageReference Redirect;  
    try{
    // The status should be 'Awaiting SPO Award' for the SPO to take this action.         
        if (awarddetail.Grant_Status__c != 'Awaiting SPO Award'){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
            return null;
        }
    // Change the Status to 'Awarded'. 
        else {
            awarddetail.Grant_Status__c='Awarded';
        }
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
    }
    catch(exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Award this Award due to '+e));          
     }
        return null;
}


// 'Certify and Send for Organization eSignature'. SGO sends the Award for Grantee User for e-Signature. 
public PageReference eSignaturebySGO () { 
    PageReference Redirect;  
    try{ 
        awarddetail.Grant_Status__c='Awaiting Organization e-Signature';
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
        //return null;
    }
    catch(exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award for e-Signature due to '+e));            
     }
        return null;
}

// 'Award New'. Changes the Status from 'Awaiting SGO Approval' to 'Awarded'. SGO action. 
// For Amendments and when there is no change in the Total MSYs or Total CNCS Share. 
public PageReference AwardNoChangeinAmount() {
    PageReference Redirect; 
    // The status should be 'Awaiting SGO Approval' for the SGO to take this action.   
try{    
    if (awarddetail.Grant_Status__c != 'Awaiting SGO Approval'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
        return null;
    }
    else {
        awarddetail.Grant_Status__c='Awarded';
    }
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;    
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award for e-Signature due to '+e));
 }
    return null;
}
 

// "Sign Agreement" button logic here. Grantee User signs the Agreement when the Status is "Awaiting Organization e-Signature". 
public PageReference confirmsign(){    
    Recordid = ApexPages.currentPage().getParameters().get('id');
    System.debug('Award is');
    //Award__c Award = [select eSigned__c from Award__c where id =: Recordid];
    awarddetail=[select id,Name,Organization__c,Project_Title__c,Grants_Office_Comments__c,Approved_Amount__c,Application_ID__r.NOFA_RFP__r.Fiscal_Yr__c, Application_ID__r.NOFA_RFP__r.Corporate_Program__r.Short_Code__c,Corporate_Program1__c,Prime_Application__c,Master_Award__c,Being_Committed__c,Application_ID__r.Satisfactory_Record_Executing_Programs__c,Application_ID__r.Organization__r.Name,Application_ID__r.Demonstrates_Ethics_Integrity__c,Application_ID__r.Mitigating_Circumstances__c,Organization_re_Signature__c,Application_ID__r.Organization__r.Registration_Active_until__c,Application_ID__r.Organization__r.CCR_Verified__c,Award_Flow__c,Application_ID__r.Type_of_Application__c,Max_of_sub_budgets_per_application__c,Obligated__c,eSigned__c,Awaiting_SGO_Approval__c,Match_Status__c,Sub_budgets_for_multi_year_grants__c,Budget_Period_End__c,Budget_Period_Start__c,Amendment__c,NOFA_Name__r.Corporate_Program__c,NOFA_Name__r.Cash_Grants_Awards__c,Grant_Performance_Period_Start__c,Grant_Performance_Period_End__c,Sponsor_e_Signature__c,NOFA_Name__r.Cooperative_Agreement__c ,Committed__c, Amendment_Reason__c,OwnerId,Amendment_Type__c,Application_ID__c,
            Cost_Share__c,Application_Type__c,Award_Description__c,Executive_Officer__c,XO_CSHR__c,Fund_Commitment_Comments__c,Grant__c,Grants_Officer__c,Grant_Status__c,NOFA_Name__c,Corporate_Program__c,CNCS_Corporate_Program__c,Organization_Legal_Name__c,
           POs__c,PO__c,PO_Certification_Date__c,PO_Comments__c,Program_Officer__c,Project_End_Date__c,Project_Name__c,Project_Start_Date__c,Senior_Grants_Officer__c,Senior_Program_Officer__c,SPO__c,SPO_Certification_Date__c,
            Red_Flag_Count__c, Red_Flags__c,  Year_of_Grant__c,FAPIIS_Review_Comments__c,Application_ID__r.Organization__r.IG_Audit_in_progress__c,Mitigating_Circumstances__c,Information_Available__c,Subject_to_FAPIIS_Review__c,FAPIIS_Review_Date__c,Demonstrates_Ethics_Integrity__c,Satisfactory_Record_Executing_Programs__c,Master_Award__r.name,
            Application_ID__r.Executive_Summary__c,Application_ID__r.Organizational_Capability__c,Application_ID__r.Program_Design__c,Application_ID__r.Program_Management__c,Application_ID__r.Evaluation_Summary_or_Plan__c,
          Application_ID__r.Recruitment_and_Development__c,Application_ID__r.Strengthen_Communities__c,Application_ID__r.Continuation_Changes__c,Application_ID__r.Clarification_Summary__c,Application_ID__r.Cost_Effectiveness_Budget_Adequacy__c,
          Application_ID__r.Need__c,Application_ID__r.Intermediary_Justification__c,Application_ID__r.Tools_and_Equipment__c,Application_ID__r.Safety_and_Security__c,Application_ID__r.Other_Narrative__c,Application_ID__r.Summary_of_Accomplishments__c,Application_ID__r.VISTA_Assignment__c,Application_ID__r.Natural_and_Other_Disasters__c,Application_ID__r.Otherobjectives__c,Application_ID__r.Energy_Conservation__c,
          Application_ID__r.If_other_please_specify_Energy__c,Application_ID__r.Environmental_Stewardship_Conservation__c,Application_ID__r.If_other_please_specify_Enivronment__c,Application_ID__r.Infrastructure_Improvement__c,Application_ID__r.If_other_please_specify_Infrastructure__c,Application_ID__r.Urban_and_Rural_Development__c,
          Application_ID__r.If_other_please_specify_Urban__c,Application_ID__r.Education__c,Application_ID__r.If_other_please_specify_education__c,Application_ID__r.Veterans_Military_Families__c,Application_ID__r.If_other_please_specify_Veterns__c,Application_ID__r.Disaster_Services__c,
          Application_ID__r.If_other_please_specify_disaster__c,Application_ID__r.Environmental_Stewardship__c,Application_ID__r.If_other_please_specify_Enivironment_Ste__c,Application_ID__r.Healthy_Futures__c,Application_ID__r.If_other_please_specify_Health__c,Application_ID__r.Economic_Opportunities__c,
          Application_ID__r.If_other_please_specify_Economic__c,Application_ID__r.Capacity_Building__c,Application_ID__r.If_other_please_specify_capacity__c,Application_ID__r.Target_Populations1__c,Application_ID__r.Characteristics_Priorities__c,
          Application_ID__r.NOFA_RFP_Summary__c,Application_ID__r.Organization__c,Application_ID__r.Authorized_Representative__c,Application_ID__r.Point_of_Contact__c,Application_ID__r.Assignee__c,Application_ID__r.Applicant_User__c,Application_ID__r.Withdraw_Justification__c,Application_ID__r.Amendment_Justification__c,
          Application_ID__r.Project__c,Application_ID__r.Project_website_urls__c,Application_ID__r.Project_Directorss__c,Application_ID__r.Proposed_Start_Date_is__c,Application_ID__r.Proposed_End_Date_is__c,Application_ID__r.Select_a_round__c,Application_ID__r.How_many_teams_are_being_requested__c,Application_ID__r.Disaster_Type__c,
          Application_ID__r.Campus__c,Application_ID__r.Project_Priority__c,Application_ID__r.Disaster_Number_Funding_DOE__c,Application_ID__r.Team_Mobility__c,Application_ID__r.Specify_if_you_want_to_be_in_more_rounds__c,Application_ID__r.Partner_Project_Code__c,
          Application_ID__r.State_and_or_Territories__c,Application_ID__r.Counties__c,Application_ID__r.Other_Area_Affected_by_Project__c,Application_ID__r.EO_12372_Process__c,Application_ID__r.Additional_Information__c,Application_ID__r.Applicant_Delinquent_on_any_Federal_Debt__c,
          Application_ID__r.If_Yes_provide_your_explination_here__c,Application_ID__r.State_Application_Identifier__c,Application_ID__r.Have_funding_history_with_any_CNCS_org__c,
          Application_ID__r.Local_State_Federal_Government_Match__c,Application_ID__r.Private_Match__c,Application_ID__r.Total_Match_Dollars__c,Application_ID__r.Other_Revenue__c,Application_ID__r.Number_of_episodic_volunteers_generated__c,Application_ID__r.Number_of_ongoing_volunteers__c,
          Application_ID__r.Number_of_members_wearing_logo_every_day__c,Application_ID__r.Number_of_elevator_speeches_created__c,Application_ID__r.AmeriCorps_logo_will_display_on_website__c,Application_ID__r.Focus_Area__c,Application_ID__r.Program_Type__c,Application_ID__r.Cost_Share__c,
          Prime_Application__r.CNCS_Corporate_Program__c,Prime_Application__r.Competitive_or_Formula__c,Prime_Application__r.Project_Name__c,Prime_Application__r.Project_Title__c,Prime_Application__r.Program_Start_Date__c,Prime_Application__r.Program_End_Date__c,
          Prime_Application__r.EO_12372_Process__c,Prime_Application__r.If_yes_please_explain__c,Prime_Application__r.Applicant_Delinquent_on_any_Federal_Debt__c,Application_ID__r.flagReturnForRework__c,
          Prime_Application__r.If_yes_please_explain_app_delinque__c,Prime_Application__r.Sub_Concept_Paper_Due_Date__c,Prime_Application__r.Sub_Application_Due_Date__c,Application_ID__r.Status__c,
          NOFO_RFP_Name_New__c,Issuing_Officer__c,of__c,Total_Recommended_MSYs__c,Application_ID__r.Parent_MSYs__c,Application_ID__r.Total_Recommended_MSYs__c,NOFA_Name__r.Issuing_Officer__c,Application_ID__r.Parent_CNCS_Share__c,Application_ID__r.Recommended_Award_Amount__c,
          Application_ID__r.Sub_Application__c,Sub_Award__c,NOFO_RFP_Name_Prime__c,Prime_Application_Type__c,Issuing_Office__c,Organization_Legal_Name_Prime__c,Project_Title_Prime__c,Corporate_Program_Prime__c,Fiscal_Year_Prime__c,
          Agreement_Period_Start_Date__c,Agreement_Period_End_Date__c,Grant_Performance_Period_Start_Date__c,Grant_Performance_Period_End_Date__c,Enrollment_Period_Start_Date__c,Enrollment_Period_End_Date__c,Project__c,Sent_to_XO_for_De_Commitment__c,VISTA_Approval_Flow__c,Fund_Obligation_Comments__c,Grants_Officer_Comments__c,Prime_Application__r.Program_Type__c,Prime_Application__r.Type_of_Application__c,Waitlist_Justification__c,
          Grants_Officer_Review_Completed__c,CCR_Verified__c,Registration_Active_Until__c,Excluded_Party_List_On__c,Verified_Via__c,Previous_Cycle_Closed__c,Financial_Management_Capability__c,Fed_Audit_Clearinghouse__c,DHHS_Print_Mgmt_System_c__c,Guidestar__c,SAM__c,FAPIIS__c
          from Award__c where id=:Recordid];     
          
          applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];       
    //System.debug('Award is'+Award );
try{
        if(!awarddetail.eSigned__c){
                awarddetail.eSigned__c = true;      
                awarddetail.Sponsor_e_Signature__c = true;
        }
        // Status changes to 'Awaiting SGO Obligation' as the SGO has not Obligated the Funds yet. Funds should be Obligated before it can be Awarded. Same for New, Continuations and Amendments. 
        if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c != true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO Obligation';
        }
        // Status changes to 'Awaiting SGO Award' as the SGO has already Obligated the Funds and the Award will be Ready to be Awarded. Same for New, Continuations and Amendments.
        else if (awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.Obligated__c == true && awarddetail.Awaiting_SGO_Approval__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO Award';
        }  
        else if (awarddetail.Application_ID__r.Type_of_Application__c!='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional' && awarddetail.Application_ID__r.Program_Type__c!='Standard'){
                awarddetail.Grant_Status__c='Awaiting SPO Approval';
        }   
        // For All Awards when Cash = 'No' or 'Optional'. 
        // Also, For Amendments, and when Corporate Program == VISTA and Program Type == Standard. 
        else if ((awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional' && awarddetail.Application_ID__r.Program_Type__c=='Standard')|| (awarddetail.Corporate_Program1__c != 'NCCC' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='No') || (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && (awarddetail.Corporate_Program1__c == 'VISTA STATE' || awarddetail.Corporate_Program1__c == 'VISTA Headquarters')&& awarddetail.Application_ID__r.Program_Type__c=='Standard') ){
                awarddetail.Grant_Status__c='Awaiting SPO Award';
        } 
        //  Added logic for Amendments. Cash = 'Yes' and COOP = 'Yes'.
        // Status changes to 'Awaiting SGO De-Obligation' as the SGO has not De-Obligated the Funds yet. Funds should be De-Obligated before it can be Awarded.
        else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.De_Obligated__c != true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO De-Obligation'; 
        }
        // Status changes to 'Awaiting SGO Award' as the SGO has De-Obligated the Funds and the Award will be Ready to be Awarded. For Amendments only.
        else if (awarddetail.Application_ID__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.De_Obligated__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO Award';
        }    
        // Prime Awards.    
         else if (awarddetail.Prime_Application__r.Type_of_Application__c!='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true  && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Optional' && awarddetail.Prime_Application__r.Program_Type__c!='Standard'){
                awarddetail.Grant_Status__c='Awaiting SPO Approval';
        }
        // Prime Awards. Status changes to 'Awaiting SGO De-Obligation' as the SGO has not De-Obligated the Funds yet. Funds should be De-Obligated before it can be Awarded.
        else if (awarddetail.Prime_Application__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.De_Obligated__c != true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO De-Obligation';
        }
        // Prime Awards. Status changes to 'Awaiting SGO Award' as the SGO has De-Obligated the Funds and the Award will be Ready to be Awarded. For Amendments only.
        else if (awarddetail.Prime_Application__r.Type_of_Application__c=='Amendment' && awarddetail.Grant_Status__c == 'Awaiting Organization e-Signature' && awarddetail.Sponsor_e_Signature__c==true && awarddetail.De_Obligated__c == true && awarddetail.NOFA_Name__r.Cash_Grants_Awards__c=='Yes' && awarddetail.NOFA_Name__r.Cooperative_Agreement__c=='Yes') {
                awarddetail.Grant_Status__c='Awaiting SGO Award';
        }  
        else if (awarddetail.Corporate_Program1__c == 'NCCC' && awarddetail .NOFA_Name__r.Cash_Grants_Awards__c=='No'){
                awarddetail.Grant_Status__c='Awaiting SPO Signature';
                applicationInput.Status__c = 'Awaiting SPO Signature';
        }         
            update awarddetail;
            update applicationInput;
            PageReference p = new PageReference('javascript:window.opener.history.go(0);self.close();');
      p.setRedirect(true);
            return p;
           
               
        }
        catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award for e-Signature due to '+e)); 
         return null;         
        }
        return null;
}

// 'Move application to next status without committing, - XO moves the Award to GO for a previously committed funds
public PageReference moveWithoutCommitting() { 
    PageReference Redirect;   
try{
// Check if the Committed__c checkbox is True and the Status is 'Being Committed'. This action can occur only after the Funds have been Committed by XO. 
        if (awarddetail.Grant_Status__c != 'Being Committed' && awarddetail.Committed__c == True) {
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot send this Award to GO". '));       
        return null;    
        }   
        else{
            awarddetail.Grant_Status__c='Awaiting GO Certification';               
        }
            update awarddetail;
            Redirect = new PageReference('/'+awarddetail.id);
            return Redirect;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Move Award to GO due to '+e));         
}
    return null;
}

// 'Move to Next Status without Obligating'. 
public PageReference MovetoAward() {  
    PageReference Redirect;  
try{
//Check if the Status is 'Awaiting SGO Approval'. 
    if (awarddetail.Grant_Status__c != 'Awaiting SGO Approval'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record if the Status is not "Awaiting SGO Approval". '));                    
        return null;
        }
    else {
        awarddetail.Grant_Status__c='Awarded';
        }
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Move Award to GO due to '+e));         
}
    return null;
}

// 'Sign Agreement and send to XO'. SPO sends the Award to XO once the Award is signed by the Grantee User. 
// Cash Optional; Increase in Total CNCS Share or Total MSYs
public PageReference SignAgreementtoXO () { 
PageReference Redirect;
try{
    if (awarddetail.Grant_Status__c != 'Awaiting SPO Approval'){
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO. '));                    
        return null;
        }
    else {
        awarddetail.Grant_Status__c='Being Committed';
    }
        update awarddetail;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
}
catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to XO due to '+e));         
}
    return null;
}

// 'Send to XO for De-Commitment'. For VISTA Amendments, SGO sends Award to XO for De-Commitment. 
public PageReference SendtoXOforDeCommitment (){
PageReference Redirect;

    try{
        if(awarddetail.Grant_Status__c != 'De-Obligated') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Send this Award to XO for De-Commitment. '));                    
            return null;
        }
        else {
            awarddetail.Grant_Status__c = 'Awaiting XO De-Commitment';
            awarddetail.Sent_to_XO_for_De_Commitment__c = true;
        }
            update awarddetail;
            Redirect = new PageReference('/'+awarddetail.id);
            return Redirect;
    }
    catch(exception e){
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send Award to XO for De-Commitment due to '+e));         
    }
            return null;
}


public pagereference reload(){
        PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    // Waitlist button. SPO takes this action on NCCC - Cash 'No' Awards.  
    public boolean outputpanelwaitlistrender{get;set;}
    public void waitlist(){
         outputpanelwaitlistrender = true;
    }
    
    public pagereference panelsave(){
        applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];
        applicationInput.Status__c = 'Waitlisted';
        applicationInput.Grantee_Status__c  = 'Waitlisted'; 
        awarddetail.Grant_Status__c = 'Waitlisted';
        update awarddetail;
        update applicationInput;
        Pagereference Redirect;
        Redirect = new PageReference('/apex/Awarddetailpage?id='+awarddetail.id);
        outputpanelwaitlistrender = false;
         redirect.setredirect(true);
         return redirect;
    }
    
    public void cancelButton(){
        outputpanelwaitlistrender = false;
    }
    
    // For NCCC Awards, SPO Approves the Award. Status of Award and Application changes to 'Pending Team Assignment'. 
public PageReference Approve() {            
 PageReference Redirect;  
try{
    applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];
// Update the Status of Award.  
    awarddetail.Grant_Status__c='Pending Team Assignment';
// Update the Status of Application.  
    applicationinput.Status__c = 'Pending Team Assignment';
    applicationinput.Grantee_Status__c = 'Pending Team Assignment';

    update applicationinput;
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    System.debug('*****&&&&&&)))))'+applicationinput.Status__c);
    }
catch (exception e){
        System.debug('e'+e);
    //  ApexPages.addMessages (new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Approve Award due to '+e));    
}
return null;
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++
// For NCCC Awards, SPO Denies the Award. Status of Award and Application changes to 'Denied'. 
public PageReference Deny() {            
 PageReference Redirect;  
try{
    applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];
// Update the Status of Award.  
    awarddetail.Grant_Status__c='Denied';
// Update the Status of Application.  
    applicationinput.Status__c = 'Denied';
    applicationinput.Grantee_Status__c = 'Denied';

    update applicationinput;
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    System.debug('*****&&&&&&)))))'+applicationinput.Status__c);
    }
catch (exception e){
        System.debug('e'+e);
    //  ApexPages.addMessages (new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Deny Award due to '+e));    
}
return null;
}

// +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// For NCCC Awards, SPO Withdraws the Award. Status of Award and Application changes to 'Withdrawn'. 
public PageReference WithdrawNCCC() {            
 PageReference Redirect;  
try{
    applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];
// Update the Status of Award.  
    awarddetail.Grant_Status__c='Withdrawn';
// Update the Status of Application.  
    applicationinput.Status__c = 'Withdrawn';
    applicationinput.Grantee_Status__c = 'Withdrawn';

    update applicationinput;
    update awarddetail;
    Redirect = new PageReference('/'+awarddetail.id);
    return Redirect;
    System.debug('*****&&&&&&)))))'+applicationinput.Status__c);
    }
catch (exception e){
        System.debug('e'+e);
    //  ApexPages.addMessages (new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Withdraw Award due to '+e));    
}
return null;
}

// ++++++++++++++++++++++++++++++++++++++++++++++++
// 'Certify and Send for Organization for e-Signature'. (SPO) 
// Status changes from "Pending Team Assignment" to "Awaiting Organization e-Signature".
// For NCCC and Cash = No. 
public PageReference esignNCCC() {
PageReference Redirect;
applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c];
    try{  
    // Check if there is a Team Assignment record on this Award. Else show Error message. 
       if(awarddetail.Corporate_Program1__c == 'NCCC' && awarddetail .NOFA_Name__r.Cash_Grants_Awards__c=='No'){
                TAList = [Select Id from Team_Assignment__c WHERE Award__c = : awarddetail.Id];
                
                if( TAList != null && TAList.isEmpty()) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please add a Team Assignment before sending Award for e-Signature'));
                        return null;
                } 
        }
    //Check if there is a Document Attached to this Award. Else show Error message. 
       if (awarddetail.Corporate_Program1__c == 'NCCC' && awarddetail .NOFA_Name__r.Cash_Grants_Awards__c=='No') {
            AttachList = [Select Id, Type__c from Attachment__c where Award__c = :awarddetail.Id AND Type__c = 'NCCC Pre-Site Checklist']; 

            if(AttachList != null && AttachList.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please attach a "Pre-Site Checklist" document before sending Award for e-Signature'));
                        return null;
            
            }           
     } 
    //  else {
       
        system.debug('Awarddetail&&&&' + awarddetail.id);
        applicationInput.Status__c = 'Awaiting Organization e-Signature';
        awarddetail.Grant_Status__c = 'Awaiting Organization e-Signature';   
    // }
        update awarddetail;
        update applicationInput;
        Redirect = new PageReference('/'+awarddetail.id);
        return Redirect;
    }
    catch (exception e){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Send this Award for Signature due to '+e));    
    }
        return null;
}

// 'Sign and Award Agreement'. SPO Awards the Award from 'Awaiting SPO Award'. NCCC and Cash = No. 
public PageReference AwardNCCC() { 
    PageReference Redirect; 
    applicationinput =[select id,Status__c,Grantee_Status__c from Application3__c where id=:awarddetail.Application_ID__c]; 
        try{
// The status should be 'Awaiting SPO Signature' for the SPO to take this action.         
            if (awarddetail.Grant_Status__c != 'Awaiting SPO Signature'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'You cannot Award the record. '));                    
                return null;
            }
// Change the Status to 'Awarded'. 
            else {
                awarddetail.Grant_Status__c='Pending Team Arrival';
                applicationInput.Status__c = 'Pending Team Arrival';
            }
            update awarddetail;
            update applicationInput;
            Redirect = new PageReference('/'+awarddetail.id);
            return Redirect;
        }
        catch(exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to Award this Award due to '+e));          
         }
            return null;
        }
        
        
         //for NGA Reports begin
        
        public void invokeNGAReports(){
               System.debug('in method invokeNGAReports');
                HttpResponse hResp;
                String json='';
                                    
                String strWSname='MOMcloseout';
                String  endPointuri='';
                String  uName='';
                String  upassword='';
                String  httpMethodName='';
                String  contenttype='';
                CNCS_AuthorizeHttp objCNCS_AuthorizeHttp=new CNCS_AuthorizeHttp();
                
                String strResponse='';
                Boolean stubFlg=true;
               
                try{
                 /*
                    Intgr_MuleSoft__c objIntgr_MuleSoft=CNCS_ObjectUtility.retrieveWSDetails(strWSname);
                    System.debug(objIntgr_MuleSoft);
                    if(objIntgr_MuleSoft==null){
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Configuration for Web Service Grant Closeout is not setUp'));
                        throw new CNCS_ObjectUtility.CustomException();
                    }
                    if(objIntgr_MuleSoft!=null){
                        endPointuri=objIntgr_MuleSoft.endPointuri__c;
                        uName=objIntgr_MuleSoft.uName__c;
                        upassword=objIntgr_MuleSoft.upassword__c;
                        httpMethodName=objIntgr_MuleSoft.httpMethodName__c;
                        contenttype=objIntgr_MuleSoft.contenttype__c;
                    }
                    String strBody=composeBodyForNGAReports();
                    System.debug('endPointuri'+endPointuri+''+'httpMethodName'+httpMethodName+'uName'+uName+'upassword'+upassword+'contenttype'+contenttype);
                   */ 
                    if(stubFlg){
                         strResponse=engenderResponseForNGAReports();
                         ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                         ParseJSONUtil.NGAReportsForgrnt_idJSON    objNGAReportsForgrnt_idJSON= new ParseJSONUtil.NGAReportsForgrnt_idJSON();
                         objNGAReportsForgrnt_idJSON= objParseJSONUtil.parseNGAReportsForgrnt_idJSON(strResponse);
                         System.debug('***objNGAReportsForgrnt_idJSON'+objNGAReportsForgrnt_idJSON);
                         List<ParseJSONUtil.NGAReportsForgrnt_id> lstNGAReportsForgrnt_id=objNGAReportsForgrnt_idJSON.lstData;
                         System.debug('***lstNGAReportsForgrnt_id'+lstNGAReportsForgrnt_id);
                        // updateNGAMembersForGrantCloseOut(lstNGAReportsForgrnt_id);
                    }
                    else{ /*
                        hResp=objCNCS_AuthorizeHttp.wsConnectAndSend(endPointuri,uName,upassword,httpMethodName,contenttype,strBody,false);
                        System.debug('***hResp***'+hResp);
                        
                        if(hResp!=null && hResp.getStatusCode()!=200){
                             throw new CNCS_ObjectUtility.CustomException('Status-->'+hResp.getStatus()+' StatusCode-->'+hResp.getStatusCode()+'  Message-->'+hResp.getBody().replace('\n', ''));
                         }
                        // the service is returning a line feed so parse it out
                        json = hResp.getBody().replace('\n', '');
                        System.debug('***json***'+json );
                        
                        ParseJSONUtil objParseJSONUtil= new ParseJSONUtil();
                        ParseJSONUtil.MomCloseOutForgrnt_idJSON    objMomCloseOutForgrnt_idJSON= new ParseJSONUtil.MomCloseOutForgrnt_idJSON();
                        objMomCloseOutForgrnt_idJSON= objParseJSONUtil.parseMomCloseOutForgrnt_idJSON(json);
                        System.debug('***objMomCloseOutForgrnt_idJSON'+objMomCloseOutForgrnt_idJSON);
                        List<ParseJSONUtil.MomCloseOutForgrnt_id> lstMomCloseOutForgrnt_id=objMomCloseOutForgrnt_idJSON.lstData;
                        System.debug('***lstMomCloseOutForgrnt_id'+lstMomCloseOutForgrnt_id);
                        updateStatusForMomCloseOut(lstMomCloseOutForgrnt_id);                    
                       // returnPage = new PageReference(ApexPages.currentPage().getParameters().get('retURL')); 
                       */ 
                    }   
                  
                }catch(CalloutException exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
                }
                catch(CNCS_ObjectUtility.CustomException custExc) {
                  System.debug('Custom Exception '+ custExc);
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,custExc.getMessage()));
                }
                catch(Exception exc){
                    System.debug('***exc***'+exc);
                    System.debug('***exc.getMessage()***'+exc.getMessage());
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,exc.getMessage()));
                }
                //return returnPage ;
     }
     
     public String composeBodyForNGAReports(){
       String strBody ='{ "grnt_id":'+'"'+ strAwardName+'" }';
       return strBody;
     } 
        
     public String engenderResponseForNGAReports(){
            String strResponse='';
            System.debug('in method engenderResponseForNGAReports');
        
         try{
         
            strResponse+='[{"Total_Obligated_cp_prv_ths_yr": ';
            strResponse+='"'+String.valueof(randomWithLimit(10))+'",';
            strResponse+='"Total_Obligated_cp_this_awd" : ';
            strResponse+='"'+String.valueof(randomWithLimit(2512345))+'",';
            strResponse+='"Total_Obligated_Non_Fed_Share_Matching" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            
            strResponse+='"Unobligated_Balance_cp_prv_ths_yr" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            strResponse+='"Unobligated_Balance_cp_this_awd" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            strResponse+='"Unobligated_Balance_Non_Fed_Share_Match" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            
            
            strResponse+='"cp_prv_yrs_awd": ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            
            
            strResponse+='"cp_line_amts:" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            strResponse+='"Total_Matching_Funds_Required_To_Date" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            
            strResponse+='"cp_mom_lines": ';
            strResponse+='"2015--OPE1-F11-OPO-23000-4101 ",';
            
            strResponse+='"Award" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'",';
            strResponse+='"RESULT_TXT" : ';
            strResponse+='"STUB",';
            strResponse+='"grnt_id" : ';
            strResponse+='"'+String.valueof(randomWithLimit(1000))+'"'+' }]';
            
            
            
            
            
            System.debug(' strResponse '+strResponse);
         
         }
         catch(Exception exc){
            System.debug('exception raised in method (spawnResponseForNGAReports) '+exc.getMessage()); 
         }
        return strResponse;
     } 
     
     public void updateNGAMembersForGrantCloseOut(List<ParseJSONUtil.NGAReportsForgrnt_id> 
                                                                        lstNGAReportsForgrnt_id){
       system.debug('***in method updateNGAMembersForGrantCloseOut***');
       system.debug('***lstNGAReportsForgrnt_id***'+lstNGAReportsForgrnt_id);
       
       
        List<NGAMember__c> lstNGAMember =new List<NGAMember__c>();
        NGAMember__c objTempNGAMember;
       
       
    for( ParseJSONUtil.NGAReportsForgrnt_id objItrNGAReportsForgrnt_id :lstNGAReportsForgrnt_id){
          
        objTempNGAMember=new NGAMember__c();
        objTempNGAMember.total_Obligated_cp_prv_ths_yr__c= convertToDouble(objItrNGAReportsForgrnt_id.total_Obligated_cp_prv_ths_yr);   
        objTempNGAMember.total_Obligated_cp_this_awd__c=convertToDouble(objItrNGAReportsForgrnt_id.total_Obligated_cp_this_awd);
        objTempNGAMember.total_Obligated_Non_Fed_Share_Matching__c=
                                    convertToDouble(objItrNGAReportsForgrnt_id.total_Obligated_Non_Fed_Share_Matching);
               
        objTempNGAMember.unobligated_Balance_cp_prv_ths_yr__c=
                                convertToDouble(objItrNGAReportsForgrnt_id.unobligated_Balance_cp_prv_ths_yr);
        objTempNGAMember.unobligated_Balance_cp_this_awd__c=
                                convertToDouble(objItrNGAReportsForgrnt_id.unobligated_Balance_cp_this_awd);
        objTempNGAMember.unobligated_Balance_Non_Fed_Share_Match__c=
                                convertToDouble(objItrNGAReportsForgrnt_id.unobligated_Balance_Non_Fed_Share_Match);
    
        objTempNGAMember.cp_prv_yrs_awd__c=convertToDouble(objItrNGAReportsForgrnt_id.cp_prv_yrs_awd);
        objTempNGAMember.cp_line_amts__c=convertToDouble(objItrNGAReportsForgrnt_id.cp_line_amts);
        objTempNGAMember.Total_Matching_Funds_Required_To_Date__c=
                                    convertToDouble(objItrNGAReportsForgrnt_id.Total_Matching_Funds_Required_To_Date);
    
        objTempNGAMember.cp_mom_lines__c=objItrNGAReportsForgrnt_id.cp_mom_lines;
        objTempNGAMember.Award__c =awarddetail.id;
        lstNGAMember.add(objTempNGAMember);
        }
    
        
        try{
           system.debug('***before lstNGAMember***'+lstNGAMember);
           List<NGAMember__c> lstAwardExists = [SELECT award__c from NGAMember__c where award__c= :awarddetail.id];
           if(lstAwardExists!=null && lstAwardExists.size()>0 && lstNGAMember!=null && lstNGAMember.size()>0){
               update lstNGAMember;
           }
           else  if(lstNGAMember!=null && lstNGAMember.size()>0){
               insert lstNGAMember;
           }   
       }
       catch(QueryException qryExc){
            System.debug('***QueryException in method-updateNGAMembersForGrantCloseOut()-*** '+qryExc.getMessage());
       }
       catch(DMLException dmlExc){
           System.debug('***dmlExc***'+dmlExc);
           System.debug('***dmlExc.getMessage()***'+dmlExc.getMessage());
       
       }catch(Exception exc){
           System.debug('***exc***'+exc);
           System.debug('***exc.getMessage()***'+exc.getMessage());
       }
        /*
            total_Obligated_cp_prv_ths_yr->y
            total_Obligated_cp_this_awd->y
            total_Obligated_Non_Fed_Share_Matching-->y
            
            unobligated_Balance_cp_prv_ths_yr-->y
            unobligated_Balance_cp_this_awd-->y
            unobligated_Balance_Non_Fed_Share_Match-->y
            
            cp_prv_yrs_awd-->y
            cp_line_amts-->y
            Total_Matching_Funds_Required_To_Date
            
            cp_mom_lines
            awardId
            grnt_Id
            RESULT_TXT
        */  
    }
        
    
    public Integer randomWithLimit(Integer upperLimit){
        Integer rand = Math.round(Math.random()*25000);
        return rand;
    }
    
    public double convertToDouble(String strValue){
        double dbValue=(strValue!=null && strValue!='')? Double.valueOf(strValue):0;
        return dbValue;
   
   }
    
    //for nga reports end
    

    }