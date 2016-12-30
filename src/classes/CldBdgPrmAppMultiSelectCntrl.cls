public with sharing class CldBdgPrmAppMultiSelectCntrl{

    public ApexPages.StandardController stdcontroller;
    public SelectOption[] selectedBdgFrms { get; set; }
    public SelectOption[] allBdgFrms { get; set; }
    public String message { get; set; }
    public List<cb3__Budget_Settings__c> lstBudgetForm{get;set;}
    public Prime_Application__c prmApplication{get;set;}
    public Boolean showBdgFrm{get;set;} 
    public string selBudgetForm{get;set;}
    public NOFA__c nofa{get;set;}
    public String nofaId;
    public Map<Id,String> mpBdgFrmIdToTitle{get;set;}
    public Set<String> setConfiguredPrmAppBdgFrmIds{get;set;}
    public Set<String> setAvailableBudgetForms{get;set;}
    public Set<String> setSelectedBudgetForms{get;set;}
         
    public CldBdgPrmAppMultiSelectCntrl(){
          selectedBdgFrms = new List<SelectOption>();
    }
    
    public CldBdgPrmAppMultiSelectCntrl(ApexPages.StandardController p_controller){
        selectedBdgFrms = new List<SelectOption>();
        this.stdcontroller= p_controller;
        this.prmApplication= (Prime_Application__c )stdController.getrecord();
        prmApplication=[select id,name,NOFO_RFP__c,Prime_Application_Configured_BudgetForms__c FROM Prime_Application__c where id= :prmApplication.id];
        if(prmApplication.NOFO_RFP__c!=null){
            nofaId=prmApplication.NOFO_RFP__c;
            retrieveSelectedBudgetFormData();
        }
    }
   
    public void retrieveSelectedBudgetFormData(){
        try{
            allBdgFrms= new List<SelectOption>();
            if(nofaId!=null && nofaId!=''){
                  list<nofa__c> nofas =  new list<nofa__c>([select id,ConfiguredBudgetForms__c FROM NOFA__c WHERE id = :nofaId]);
                  System.debug('***nofa***'+nofa);
                  if(nofas!=null && nofas.size()>0){
                      String strBdgFrmsid=nofas[0].ConfiguredBudgetForms__c ;
                      List<String> lstBdgFrmIds=new List<String>();
                      if(strBdgFrmsid!=null){
                          lstBdgFrmIds =strBdgFrmsid.split(',');
                          System.debug('***lstBdgFrmIds ***'+lstBdgFrmIds );
          
                          lstBudgetForm= [SELECT id,name,cb3__Title__c FROM cb3__Budget_Settings__c where id in :lstBdgFrmIds ORDER BY cb3__Title__c  ]; 
                          System.debug('***lstBudgetForm***'+lstBudgetForm);
                          mpBdgFrmIdToTitle =new Map<Id,String>();
        
                          for(cb3__Budget_Settings__c itrBdgFrm :lstBudgetForm){
                             mpBdgFrmIdToTitle.put(itrBdgFrm.id,itrBdgFrm.cb3__Title__c);
                          }
                       
                          System.debug('***mpBdgFrmIdToTitle***'+mpBdgFrmIdToTitle);
                          exludeConfiguredBdgFrms(lstBudgetForm);
                          String strBdgFrmTitle='';
                           
                          for (String itrStr : setAvailableBudgetForms) {
                                if(mpBdgFrmIdToTitle!=null && mpBdgFrmIdToTitle.containsKey(itrStr)){
                                        strBdgFrmTitle=mpBdgFrmIdToTitle.get(itrStr);
                                    if(strBdgFrmTitle!=null && strBdgFrmTitle!='')
                                        allBdgFrms.add(new SelectOption(itrStr ,strBdgFrmTitle));
                                    }
                                }
                            System.debug('***allBdgFrms***'+allBdgFrms);
                           
                            for (String itrStr : setSelectedBudgetForms) {
                               if(mpBdgFrmIdToTitle!=null && mpBdgFrmIdToTitle.containsKey(itrStr)){
                                    strBdgFrmTitle=mpBdgFrmIdToTitle.get(itrStr);
                                    if(strBdgFrmTitle!=null && strBdgFrmTitle!='')
                                        selectedBdgFrms.add(new SelectOption(itrStr ,strBdgFrmTitle));
                                    }
                            }
                            System.debug('***selectedBdgFrms***'+selectedBdgFrms);
                          }
                  }
            }
           }
           catch(Exception exc){
             System.debug('***exception in method retrieveSelectedBudgetFormData() ***');
           }
    }
    
    public void exludeConfiguredBdgFrms(List<cb3__Budget_Settings__c> p_lstBudgetForm){
        try{        
            String tmpSelectedBdgFrmsId=prmApplication.Prime_Application_Configured_BudgetForms__c;
            setConfiguredPrmAppBdgFrmIds=new Set<String>();
            setAvailableBudgetForms=new Set<String>();
            setSelectedBudgetForms=new Set<String>();
            
            if(prmApplication.Prime_Application_Configured_BudgetForms__c!=null  
                          && prmApplication.Prime_Application_Configured_BudgetForms__c!=''){
                for(String strKey : prmApplication.Prime_Application_Configured_BudgetForms__c.split(',')){
                    setConfiguredPrmAppBdgFrmIds.add(strKey);
                }
                for (cb3__Budget_Settings__c itrBudgetForm : p_lstBudgetForm) {
                    if(!setConfiguredPrmAppBdgFrmIds.contains(itrBudgetForm.id) ){
                        setAvailableBudgetForms.add(itrBudgetForm.id);
                    }else{
                        setSelectedBudgetForms.add(itrBudgetForm.id);
                    }            
                }
            }  else{
                    for (cb3__Budget_Settings__c itrBudgetForm : p_lstBudgetForm) {
                            setAvailableBudgetForms.add(itrBudgetForm.id);
                    }
            }
        }catch(Exception exc){
            System.debug('***exception in method exludeConfiguredBdgFrms() ***');
        }            
    }
    
    public PageReference save() {
        message = 'Selected Budget Forms';
        String bdgFrmIds='';
        Boolean first = true;
        
        for ( SelectOption so : selectedBdgFrms ) {
            if (!first) {
                message += ', ';
                bdgFrmIds+=',';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            bdgFrmIds+=  so.getValue();
            first = false;
        }
        
        prmApplication.Prime_Application_Configured_BudgetForms__c =  bdgFrmIds;
        
        try{
            update prmApplication;
        }
        catch(Exception exc){
           System.debug('CldBdgPrmAppMultiSelectCntrl -save() method -Exception *** '+ exc);
        }
        return null;
    }
   
}