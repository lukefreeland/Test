public Class ConceptpapereditExt{

    public Application3__c applicationInput {get; set;}
    public Boolean displayMsg{get;set;}
    public String id;   
    public NOFA__c Nofa{get;set;}
    public string selectedRound{get;set;}

    public ConceptpapereditExt getThis(){
        return this;
    }

    public ConceptpapereditExt(ApexPages.StandardController controller){
      applicationInput=new Application3__c();
      displayMsg=False;
      id=Apexpages.currentPage().getParameters().get('id');
      If(id!=null && id!='')
      applicationInput=[Select Proposed_Start_Date_is__c,Point_of_Contact__c,City__c,/*Select_a_round__c*/Specify_if_you_want_to_be_in_more_rou_CP__c,Comments__c,
                    Energy_Efficiency_CP__c, Primary_State_of_Service_Activities__c,Other_Energy_Efficiency_CP__c,Proposed_End_Date_is__c,Infrastructure_Improvement_CP__c,
                    NOFA_RFP__r.Economic_Opportunities_CP__c,NOFA_RFP__r.Disaster_Services_CP__c,NOFA_RFP__r.Environmental_Stewardship_CP__c,
                    NOFA_RFP__r.Capacity_Building_CP__c,NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c,NOFA_RFP__r.Veterans_Military_Families_CP__c,
                    NOFA_RFP__r.Education_CP__c,Tools_and_Equipment__c,Safety_and_Security__c,NOFA_RFP__r.Healthy_Futures_CP__c,Strengthen_Communities__c,
                    Grantee_Status__c,Project_Website_URL_CP__c,Evaluation_Summary_or_Plan__c,Disaster_Type_CP__c,Number_of_teams_to_complete_this_proj_CP__c,
                    How_many_teams_are_being_requested_CP__c,Other_Urban_and_Rural_Development_CP__c,Urban_and_Rural_Development_CP__c,Other_Infrastructure_Improvement_CP__c,
                    Other_Environmental_Steward_Conserv_CP__c,Other_Energy_Conservation_CP__c,Energy_Conservation_CP__c,Environmental_Stewardship_Conservation_C__c,
                    NCCC_Dates_CP__c,Other_Natural_and_Other_Disasters_CP__c,Standard_424__c,Natural_and_Other_Disasters_CP__c,   
                  Cost_Effectiveness_Budget_Adequacy__c,  Organizational_Capability__c,Other_Narrative__c,Prefix__c,Need__c,Education_CP__c,
                  Veterans_and_Military_Families_CP__c,Email__c,Title__c,Status__c,Have_funding_history_with_any_CNCS_org__c,Target_Populations_CP__c,
                  Other_Economic_Opportunities_CP__c,Economic_Opportunities_CP__c,Other_Capacity_Building_CP__c,Capacity_Building_CP__c,Environment_Stewardship_CP__c,
                  Other_Environment_Stewardship_CP__c,Other_Healthy_Futures_CP__c,Healthy_Futures_CP__c,Other_Disaster_Services_CP__c,Disaster_Services_CP__c,
                  Other_Veterans_and_Military_Families_CP__c,Other_Education_CP__c,Intermediary_Justification__c ,Cost_Effectiveness_and_Budget_Adequacy__c,First_Name__c,
                  Last_Name__c,Proposed_End_Date__c,Clarification_Summary__c,Continuation_Changes__c,Amendment_Justification__c,Strengthening_Communities__c,
                  Recruitment_and_Development__c,Program_Management__c,Program_Design__c,Executive_Summary__c,Project_website_urls__c,Project__c,Proposed_Start_Date__c,
                  Telephone_Number__c,Concept_Paper_Name__c,NOFA_RFP__c, Other_Target_Populations_CP__c,
                  NOFA_RFP__r.Review_Cycle__c,NOFA_RFP__r.Energy_Efficiency_CP__c,Round__c,State_and_or_Territories__c,Counties__c,Other_Area_Affected_by_Project__c,NOFA_RFP__r.NCCC_Partner_Concept_paper__c,Ability_to_sustain_project_s_outcomes_Co__c ,
                  NOFA_RFP__r.NCCC_Traditional_Concept_paper__c,Possible_hazardous_waste_exposure_concep__c,Possible_work_with_hazardous_chemicl_Con__c ,Possible_hazardous_waste_exposure_Con__c ,Possible_work_with_hazardous_chemicl_Co__c,Number_of_ongoing_volunteers__c ,Project_permissions_permits_secured_Co__c ,Possible_health_restrictions_Con__c ,Disaster_Type__c,Number_of_episodic_volunteers_Concept__c ,Project_permissions_permits_secured_Con__c ,Possible_health_restrictions_Concept__c ,Describe_additional_background_checks_co__c ,Additional_background_checks_Concept__c,Could_inclement_weather_impact_plan_Con__c,NOFA_RFP__r.NCCC_Traditional_Disaster_Response_Con__c,Will_the_project_replace_staff_Concept__c ,Funds_available_for_contracted_labor_Con__c ,Could_contracted_labor_be_used_Concept__c ,NOFA_RFP__r.NCCC_All_Concept_Paper__c,
                  NOFA_RFP__r.Concept_Paper_Maximum_Characters__c, Level_of_evidence_for_project_model_cp__c, How_many_teams_are_being_requested_Con__c, Number_of_weeks_to_complete_project_Con__c,Disaster_Type_Con_Paper__c,Disaster_Type_ConceptPaper__c
                  from Application3__C where id=:id]; 
      if(applicationInput.Round__c!=null){
        selectedRound = applicationInput.Round__c;
      }  

    }
    
    public PageReference reopen1() {   
        PageReference Redirect;
        if(id!=null && id!=''){
            Redirect = new PageReference('/apex/ConceptpaperEdit?id='+applicationInput.id);
            applicationInput.Grantee_Status__c='None';
            update applicationInput;
            return Redirect;
        }

        return null;
    }

    public PageReference SaveAsDraft(){
        pageReference Redirect;
        If(id!=null && id!=''){
            String charCountCheckMsg = charCountCheckForSave();
            if(charCountCheckMsg!=null){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,charCountCheckMsg));
                return null;
            }
            if(applicationInput.Proposed_End_Date__c > applicationInput.Proposed_Start_Date__c)
            {
                Redirect = new PageReference('/apex/CombinedDetailPage?id='+applicationInput.id);
               // applicationInput.Status__c='Submitted';
                //applicationInput.Grantee_Status__c='Submitted';
                applicationInput.Round__c = selectedRound;
                update applicationInput;
                return Redirect;
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Proposed End Date must be greater than the Proposed Start Date'));
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
                    
                    if(applicationInput.NOFA_RFP__r.Concept_Paper_Maximum_Characters__c != null){                       
                            
                            Integer i = Integer.valueOf(applicationInput.NOFA_RFP__r.Concept_Paper_Maximum_Characters__c);                      
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
                    if(applicationInput.NOFA_RFP__r.Concept_Paper_Maximum_Characters__c != null){                       
                            
                            Integer i = Integer.valueOf(applicationInput.NOFA_RFP__r.Concept_Paper_Maximum_Characters__c);                      
                            Integer Difference = i - charCount;
                            if(Difference>=0){
                               // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: '+Difference));
                            }else{
                                errorMsg = 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: 0';                         
                            }
                            return errorMsg;                        
                            
                            
                        
                    }
                    
            }  
            return null; 
    } 
         
    public boolean Validate()
    {   
         if(applicationInput.NOFA_RFP__r.Education_CP__c == true || applicationInput.NOFA_RFP__r.Veterans_Military_Families_CP__c == true || applicationInput.NOFA_RFP__r.Energy_Efficiency_CP__c == true || applicationInput.NOFA_RFP__r.Healthy_Futures_CP__c == true || applicationInput.NOFA_RFP__r.Economic_Opportunities_CP__c == true || applicationInput.NOFA_RFP__r.Disaster_Services_CP__c == true || applicationInput.NOFA_RFP__r.Environmental_Stewardship_CP__c == true || applicationInput.NOFA_RFP__r.Capacity_Building_CP__c == true ||applicationInput.NOFA_RFP__r.Infrastructure_Improvement_NOFO_Concept__c ==true ||applicationInput.NOFA_RFP__r.Energy_Efficiency_CP__c == true || applicationInput.NOFA_RFP__r.Focus_Areas_and_Objectives_NCCC_CP__c == true ){
            
            if(applicationInput.Education_CP__c == null && applicationInput.Veterans_and_Military_Families_CP__c == null && applicationInput.Healthy_Futures_CP__c == null && applicationInput.Energy_Efficiency_CP__c == null && applicationInput.Economic_Opportunities_CP__c == null && applicationInput.Disaster_Services_CP__c == null && applicationInput.Environment_Stewardship_CP__c == null && applicationInput.Capacity_Building_CP__c == null
            && applicationInput.Natural_and_Other_Disasters_CP__c == null && applicationInput.Environmental_Stewardship_Conservation_C__c == null && applicationInput.Energy_Conservation_CP__c == null && applicationInput.Infrastructure_Improvement_CP__c == null && applicationInput.Urban_and_Rural_Development_CP__c == null){
                return false;
            }
         }
         return true;
         
         
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