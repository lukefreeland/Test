public class FeedbackScoreCtrl
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
    public double stotal{get;set;}
    public boolean isedit{get;set;}
    public list<Feedback__c> FeList;
    public Id currentRecordId{get;set;}
    public Map<String,String> Mapquestionans{get;set;}
    public boolean issetupequestion{get;set;}
    public String mode{get;set;}// determines if the page is new,edit/view mode
    public string ftotal{get;set;}
    public Integer tSize;
    public string total{get;set;}
    Save_the_date__c savethedaterec = new  Save_the_date__c();
    public FeedbackScoreCtrl(ApexPages.StandardController controller) {
      issetupequestion = false;
      sd = new Expert_Reviewer_Form__c();
      setupQue = new List<Setup_Questionnaire__c>();
      lstWrap = new list<wrapQuesion>();
      QaMap = new Map<String,String>();
      FeList = new list<Feedback__c>();
      Mapquestionans = new map<string,string>();
      Erfmid = apexpages.currentpage().getparameters().get('id');
      
      sd = [Select id,Save_the_date__c,Save_the_date__r.Save_the_Date__c,recordtype.name  from Expert_Reviewer_Form__c where id =:Erfmid LIMIT 1];
      if(sd.recordtype.name == 'Setup Questionnaire'){
      issetupequestion = true;
      }
      if(sd.Save_the_date__c != null){
          savethedaterec = [select id,status__c from Save_the_date__c where id= :sd.Save_the_date__c limit 1];
      }
      setupQue  = [select id,Question_1__c,Answer_1__c from Setup_Questionnaire__c where NOFO_Group__c =:sd.Save_the_date__r.Save_the_Date__c and recordType.name =:sd.recordtype.name];
      
      currentRecordId = ApexPages.currentPage().getParameters().get('id');
      mode = ApexPages.currentPage().getParameters().get('pageMode');   
      if(ApexPages.currentPage().getParameters().get('total') != null)
      {
      totalscore = double.valueof(ApexPages.currentPage().getParameters().get('total'));
      }
      
      if(ApexPages.currentPage().getParameters().get('ftotal') != null)
      {
      stotal = double.valueof(ApexPages.currentPage().getParameters().get('ftotal'));
      }
      
      for(Setup_Questionnaire__c  setq : setupQue){
      
      Mapquestionans.put(setq.Question_1__c,setq.Answer_1__c);
      }
      for(feedback__c feed : [select id,Question_1__c,Answer_1__c from Feedback__c where Expert_Reviewer_Form__r.id =: sd.id and recordType.name =: sd.recordtype.name ])
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
          //string s= pageMode();
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
            if(sd.recordtype.name == 'Setup Questionnaire'){
              issetupequestion = true;
            }
            return pageMode;
            
        }

      
    public void calculate(){
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
    
    }
    
    public class wrapQuesion{
    
        public Feedback__c fb{get;set;}
        public string stotal{get;set;}
        
    }  
      
     public PageReference editRec(){
     PageReference pr = New PageReference('/apex/FeedbackScore?id='+ currentRecordId  );
     pr.getParameters().put('pageMode','edit');
     pr.setredirect(true);
     return pr;
     } 
        
        
   public pagereference save(){
      list<FeedBack__c> listtoupdate = new list<Feedback__c> ();
       
       integer tTotal=0;
       tSize = lstWrap.size();
       system.debug('ttotal'+lstWrap);
       system.debug('the size is'+tSize);
       for(wrapQuesion wq:lstWrap){
       if(wq.stotal != null) tTotal=tTotal+Integer.valueOf(wq.stotal); 
       listtoupdate.add(wq.fb);
       }
       system.debug('the total is####'+tTotal);
       if(tTotal != null && tsize != null) totalscore = tTotal/tSize;
              system.debug('the total is@@@@@'+totalscore );
       if(issetupequestion==true){
           sd.Total_Score__c  =  totalscore;
            system.debug('the total is####@'+sd.Total_Score__c );
       }
       
       boolean issuccess = false; 
       Try{
         update sd;
         update listtoupdate;
         issuccess = true;
       }
       Catch(exception e){
       
       }
       system.debug(issetupequestion );
       system.debug(issuccess);
       if(issetupequestion == false && issuccess == true ){
           savethedaterec.status__c = 'Pre-Confirmed';
           
           try {
           update savethedaterec;
            }
           Catch(exception e){
               system.debug('e***'+e.getmessage());
           }
       }
       string str = string.valueof(totalscore);
       string str1 = string.valueof(stotal);
         
    PageReference pr = New PageReference('/apex/FeedbackScore?id='+sd.id);
    
         pr.getParameters().put('pageMode','view');
         
         pr.getParameters().put('total',str);
         pr.getParameters().put('ftotal',str1);
         pr.setredirect(true);
         
         return pr;   
   
   }
     
}