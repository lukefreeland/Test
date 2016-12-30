public class FeedqueCV {
    //Get the Standard Controller
    private ApexPages.StandardController std;
     
    // the associated FeedqueList
    public List<Feedback_questions__c> FeedqueList;
    public string profileName{get;set;}
    public string contactID{get;set;}
    public string userID{get;set;}
    public list<Feedback_questions__c> fqsToReturn = new list<Feedback_questions__c>();    
    
      
    //Init the Class
    public FeedqueCV(ApexPages.StandardController stdCtrl)
    {
        if (!Test.isRunningTest())
        {
            stdCtrl.addFields(new List<String>{'Expert_Review_Panel__r.Reviewer__c','Expert_Review_Panel__r.Panel__r.Panel_Status__c','Expert_Review_Panel__r.Role__c'});
        }
        std=stdCtrl;
        Profile P = [Select ID, name From Profile where Id =: UserInfo.getProfileId()];
        User U = [Select ID, ContactID FROM User where ID = :UserInfo.getuserID()];
        userID = U.ID;
        profileName = P.Name;
  //    if(u.contactID != NULL)
        contactID = U.contactID;
    }
     
    //Get the application feedback record 
    public Application_Feedback__c getApplicationFeedback()
    {
     return (Application_Feedback__c) std.getRecord();
    }
 
    //Code to update the feedback questions
    private boolean updateFeedqueList()
    {
        boolean result=true;
        //Can't update if there is nothing in the list
        if (null!=fqsToReturn)
        {

            //try catch block to update the feedback questions
              try
              {
                update fqsToReturn;
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
        system.debug('FeedqueList = '+fqsToReturn);
        for(Feedback_questions__c fq : fqsToReturn){
            system.debug('Score Number..............@@@@@@@@' +fq.Score_number__c);
            if(fq.Score_number__c > 100 || fq.Score_number__c <1){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Score cannot be less than 1 and  greater than 100'));
                return null;
            }
        }
      getApplicationFeedback().Status__c = 'In - Progress';
      //Assume it works
      Boolean result=true;
      //Send it back to detail page
      PageReference pr=Page.FeedBackQuestionDetail;
      //get the application feedback ID
      if (null!=getApplicationFeedback().id)
      {
        //first, update the feedback questions
        result=updateFeedqueList();
      }
      else
      {
         
        pr.setRedirect(true);
      }
      
      if (result)
      {
        // call standard save, but don't capture the return value which will redirect to view page
        //std.save();
        update getApplicationFeedback();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
      }
      pr.getParameters().put('id', getApplicationFeedback().id);
      pr.setRedirect(true);
      return pr;
      
        
    }
  

    
    public PageReference ReturnToRework()
    {
        getApplicationFeedback().Status__c = 'Returned for Rework';
        if(profileName =='Expert Reviewers'){
            getApplicationFeedback().Accepted_by_Panel_Coordinator__c = False;
        }
        else{
            getApplicationFeedback().Accepted_by_Staff_Liaison__c= False;
        }
        //Assume it works
        Boolean result=true;
        //Send it back to detail page
        PageReference pr=Page.FeedBackQuestionDetail;
        //get the application feedback ID
        if (null!=getApplicationFeedback().id)
        {
           //first, update the feedback questions
           result=updateFeedqueList();
        }
        else
        {          
           pr.setRedirect(true);
        }
      
        if(result)
        {
            // call standard save, but don't capture the return value which will redirect to view page
            //std.save();
            update getApplicationFeedback();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
        }
        pr.getParameters().put('id', getApplicationFeedback().id);
      
        return pr;
    }
 
    public PageReference submit()
    {
        getApplicationFeedback().Status__c = 'Submitted';
        getApplicationFeedback().Accepted_by_Panel_Coordinator__c=False;
        
        //Assume it works
        Boolean result=true;
        //Send it back to detail page
        PageReference pr=Page.FeedBackQuestionDetail;
        //get the application feedback ID
        if (null!=getApplicationFeedback().id)
        {
            //first, update the feedback questions
            result=updateFeedqueList();
        }
        else
        {
             pr.setRedirect(true);
        }
          
        if(result)
        {
             // call standard save, but don't capture the return value which will redirect to view page
             System.debug('Standard Controller' +std);
             update getApplicationFeedback();
             //std.save();
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Changes saved'));
        }
        pr.getParameters().put('id', getApplicationFeedback().id);
      
        return pr;
    }
     
   public List<Feedback_questions__c> getFeedqueList()
   {   
       
       if ( (null!=getApplicationFeedback().id) && (FeedqueList == null) )
       {
           id someVar = getApplicationFeedback().ID;           
            //get the list of feedback questions
            // FeedqueList = [SELECT Question__c,Name__c,Comments_Required__c,Active__c,Answer__c,Scoring_Method__c,Score_number__c,Score_yes_no__c,Score_two_factor__c,Score_four_factor__c,Score_Value__c,Weighted_Score__c, id from Feedback_questions__c where (Application_Feedback__c = :getApplicationFeedback().ID) ORDER BY Name__c];
         FeedqueList = [SELECT Question__c,Name__c,Comments_Required__c,Active__c,Answer__c,Scoring_Method__c,Score_number__c,Score_yes_no__c,Score_two_factor__c,Score_four_factor__c,Score_Value__c,
                                Weighted_Score__c, id, Roles__c,  CreatedDate
                        from Feedback_questions__c
                        where Application_Feedback__c = :someVar order by Name__c];
         if (Test.isRunningTest())
         {
             return FeedqueList;
         }
         for(Feedback_questions__c fq: FeedqueList){
            if(fq.Roles__c!=null && fq.Roles__c!='' && getApplicationFeedback().Expert_Review_Panel__r.Role__c!=null){
                if(fq.Roles__c.contains(getApplicationFeedback().Expert_Review_Panel__r.Role__c)){
                    system.debug('fq.Score_Number__c = '+fq.Score_Number__c);
                    fqsToReturn.add(fq);
                }
            }
         }              
       
       }
                           
       return fqsToReturn;
    }
}