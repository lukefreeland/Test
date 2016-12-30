public class ReviewerTraining{

     private ApexPages.StandardController std;
     
    // public List<Feedback__c> questions;
      public list<Feedback__c> questions = new list<Feedback__c>(); 
     
     public ReviewerTraining(ApexPages.StandardController stdCtrl){
         std=stdCtrl;
     }
     
     public Expert_Reviewer_Form__c getExpertReviewerFeedback(){
         return (Expert_Reviewer_Form__c) std.getRecord();
    }
    
    private boolean updateFeedbackList()
    {
        boolean result=true;
        //Can't update if there is nothing in the list
        if (null!=questions)
        {

            //try catch block to update the feedback questions
              try
              {
                update questions;
              }
              catch (Exception e)
              {
                  //if it fails, let's nicely display the message
                 String msg=e.getMessage();
                 integer pos;
                  
                 // if its field validation, this will be added to the messages by default
                 if (-1==(pos=msg.indexOf('FIELD_CUSTOM_VALIDATION_EXCEPTION, ')))
                 {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
                 }
                  
                 result=false;
              }
         }
            
         return result;
    }
    
    public PageReference save()
    {
     
      //Assume it works
      Boolean result=true;
      //Send it back to detail page
      PageReference pr=Page.FeedBackQuestionDetail;
      //get the application feedback ID
      if (null!=getExpertReviewerFeedback().id)
      {
        //first, update the feedback questions
        result=updateFeedbackList();
      }
      else
      {
         
        pr.setRedirect(true);
      }
      
      if (result)
      {
        // call standard save, but don't capture the return value which will redirect to view page
        //std.save();
        update getExpertReviewerFeedback();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
      }
      pr.getParameters().put('id', getExpertReviewerFeedback().id);
      pr.setRedirect(true);
      return pr;
      
        
    }
    
     public List<Feedback__c> getFeedbacklist(){   
       
       if ( (null!=getExpertReviewerFeedback().id) && (questions == null) ){
           id someVar = getExpertReviewerFeedback().ID;           
            //get the list of feedback questions
            // FeedqueList = [SELECT Question__c,Name__c,Comments_Required__c,Active__c,Answer__c,Scoring_Method__c,Score_number__c,Score_yes_no__c,Score_two_factor__c,Score_four_factor__c,Score_Value__c,Weighted_Score__c, id from Feedback_questions__c where (Application_Feedback__c = :getExpertReviewerFeedback().ID) ORDER BY Name__c];
         questions = [SELECT Answer_1__c,Question_1__c  from Feedback__c where Expert_Reviewer_Form__c = :someVar];
           
           
           }
           return questions;
        }
           
}