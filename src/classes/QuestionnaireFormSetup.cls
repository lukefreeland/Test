public with sharing class QuestionnaireFormSetup{

    private ApexPages.StandardController standardController;
    
    public QuestionnaireFormSetup(ApexPages.StandardController standardController){
        this.standardController = standardController;
    }
    
    public PageReference trainingQuestion(){
        
        Id recordId = standardController.getId();
        system.debug(recordId);
        Save_the_Date__c saveTheDate = [Select id,Comments__c,Competition_Fiscal_Year__c,Competition_Name__c,Corporate_Program_Name__c,Expert_Reviewer__c,
                                       Expert_Reviewer_Name__c,Fiscal_Year__c,Save_the_Date__c,Response__c,Reviewer_Pool__c,Role_Type__c,Status__c from
                                        Save_the_Date__c where id =:recordId];
                                        
        system.debug('Save_the_Date__c '+saveTheDate );                           
        List<Expert_Reviewer_Form__c> questionFeedbackList = new List<Expert_Reviewer_Form__c>();
        List<Feedback__c> feedbackQuestion = new List<Feedback__c>();
        List<Setup_Questionnaire__c> questions= new List<Setup_Questionnaire__c >();
        questions = [Select id,Name,Answer_1__c,NOFO_Group__c,Question_1__c,RecordType.name,RecordType.id from Setup_Questionnaire__c where NOFO_Group__c=:saveTheDate.Save_the_Date__c];
        System.debug('List of Questions -----' + questions.size());
        set<string> recordtypenames = new set<string>();
        for(Setup_Questionnaire__c qc: questions){
            recordtypenames.add(qc.recordtype.name);
        }
        System.debug('recordtypenames -----' + recordtypenames);
        list<string> recordtypenameslist = new list<string>();
        Map<string,string> exrectype = new Map<string,string>();
        Map <string,string> expfmap = new map<string,string>();
        
        try {
        for(Recordtype f1: [select id,name from RecordType where SObjectType = 'Expert_Reviewer_Form__c' and name in: recordtypenames ]){
                expfmap.put(f1.name,f1.id);
                recordtypenameslist.add(f1.name);
                exrectype.put(f1.id,f1.name);
        }
        }
        catch (exception e){
            system.debug('eeee'+e.getmessage());
        }
        System.debug('expfmap-----' + expfmap);
        if(saveTheDate.Response__c == 'Available' ||saveTheDate.Response__c == 'Available w/Comments' )
        {
         
        try {    
                saveTheDate.Status__c ='Submitted';   
                update saveTheDate;
                if(recordtypenames.size()>0){
                    FOR(integer i=0;i<recordtypenames.size();i++){
                        Expert_Reviewer_Form__c QuestionForm = new Expert_Reviewer_Form__c();
                        QuestionForm.RecordtypeId = expfmap.get(recordtypenameslist[i]);
                        QuestionForm.Save_the_date__c = saveTheDate.id;
                        questionFeedbackList.add(QuestionForm);
                    }
                }
                
                Map <string,string> qfmap = new map<string,string>();
                for(Recordtype f1: [select id,name from RecordType where SObjectType =: 'Feedback__c' and name in:recordtypenames])
                {
                qfmap.put(f1.name,f1.id);
                 
                }   
                Map<string,id> eprfmap = new Map<string,id>();
                if(questionFeedbackList.size() > 0){
                    boolean success;
                    try{
                    insert questionFeedbackList;
                    success = true;
                    }
                    catch(exception e){
                    
                    }
                    if(success){
                        for(Expert_Reviewer_Form__c expf: questionFeedbackList){
                            eprfmap.put(expf.recordtypeid,expf.id);
                        }
                    }
                    System.debug('eprfmap-----' + eprfmap);       
                }
                
                if(questionFeedbackList.size()>0 && questions.size()>0){ 
                       
                       //for(Expert_Reviewer_Form__c ques :questionFeedbackList){
                            
                            for( Setup_Questionnaire__c q: questions ) {
                             
                                   Feedback__c QF = new Feedback__c();
                                     
                                   QF.NOFO_Group__c = q.NOFO_Group__c;
                                     
                                   QF.Setup_Questionnaire__c = q.id;
                                   id recty= expfmap.get(q.recordtype.name);
                                   QF.Expert_Reviewer_Form__c = eprfmap.get(recty);
                                   system.debug('QF.Expert_Reviewer_Form__c'+QF.Expert_Reviewer_Form__c);
                                   QF.RecordTypeid= qfmap.get((q.recordtype.name));
                                    // Schema.SObjectType.Feedback__c.getRecordTypeInfosByName().get('Advertiser').getRecordTypeId();
                                  
                                  // QF.Question_1__c = q.Question_1__c;
                                  // QF.Answer_1__c = q.Answer_1__c;
                               
                                  QF.Save_the_date__c = saveTheDate.id;
                                   feedbackQuestion.add(QF);
                                }
                           //}
                      }
                      
                      if(feedbackQuestion.size()>0){
                        insert feedbackQuestion;
                      }
        
        }
        catch(exception e){
            System.debug('execption'+e.getmessage());
        }
        }
        else {
            saveTheDate.Status__c ='Submitted';
            try {
                update saveTheDate;
            
            }
            catch(exception e){
                System.debug('exception'+e.getmessage());
            }
        }
        /*if(saveTheDate.Status__c =='Submitted'){
        
                Expert_Reviewer_Form__c QuestionForm = new Expert_Reviewer_Form__c();
                QuestionForm.Save_the_date__c = saveTheDate.id;
                questionFeedbackList.add(QuestionForm);
                
                if(questionFeedbackList.size() > 0){
                
                    insert questionFeedbackList;
                }
                
                if(questionFeedbackList.size()>0 && questions.size()>0){ 
                       
                       for(Expert_Reviewer_Form__c ques :questionFeedbackList){
                           
                            for( Setup_Questionnaire__c q: questions ) {
                            
                                   Feedback__c QF = new Feedback__c();
                                   QF.NOFO_Group__c = q.NOFO_Group__c;
                                   QF.Setup_Questionnaire__c = q.id;
                                   QF.Expert_Reviewer_Form__c = questionFeedbackList[0].id;
                                  // QF.Question_1__c = q.Question_1__c;
                                  // QF.Answer_1__c = q.Answer_1__c;
                               
                                  QF.Save_the_date__c = saveTheDate.id;
                                   feedbackQuestion.add(QF);
                                }
                           }
                      }
                      if(feedbackQuestion.size()>0){
                        insert feedbackQuestion;
                      }
                }*/
                
                PageReference pageRef = new PageReference('/'+saveTheDate.Id);
                pageRef.setRedirect(true);
                return pageRef;
        }
       
}