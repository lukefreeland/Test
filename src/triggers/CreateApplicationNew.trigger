trigger CreateApplicationNew on Application3__c (after update,before insert) {

    if(trigger.isUpdate)
    {   
        List <Application3__c> AppToInsert = new List <Application3__c> (); 
        Id devRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        Id CPRecordTypeId = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Concept Paper').getRecordTypeId();
    
        List<Id> ids = new List<Id>();
 
        for (Application3__c c : Trigger.new) {
            if (c.RecordTypeId == CPRecordTypeId) 
            {
                if (trigger.oldMap.get(c.Id).Grantee_Status__c != trigger.newMap.get(c.Id).Grantee_Status__c && c.Grantee_Status__c== 'Accepted' &&  c.Status__c=='Accepted') {
                    ids.add(c.id);
                }
            }
        }
        if(ids.size()>0){
            Map<Id,Application3__c> app_Map = new Map<Id,Application3__c>([Select id,NOFA_RFP__r.CNCS_Corporate_Program__r.Module__c from Application3__c where id IN: ids]);
            system.debug('&&&&&@@@@@'+app_Map.size());
        
            for (Application3__c c : Trigger.new) {
            
                if (c.RecordTypeId == CPRecordTypeId) 
                {
                    if (c.Grantee_Status__c== 'Accepted' &&  c.Status__c=='Accepted') {
    
                Application3__c a = new Application3__c (RecordTypeId = devRecordTypeId);
                a.NOFA_RFP__c = c.NOFA_RFP__c;
                a.Type_of_Application__c = 'New';
              // system.debug('%%%%^^^^^^'+app_Map.get(c.id).NOFA_RFP__r.CNCS_Corporate_Program__r.Module__c);
                if(app_Map.containsKey(c.id))
               a.Module__c=app_Map.get(c.id).NOFA_RFP__r.CNCS_Corporate_Program__r.Module__c;
                
               system.debug('******)))))))'+c.NOFA_RFP__r.CNCS_Corporate_Program__r.Module__c);
               a.Prime_Application__c = c.Prime_Application__c;
               a.Status__c = 'In Progress';
               a.Grantee_Status__c = 'In Progress';
                a.Ownerid=c.Ownerid;
                system.debug('testpp'+c.Ownerid);
                a.NOFA_RFP_Summary__c = c.NOFA_RFP__r.NOFA_RFP_Summary__c;
               // a.Corporate_Program__c = c.Corporate_Program__c;
                a.State_and_or_Territories__c = c.State_and_or_Territories__c;
                a.Counties__c = c.Counties__c;
                a.Other_Area_Affected_by_Project__c = c.Other_Area_Affected_by_Project__c;     
                a.Organization__c = c.Organization__c;  
                a.Executive_Summary__c = c.Executive_Summary__c;
                a.Program_Design__c = c.Program_Design__c;
                a.Executive_Summary__c = c.Executive_Summary__c;
                a.Continuation_Changes__c = c.Continuation_Changes__c;
                a.Amendment_Justification__c = c.Amendment_Justification__c;
                a.Need__c = c.Need__c;
                a.Clarification_Summary__c = c.Clarification_Summary__c;
                a.Organization_Capability__c = c.Organization_Capability__c;
                a.Continuation_Changes__c = c.Continuation_Changes__c;
                a.Program_Design__c = c.Program_Design__c;
                a.Cost_Effectiveness_and_Budget_Adequacy_C__c = c.Cost_Effectiveness_and_Budget_Adequacy_C__c;
                a.Program_Management__c = c.Program_Management__c;
                a.Evaluation_Summary_or_Plan__c = c.Evaluation_Summary_or_Plan__c;
                a.Recruitment_and_Development__c = c.Recruitment_and_Development__c;
                a.Executive_Summary__c = c.Executive_Summary__c;
                a.Strengthen_Communities__c = c.Strengthen_Communities__c;
                a.Intermediary_Justification__c = c.Intermediary_Justification__c;
                a.Other_Narrative__c = c.Other_Narrative__c;
                a.Tools_and_Equipment__c = c.Tools_and_Equipment__c;
                a.Safety_and_Security__c = c.Safety_and_Security__c;
                a.Education__c = c.Education_CP__c;
                a.Economic_Opportunities__c = c.Economic_Opportunities_CP__c;
                a.Disaster_Services__c = c.Disaster_Services_CP__c;
                a.Capacity_Building__c = c.Capacity_Building_CP__c;
                a.Environmental_Stewardship__c = c.Environment_Stewardship_CP__c;
                a.Focus_Areas_and_Objectives__c = c.Focus_Areas_and_Objectives__c;
                a.Veterans_Military_Families__c = c.Veterans_and_Military_Families_CP__c;
                a.Healthy_Futures__c = c.Healthy_Futures_CP__c;
                a.Organizational_Capability__c=c.Organizational_Capability__c;
                a.Project__c = c.Project__c;
                a.Target_Populations1__c = c.Target_Populations_CP__c;
                a.Proposed_Start_Date__c = c.Proposed_Start_Date__c;
                a.Proposed_End_Date__c = c.Proposed_End_Date__c;
                a.Project_Website_URL_CP__c = c.Project_Website_URL_CP__c;
                a.Project_website_urls__c = c.Project_website_urls__c;
                a.Natural_and_Other_Disasters__c  = c.Natural_and_Other_Disasters_CP__c;
                a.Energy_Conservation__c = c.Energy_Conservation_CP__c;
                a.Environmental_Stewardship_Conservation__c = c.Environmental_Stewardship_Conservation_C__c;
                a.Infrastructure_Improvement__c = c.Infrastructure_Improvement_CP__c;
                a.Urban_and_Rural_Development__c = c.Urban_and_Rural_Development_CP__c;
                a.If_other_please_specify_education__c = c.Other_Education_CP__c;
                a.If_other_please_specify_Economic__c = c.Other_Economic_Opportunities_CP__c;
                a.If_other_please_specify_disaster__c = c.Other_Disaster_Services_CP__c;
                a.If_other_please_specify_Energy__c = c.Other_Energy_Efficiency_CP__c;
                a.If_other_please_specify_Enivironment_Ste__c = c.Other_Environment_Stewardship_CP__c;
                a.If_other_please_specify_Health__c = c.Other_Healthy_Futures_CP__c;
                a.If_other_please_specify_Infrastructure__c = c.Other_Infrastructure_Improvement_CP__c;
                a.If_other_please_specify_capacity__c = c.Other_Capacity_Building_CP__c;
                a.If_other_please_specify_Urban__c = c.Other_Urban_and_Rural_Development_CP__c;
                a.If_other_please_specify_Veterns__c = c.Other_Veterans_and_Military_Families_CP__c;   
                a.Otherobjectives__c = c.Other_Natural_and_Other_Disasters_CP__c;    
                a.If_other_please_specify_Enivironment_Ste__c = c.Other_Environmental_Steward_Conserv_CP__c; 
                a.Select_a_round__c =  c.Select_a_round__c;
                a.Round__c = c.Round__c;
                a.City__c = c.City__c;
                a.Cost_Effectiveness_Budget_Adequacy__c = c.Cost_Effectiveness_Budget_Adequacy__c;
                a.Natural_and_Other_Disasters__c = c.Natural_and_Other_Disasters_CP__c;
                a.Energy_Conservation__c = c.Energy_Conservation_CP__c;
                a.Environmental_Stewardship_Conservation__c = c.Environmental_Stewardship_Conservation_C__c;
                a.Infrastructure_Improvement__c = c.Infrastructure_Improvement_CP__c;
                a.Disaster_Type_App__c = c.Disaster_Type_Con_Paper__c;
                a.Disaster_Type__c = c.Disaster_Type_CP__c;
                a.Could_contracted_labor_be_used_App_Setup__c = c.Could_contracted_labor_be_used_Concept__c;
                a.Funds_available_for_contracted_labor_App__c = c.Funds_available_for_contracted_labor_Con__c;
                a.Will_the_project_replace_staff_App__c = c.Will_the_project_replace_staff_Concept__c;
                a.Could_inclement_weather_impact_plan_App__c = c.Could_inclement_weather_impact_plan_Con__c;
                a.Additional_background_checks_App__c = c.Additional_background_checks_Concept__c;
                a.Describe_additional_background_checks_Ap__c = c.Describe_additional_background_checks_co__c;
                a.Possible_hazardous_waste_exposre_App_Sec__c = c.Possible_hazardous_waste_exposure_concep__c;
                a.Possible_hazardous_waste_exposure_App__c = c.Possible_hazardous_waste_exposure_Con__c;
                a.Possible_work_with_hazardous_chemicl_App__c = c.Possible_work_with_hazardous_chemicl_Con__c;
                a.Possible_work_with_hazardous_chemical_Ap__c = c.Possible_work_with_hazardous_chemicl_Co__c;
                a.Possible_health_restrictions_App__c = c.Possible_health_restrictions_Concept__c;
                a.Possible_health_restrictions_Ap__c = c.Possible_health_restrictions_Con__c;
                a.Project_permissions_permits_secured_App__c = c.Project_permissions_permits_secured_Con__c;
                a.Project_permissions_permits_secured_Ap__c = c.Project_permissions_permits_secured_Co__c;
                a.How_many_teams_are_being_requested_App__c = c.How_many_teams_are_being_requested_Con__c;
                a.Number_of_weeks_to_complete_project_App__c = c.Number_of_weeks_to_complete_project_Con__c;
                a.Ability_to_sustain_project_s_outcomes_Ap__c = c.Ability_to_sustain_project_s_outcomes_Co__c;
                a.Level_of_evidence_for_project_model__c = c.Level_of_evidence_for_project_model_cp__c;
                a.Partner_Project_Code_Application__c = c.Partner_Project_Code_ConceptPaper__c;
                a.Request_Priority_Application__c = c.Request_Priority_ConceptPaper__c;
                a.Team_Mobility_Application__c = c.Team_Mobility_ConceptPaper__c;
                a.Disaster_Number_Application__c = c.Disaster_Number_ConceptPaper__c;
                a.Funding_Code_Application__c = c.Funding_Code_ConceptPaper__c;
                a.Disaster_Type_Application__c = c.Disaster_Type_ConceptPaper__c;
                
                AppToInsert.add(a);
                }
            }
            
        }
        
        try {
           if(AppToInsert.size()>0) 
              insert AppToInsert; 
        } catch (system.Dmlexception e) {
            system.debug ('@test'+e);
        }
    
    }
    
    }
    
    
}