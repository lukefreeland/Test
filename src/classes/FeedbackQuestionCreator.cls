global class FeedbackQuestionCreator
{
/*public  Save_the_Date__c savedraft;
public list<Feedback__c> feedbackstoinsert;
public list<Setup_Questionnaire__c> SetupQuestionnairelist;
  

public Feedbackquestioncreator()
{
savedraft = new Save_the_Date__c ();
SetupQuestionnairelist = new list<Setup_Questionnaire__c>();
feedbackstoinsert = new list<Feedback__c>();

}*/

webservice static void Submit(string SavedraftID)
{
Save_the_Date__c savedraft = new Save_the_Date__c ();
list<Setup_Questionnaire__c> SetupQuestionnairelist = new list<Setup_Questionnaire__c>();
list<Feedback__c> feedbackstoinsert = new list<Feedback__c>();

savedraft = [select id,name,Save_the_Date__c,Status__c from Save_the_Date__c  where id =: SavedraftID];

if(savedraft != null && savedraft.Status__c != 'Submitted')
{

if(savedraft.Save_the_Date__c != null)
{
savedraft.Status__c = 'Submitted';
update savedraft;

SetupQuestionnairelist  = [select id,name,Answer_1__c,Question_1__c from  Setup_Questionnaire__c where NOFO_Group__c =: savedraft.Save_the_Date__c];

if(SetupQuestionnairelist.size()>0)
{
for(Setup_Questionnaire__c sp :SetupQuestionnairelist)
{
Feedback__c fc = new Feedback__c(); 
fc.NOFO_Group__c = savedraft.Save_the_Date__c;
fc.Setup_Questionnaire__c = sp.id;
fc.Save_the_Date__c = savedraft.id;
feedbackstoinsert.add(fc);
}
}
}
if(feedbackstoinsert.size()>0)
{
insert feedbackstoinsert;
}
//pagereference p = new pagereference('/apex/FeedbackScore?Id='+savedraft.Save_the_Date__c);
//return p;
}

}
}