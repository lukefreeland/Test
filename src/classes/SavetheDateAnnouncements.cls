/********************************************************************************************
Class Name: SavetheDateAnnouncements
Description: An apex controller for SavetheDate Page.
             Creates Save the Date Pool for each reviewer from the Reviewer Pool.
**********************************************************************************************
Modified By:Pratyusha Mungamuri
Modified On:10/19/2016
Purpose:Comments
**********************************************************************************************/
public class SavetheDateAnnouncements
{
    private ApexPages.StandardController standardController;
    
 
    public SavetheDateAnnouncements(ApexPages.StandardController standardController)
    {
        this.standardController = standardController;
    }
    public PageReference DateAnnouncements()
    {
     
        // Apex code for handling record from a Detail page goes here
        Id recordId = standardController.getId();
        NOFA_Group__c Ngroup = [Select Id, Legacy_NOFO_Group_ID__c,Name__c, Review_of__c, Review_Type__c, Status__c from NOFA_Group__c where Id = :recordId];
        Set<Id> ReviewerPoolIDs = new Set<Id>();
        set<Id> contactIds = new set<Id>();
        set<Id> userIds = new set<Id>();
               
        map<Id,Reviewer_Pool__c> reviewerIdtoPMId = new map<Id,Reviewer_Pool__c>();
        map<Id,Id> PQ= new map<Id,Id>();
        List<Save_the_Date__c> Savethedatepool = new List<Save_the_Date__c>();
        System.debug('RecordId*****' +recordId);
       
       /* Get a list of all of the Contacts associated to the Reviewer Pool*/
        List<Reviewer_Pool__c> reviewerPoolList = new List<Reviewer_Pool__c>();
        reviewerPoolList = [SELECT Id,Expert_Reviewer_Name__c,Roles__c FROM Reviewer_Pool__c where NOFA_Group__c= :recordId];
        for(Reviewer_Pool__c rp: reviewerPoolList){
          ReviewerPoolIDs.add(rp.Expert_Reviewer_Name__c);
          reviewerIdtoPMId.put(rp.Expert_Reviewer_Name__c,rp); 
        }
        
        /* Create an Save the Date Pool for each Reviewer */
        for (ID rpID: ReviewerPoolIDs){
            Save_the_Date__c std = new Save_the_Date__c();
            if(rpID != null)
            {
            std.Expert_Reviewer__c = rpID;
            std.Save_the_Date__c = recordId;
            std.Reviewer_Pool__c = reviewerIdtoPMId.get(rpID).Id;
            contactIds.add(std.Expert_Reviewer__c);
            std.Role_Type__c = reviewerIdtoPMId.get(rpID).Roles__c;
          
            //Set the Status 
            Savethedatepool.add(std);
            }
        }
        
        system.debug('savethedatalist'+ Savethedatepool.size());
        insert Savethedatepool;   
        PageReference pageRef = new PageReference('/'+Ngroup.Id);
        pageRef.setRedirect(true);
       return pageRef;
    }
}