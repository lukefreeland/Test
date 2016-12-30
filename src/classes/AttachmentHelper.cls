public with sharing class AttachmentHelper {
    
    public static void makeApplicationFeedbackAttachmentsPublic(list<Attachment> attachments){
        String appFeedbackPrefix = Application_Feedback__c.sobjecttype.getDescribe().getKeyPrefix();
        String appPrefix = Application3__c.sobjecttype.getDescribe().getKeyPrefix();
        String AwardPrefix = Award__c.sobjecttype.getDescribe().getKeyPrefix();
        String CorpProgPrefix = CNCS_Corporate_Program__c.sobjecttype.getDescribe().getKeyPrefix();
        String NOFOPrefix = NOFA__c.sobjecttype.getDescribe().getKeyPrefix();
        String ContactPrefix = Contact.sobjecttype.getDescribe().getKeyPrefix();
        
        for(Attachment a: attachments){
            String parentId = (String)a.ParentId;
              if(parentId.startsWith(appFeedbackPrefix) || parentId.startsWith(appPrefix) || parentId.startsWith(AwardPrefix) || parentId.startsWith(CorpProgPrefix)|| parentId.startsWith(NOFOPrefix) || parentId.startsWith(ContactPrefix)){
           // if(parentId.startsWith(appFeedbackPrefix)){
                if(a.IsPrivate){
                    a.IsPrivate = false;
                    
                } 
            }
        }
    }

}