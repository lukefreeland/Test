public with sharing class NOFAtoConceptPaperUIExt 
{
    Public Application3__c applicationInput{get;set;}
    Public Id tempid;
    Public String rectype{get;set;}
    Public String rectypename{get;set;}
    public boolean isDraft{get;set;}
    public String id;
    public Boolean displayMsg{get;set;}
    Public NOFA__c Nofa{get;set;}
    public list<selectOption> availableList {get;set;}     
    public list<selectOption> chosenList {get;set;}
    public string selectedRound{get;set;}
    
    
    //public NOFAtoConceptPaperUIExt handle{get{return this;}}
    
    public NOFAtoConceptPaperUIExt getThis(){
        return this;
    }
    
    
    public NOFAtoConceptPaperUIExt (ApexPages.StandardController controller) 
    {
    
        chosenList =  new list<SelectOption>();
        isDraft = false;
        applicationInput= new Application3__c();
        displayMsg=False;
        tempid=controller.getRecord().id;
        id=Apexpages.currentPage().getParameters().get('id');
        String projectid = Apexpages.currentPage().getParameters().get('projectid'); 
        Project__c pro = [select id,name,Project__c.Project_Director__c,Organization__c,Project_Start_Date__c,Project_End_Date__c from Project__c where id=:projectid];
        applicationInput.Organization__c = pro.Organization__c;
        System.debug('Valueofid'+id);
        applicationInput.Project__c=projectid;        
        applicationInput.NOFA_RFP__c=id;
        applicationInput.Grantee_Status__c='In Progress';
        applicationInput.Status__c='In Progress';
        applicationInput.Applicant_User__c = Userinfo.getUserId();
        String primeApplicationId = Apexpages.currentPage().getParameters().get('primeApplicationId'); 
        if(primeApplicationId!=null){
            applicationInput.Prime_Application__c = primeApplicationId;
        }
        If(id!=null && id!='')
           Nofa=[Select NCCC_Dates_CP__c,Environmental_Stewardship_Conservation_N__c,Natural_and_Other_Disasters_NOFO_Concept__c,Infrastructure_Improvement_NOFO_Concept__c,Proposed_Dates__c,NCCC_Dates_and_Questions__c,Standard_CP__c,Energy_Efficiency_CP__c,Corporate_Program__c,Education_CP__c,Safety_and_Security_CP__c,Tools_and_Equipment_CP__c,Evaluation_Summary_or_Plan_CP__c,Veterans_Military_Families_CP__c,Disaster_Services_CP__c,
                Healthy_Futures_CP__c,Energy_Conservation_NOFO_Concept__c,Environmental_Stewardship_CP__c,Capacity_Building_CP__c,Economic_Opportunities_CP__c
                ,Standard_424__c,Standard__c,Program_Design_CP__c, Program_Management_CP__c, Recruitment_and_Development_CP__c, Strengthening_Communities_CP__c, Amendment_Justification_CP__c, 
                Other_CP__c, Continuation_Changes_CP__c, Clarification_Summary_CP__c, Cost_Effectiveness_and_Budget_Adequacy_C__c, Organizational_Capability_CP__c, Need_CP__c,
                Intermediary_Justification_CP__c, Executive_Summary_CP__c, Focus_Areas_and_Objectives_NCCC_CP__c, Target_Populations_CP__c,
                Have_funding_history_with_a_CNCS_Prog_CP__c, Other_NCCC_CP__c,
                Safety_and_Security_AP__c,Review_Cycle__c,Urban_and_Rural_Development_NOFO_Concept__c,
                Id,NCCC_Traditional_Concept_paper__c,NCCC_Traditional_Disaster_Response_Con__c,NCCC_All_Concept_Paper__c,NCCC_Partner_Concept_paper__c,Could_contracted_labor_be_used_Concept__c,Concept_Paper_Maximum_Characters__c   from NOFA__c where id=:id];
           // System.debug('Valueofid'+id+'$$$$$'+Nofa.Foster_Grandparents_Only__c);        
        rectype=[Select id,name from Recordtype where SObjectType='Application3__c' and name='Concept Paper'].id;
     }
  
   
     Public PageReference SaveAsDraft(){
         PageReference Redirect;
         //handle.chosenList = selectedOptions;
         String charCountCheckMsg = charCountCheckForSave();
         if(charCountCheckMsg!=null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,charCountCheckMsg));
            return null;
         }
         
         system.debug('chosen list = '+chosenList);  
         try{
          /* if(applicationInput.City__c == null || applicationInput.Proposed_Start_Date__c == null || applicationInput.Proposed_End_Date__c == null || applicationInput.State_and_or_Territories__c == null || applicationInput.Counties__c == null)
           {
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please enter the required fields '));
                  return null;
            }*/
            applicationInput.recordtypeid=rectype;
            applicationInput.NOFA_RFP__c=id;
            system.debug('selected Round = '+selectedRound);
            applicationInput.Round__c = selectedRound;
            insert applicationInput;
            Redirect = new PageReference('/'+applicationInput.id);
             
            return Redirect;
            }
         Catch(DMLException e){
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
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
                    system.debug('Nofa.Concept_Paper_Maximum_Characters__c = '+Nofa.Concept_Paper_Maximum_Characters__c);
                    if(Nofa.Concept_Paper_Maximum_Characters__c != null){
                            system.debug('Nofa.Concept_Paper_Maximum_Characters__c = '+Nofa.Concept_Paper_Maximum_Characters__c);
                            Integer i = Integer.valueOf(Nofa.Concept_Paper_Maximum_Characters__c);                      
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
                    system.debug('charCount = '+charCount);
                    system.debug('Nofa.Concept_Paper_Maximum_Characters__c = '+Nofa.Concept_Paper_Maximum_Characters__c);
                    if(Nofa.Concept_Paper_Maximum_Characters__c != null){
                            system.debug('Nofa.Concept_Paper_Maximum_Characters__c = '+Nofa.Concept_Paper_Maximum_Characters__c);
                            Integer i = Integer.valueOf(Nofa.Concept_Paper_Maximum_Characters__c);                      
                            Integer Difference = i - charCount;
                            if(Difference>=0){
                                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: '+Difference));
                            }else{
                                errorMsg =  'Total Characters Allowed: '+i+'; Total Characters Entered: '+charCount+'; Characters Remaining: 0';                            
                            }
                            return errorMsg;                        
                    }
           }
           
           return null;
    }  
      
      
      
      
        /*public pagereference createProject(){
             return new Pagereference('/a0W/e?retURL=%2Fa0W%2Fo');
        }*/     
   
   /*public PageReference save1(){
    
         map<String,Boolean> checkRequiredNarrativeFields = new map<String,Boolean>();
        
         PageReference Redirect;
         try{
             if(!validate()) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Concept Paper cannot be Submitted, Due to the following reason: Please enter atleast 1 value for Focus Area and Objectives:'));
             
                return null; 
             }
             checkRequiredNarrativeFields = ApplicationCheck.checkCPNarrativeFields(applicationInput,applicationInput.NOFA_RFP__c);
             if(checkRequiredNarrativeFields.size()>0){
                string fieldNames = '';
                for(String fieldName: checkRequiredNarrativeFields.keyset()){
                   fieldNames += fieldName +', ';
                }
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Concept Paper cannot be Submitted, Due to the following reason: Please enter values for Narrative fields: '+fieldNames));
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
             Redirect = new PageReference('/'+applicationInput.id);
             return Redirect;
         }
         Catch(DMLException e){
             System.debug('@@@@@@@@!!!!!'+e.getmessage());
         }
             return null;
         } */
         
    public boolean Validate()
    {   
         if(Nofa.Education_CP__c == true || Nofa.Veterans_Military_Families_CP__c == true || Nofa.Energy_Efficiency_CP__c == true || Nofa.Healthy_Futures_CP__c == true || Nofa.Economic_Opportunities_CP__c == true || Nofa.Disaster_Services_CP__c == true || Nofa.Environmental_Stewardship_CP__c == true || Nofa.Capacity_Building_CP__c == true || Nofa.Focus_Areas_and_Objectives_NCCC_CP__c == true || Nofa.Infrastructure_Improvement_NOFO_Concept__c==true ){
            
            if(applicationInput.Education_CP__c == null && applicationInput.Counties__c == null && applicationInput.Veterans_and_Military_Families_CP__c == null && applicationInput.Energy_Efficiency_CP__c == null && applicationInput.Healthy_Futures_CP__c == null && applicationInput.Economic_Opportunities_CP__c == null && applicationInput.Disaster_Services_CP__c == null && applicationInput.Environment_Stewardship_CP__c == null && applicationInput.Capacity_Building_CP__c == null
            && applicationInput.Natural_and_Other_Disasters_CP__c == null && applicationInput.Environmental_Stewardship_Conservation_C__c == null && applicationInput.Energy_Conservation_CP__c == null && applicationInput.Infrastructure_Improvement_CP__c == null && applicationInput.Urban_and_Rural_Development_CP__c == null){
                return false;
            }
         }
         return true;
          
         /*if(applicationInput.Education_CP__c == null && (Nofa.Education_CP__c==True))
         {
             applicationInput.Education_CP__c.addError('You must enter Education');
           return false; 
         }
         else if (applicationInput.Healthy_Futures_CP__c == null && Nofa.Healthy_Futures_CP__c==True)
         {
         applicationInput.Healthy_Futures_CP__c.addError('You must enter Health');
         return false;
         }
                        
             else
            return true;
        }*/
    }
    
    public List<Selectoption> roundList{
        set;
        get{
            if(Nofa.Id!=null){
                list<RFP_Class_year__c> rfpClassYrs = new list<RFP_Class_year__c>([Select Id,Name,Class_Year__c,NOFO_RFP__c from RFP_Class_year__c where NOFO_RFP__c = :Nofa.Id]);
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