public class VettingQuestionsFormCtrl
{
    public Id Erfmid;
    public Id SaveDateid;
    public Expert_Reviewer_Form__c sd;
    public string fId{get;set;}
    public List<Setup_Questionnaire__c> setupQue{get;set;}
    public list<wrapQuesion> lstWrap{get;set;}
    public Map<String,String> QaMap{get;set;}
    public string textbox1{get;set;}
    public string tanswer;
    public double totalscore {get;set;}
    public boolean isedit{get;set;}
    public list<Feedback__c> FeList;
    public Id currentRecordId{get;set;}
    public Map<String,String> Mapquestionans{get;set;}
    public String mode{get;set;}// determines if the page is new,edit/view mode
    
    public Integer tSize;
    public string total{get;set;}
    public VettingQuestionsFormCtrl(ApexPages.StandardController controller) {
      sd = new Expert_Reviewer_Form__c();
      setupQue = new List<Setup_Questionnaire__c>();
     lstWrap = new list<wrapQuesion>();
      QaMap = new Map<String,String>();
      FeList = new list<Feedback__c>();
      Mapquestionans = new map<string,string>();
      Erfmid = apexpages.currentpage().getparameters().get('id');
       sd = [Select id,Save_the_date__r.Save_the_Date__c  from Expert_Reviewer_Form__c where id =:Erfmid LIMIT 1];
      setupQue  = [select id,Question_1__c,Answer_1__c from Setup_Questionnaire__c where NOFO_Group__c =:sd.Save_the_date__r.Save_the_Date__c];
      
      currentRecordId = ApexPages.currentPage().getParameters().get('id');
      mode = pageMode();
      
      for(Setup_Questionnaire__c  setq : setupQue)
      {
      
      Mapquestionans.put(setq.Question_1__c,setq.Answer_1__c);
      }
      for(feedback__c feed : [select id,Question_1__c,Answer_1__c from Feedback__c where Expert_Reviewer_Form__r.id =: sd.id ])
      {
         if(feed.Answer_1__c != null){
              system.debug('setq.Answer_1__c'+feed.Answer_1__c);
              isedit = true;
          }
          else {
              isedit = false;
          }
         wrapQuesion objWrap = new wrapQuesion();
          objWrap.fb = feed;
         lstWrap.add(objWrap);
      }
       }
      
      public string pageMode(){

            String pageMode;

            System.debug('$$$$ :' + mode);
            // determine the page mode: new, edit, view.
            Id i = currentRecordId;

            Map<String,String> parameters = ApexPages.currentPage().getParameters();
            if(i == null){
                pageMode = 'new';
                System.debug('$$$$ :' + mode);
            } else if(parameters.containsKey('pageMode')){
                pageMode = 'edit';
                System.debug('$$$$ :' + pageMode);
            } else{
                pageMode = 'view';
                System.debug('$$$$ :' + mode);
            }
            return pageMode;
        }

      
  /*  public void calculate(){
    system.debug('####### >> '+textbox1);
    tanswer = textbox1;
    system.debug('the fid is'+QaMap.get(fId));
    system.debug('the answer is'+tanswer);
    for(wrapQuesion objWr:lstWrap){
    
        if(objWr.fb.Question_1__c == fId){
            if(objWr.fb.Answer_1__c == Mapquestionans.get(fId)){
               objwr.stotal='100';
               break;
            }
            else{
               objwr.stotal='0';    
            }    
        }
    }
    
    }*/
    
    public class wrapQuesion{
    
        public Feedback__c fb{get;set;}
        public string stotal{get;set;}
        
    }  
      
     public PageReference editRec(){
     PageReference pr = New PageReference('/apex/VettingQuestionsForm?id='+ currentRecordId  );
     pr.getParameters().put('pageMode','edit');
     pr.setredirect(true);
     return pr;
        } 
        
        
  public void save(){
  list<FeedBack__c> listtoupdate = new list<Feedback__c> ();
  
   tSize = lstWrap.size();
   system.debug('ttotal'+lstWrap);
   system.debug('the size is'+tSize);
   for(wrapQuesion wq:lstWrap){
   listtoupdate.add(wq.fb);
   }
   update sd;
   update listtoupdate;
  
   }
      
      
}