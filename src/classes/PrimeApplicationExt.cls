/**
 *Apex class associated to PrimeApplicationDetailPage- Prime - Sub Model
 *=======================================================================
 *          Date           Purpose
 * Created : 12/29/2015    Initial version.
 * Created By:Prashant      -State Commison(Prime Applicant submit the ralated sub application to CNCS)
 *                          - Prime-Sub Amendment Flow
 *                          
 * Changes:  Request to everyone who ever change any thing plz add your changes and comment
 *          
 *          
 *          
 * ======================================================================
 **/

public class PrimeApplicationExt {

        public Prime_Application__c pc{get;set;}
        public Application3__c subapps{get;set;}
        public String id{get;set;}

                   
        public PrimeApplicationExt(ApexPages.StandardController controller) 
        {
             
           pc=(Prime_Application__c)controller.getRecord();
          
           id=ApexPages.currentPage().getParameters().get('id');
           pc=[select id,name,Competitive_or_Formula__c,State_Application_Identifier1__c,CNCS_Status__c,Prime_Application_Configured_BudgetForms__c,
           CNCS_Corporate_Program__c,Master_Award__c,NOFO_RFP__c,Type_of_Application__c,Program_Officer__c,Senior_Program_Officer__c,Program_Office_Director__c,
           Grants_Officer__c,Senior_Grants_Officer__c,Executive_Officer__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,Total_Recommended_MSYs__c,Issue_Area__c,
           Subject_to_FAPIIS_Review__c,Date__c,Information_available__c,Satisfactory_Record_Executing_Programs__c,Demonstrates_Ethics_Integrity__c,Mitigating_Circumstances__c,
           FAPIIS_Review_Comments__c,Program_Type__c, NOFO_RFP__r.Cash_Grants_Awards__c,Organization_Legal_Name__c,Project_Name__c,EO_12372_Process__c,Applicant_Delinquent_on_any_Federal_Debt__c,
           Project_Website_URL__c 
           from Prime_Application__c where id=:pc.id];
           if(id!=null){
                String sUrlRewrite = System.URL.getSalesforceBaseUrl().getProtocol() 
                                       + '://' + System.URL.getSalesforceBaseUrl().getHost()
                                       + '/' + pc.Id;
                System.debug('11@@@'+sUrlRewrite);
           }
        }

       //Amendment logic to clone the prime application and sub application
        public PageReference Amend(){
            PageReference redirect;
            List<Application3__c> app_List = new List<Application3__c>();
            List<Application3__c> app_Clonedfrom_List = new List<Application3__c>();
            List<Application3__c> insertapp_List = new List<Application3__c>();
            Prime_Application__c primeappCloneFrom;
            Prime_Application__c newClonedprimeapp = new Prime_Application__c();
            if(id!=null){
                primeappCloneFrom=[select name,CNCS_Status__c,NOFO_RFP__c,Master_Award__c,Type_of_Application__c,Prime_Application_ID_Number__c from Prime_Application__c where id=:id];
                system.debug('pp@@'+primeappCloneFrom.Master_Award__c);
                newClonedprimeapp = primeappCloneFrom.clone(false,true);
                newClonedprimeapp.Prime_Application_ID_Number__c = primeappCloneFrom.Prime_Application_ID_Number__c + '-Cloned';
                newClonedprimeapp.Prime_Application__c=pc.id;
                newClonedprimeapp.NOFO_RFP__c=pc.NOFO_RFP__c;
                newClonedprimeapp.Type_of_Application__c='Amendment';
                newClonedprimeapp.CNCS_Status__c='In Progress';
                newClonedprimeapp.Master_Award__c=primeappCloneFrom.Master_Award__c;
                insert newClonedprimeapp;
                System.debug('New_Cloned_Record_ID'+newClonedprimeapp.id);
                //Sub Application clone      
                app_Clonedfrom_List = [SELECT Id, name FROM Application3__c WHERE Prime_Application__c = : id];
                for(Application3__c app : app_Clonedfrom_List){
                        Application3__c appCopy = app.clone(false,true);
                        appCopy.name = app.name + '-Cloned';
                        appCopy.Prime_Application__c = newClonedprimeapp.Id;
                        appCopy.NOFA_RFP__c=pc.NOFO_RFP__c;
                        appCopy.Amendable__c=true;
                        appCopy.Application__c=app.id;
                        app_List.add(appCopy);
             
                }
        
                if(!app_List.isEmpty())
                    insert app_List;
          
                if(!app_Clonedfrom_List.isEmpty())  
                    update app_Clonedfrom_List;         
                    redirect = new PageReference('/'+newClonedprimeapp.id);
                    return redirect;
         
                }
                return null;
        }
     
    
        public PageReference apply()
        {
            PageReference pr;
            pr=new PageReference( '/apex/projectlook?retURL='+pc.id+'&primeApplicationId='+pc.id +'&id='+pc.NOFO_RFP__c+'&opentoApps='+pc.CNCS_Status__c );
          
            return pr;    
        
        }
        
        public Boolean RecAwards {get;set;}
        public Boolean RecAwards1 {get;set;}
        
        public  PageReference RecAwardsMethod()
        { 
                
            List<Application3__c> subapps = new List<Application3__c>();
            Id ApplicationID=Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
            subapps=[select id,name,status__c from Application3__c where Prime_Application__c=:pc.id and recordTypeId = :ApplicationID  and status__c != 'Withdrawn' and status__c != 'Rejected' and status__c != 'Held for Formula' and status__c != 'In Progress'];
            if(pc.Competitive_or_Formula__c == 'Competitive' || pc.Competitive_or_Formula__c == 'Formula'){
                for(Application3__c app:subapps){ 
                    if(app.status__c != 'Pending Prime Award Approval'){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'All Sub Applications should be in Pending Prime Award Approval Status in order to Recommend for Prime Award'));
                        return null;   
                    }
                }
            }
            pc.CNCS_Status__c = 'Recommended For Award'; 
            update pc;
            system.debug('upset in recommend for award method'+pc);   
            PageReference Redirect;
            Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
            Redirect.setRedirect(false);
            RecAwards = true; 
            return Redirect;           
                   
        }
        
        public PageReference report()
        {
          PageReference Redirect;
         Redirect = new PageReference('/00Or0000000JzaI?pv0='+pc.id);
         Redirect.setRedirect(true);
           return Redirect;
        }
    
        public PageReference ApprovedforAward()
        {   
            if((pc.Recommended_Award_Amount__c == null) && ((pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Yes') || (pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Optional' && pc.Program_Type__c=='Support Grant' ) || (pc.NOFO_RFP__r.Cash_Grants_Awards__c=='Optional' && pc.Program_Type__c=='Program Grant'))){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,'Please enter Recommended Award Amount'));
                return null;
            } 
           else{
           pc.CNCS_Status__c = 'Accepted'; 
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
           }
    
        }
        
       public PageReference FormulaNOFAchange()
       {
           // pagereference pr = new pagereference('/apex/PrimeApplicationNOFAlookup?id='+pc.id); 
           // pr.setRedirect(true);
          // return pr;
                 
            try{
                Prime_Application__c newApp = new Prime_Application__c();                 
                newApp = pc.Clone(); 
                newApp.NOFO_RFP__c = null;      
                //newApp.Project__c = newProj.Id;
                insert newApp;
                PageReference pg = new PageReference('/apex/PrimeApplicationNOFAlookup?id='+newApp.Id);
               // pg.getParameters().put('isContinuingApp','true');
                pg.getParameters().put('parentId',pc.Id);
                pg.setRedirect(true);
                return pg;   
            }
            catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
                 return null;
            }   
            return null;
    
     
        } 
   
       public PageReference submitsubApps(){ 
            Pagereference pg;
            /**List<Prime_Application__c> primesub =new List<Prime_Application__c>();
            primesub=[select id,name, (select id from Applications__r) from Prime_Application__c where id=:pc.id];
            system.debug('test@@'+primesub.size());**/
            string strErr = validateMinRankRequired(pc.id);
            system.debug('strErr = '+strErr);
            if(strErr!=null && strErr.equalsIgnoreCase('RANK_VALIDATION_ERROR')){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Minimum Applications have to be provided Ranks  '));  
                 return null;   
            }
            List<Application3__c> subprime= new List<Application3__c>();
            subprime=[select id,name,status__c,Grantee_Status__c from Application3__c where Prime_Application__c=:pc.id AND Status__c = 'Recommended to CNCS' ];
            system.debug('test##'+subprime.size());
            if(subprime.size() > 0) {
               for(Application3__c apps:subprime){
                   apps.Status__c='Submitted to CNCS';
                   apps.Grantee_Status__c='Submitted to CNCS';
               }
               update subprime;
               pc.CNCS_Status__c = 'Submitted to CNCS';
               update pc;
            }
            
            pg = new pageReference('/apex/PrimeApplicationDetail?id='+pc.Id);
            pg.setRedirect(true);
            return pg;      
       }
       
       //method to validate- Min Apps are to be provided Rank
       public String validateMinRankRequired(String strPrmAppId){
            Prime_Application__c objPrmApp;
            String strErr;
            try{                            
                objPrmApp=[SELECT id,name,Sub_Application_Count__c,NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c,
                                    (SELECT name,rank__c,Status__c from Applications__r where  Status__c='Recommended to CNCS')
                           FROM   Prime_Application__c
                           WHERE   id =:strPrmAppId];
                           
                if(objPrmApp!=null && objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c!=null && 
                        objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c.equalsIgnoreCase('Yes')){
                         
                       
                        Integer subAppCnt=(objPrmApp.Sub_Application_Count__c!=null)? (Integer.valueOf(objPrmApp.Sub_Application_Count__c)):0;          
                        Integer countRankGivenToSubApp=0;
                   
                                        
                        if(objPrmApp!=null && objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c!=null && 
                                objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c.equalsIgnoreCase('Yes')){
                                          countRankGivenToSubApp = objPrmApp.Applications__r.size();
                        }
                        
                        Integer SubAppsWithOutRanked_RecommendedToCNCS_Status=0;
                        Integer subAppsRankedWith_RecommendedToCNCS_Status=0;
                        Integer totalSubAppsWith_RecommendedToCNCS_Status = objPrmApp.Applications__r.size();
                        
                        for(Application3__c itrApp: objPrmApp.Applications__r){
                            if(itrApp.rank__c!=null || itrApp.rank__c!=0){
                                subAppsRankedWith_RecommendedToCNCS_Status++;
                            }else{
                                SubAppsWithOutRanked_RecommendedToCNCS_Status++;
                            }
                         }
                        
                         if((subAppCnt >= 1 && subAppCnt < 5 
                                      &&  subAppsRankedWith_RecommendedToCNCS_Status != totalSubAppsWith_RecommendedToCNCS_Status) ||
                               (subAppCnt >=5 && subAppCnt <= 12 
                                      && subAppsRankedWith_RecommendedToCNCS_Status != totalSubAppsWith_RecommendedToCNCS_Status)  ||
                               (subAppCnt  >= 13 && subAppCnt  <= 24 
                                       && subAppsRankedWith_RecommendedToCNCS_Status != totalSubAppsWith_RecommendedToCNCS_Status)){
                                  strErr='RANK_VALIDATION_ERROR';      
                          }             
                                          
                }          
            }
            catch(Exception exc){
                system.debug('err in method -validateMinRankRequired'+exc.getMessage());
            }
            return strErr;
        }
       
       //old method - logic as per previous business reqs ,method to validate- Min Apps are to be provided Rank
       public String validateMinRankRequired_old(String strPrmAppId){
       
            List<Prime_Application__c> lstPrmApp;
            String strErr='';
            try{
                lstPrmApp=[SELECT id,name,Sub_Application_Count__c,NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c,
                             (SELECT name,Status__c,rank__c from Applications__r where Status__c='Recommended to CNCS'  )
                   FROM   Prime_Application__c
                    WHERE   id = :strPrmAppId and NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c='Yes'];
                Integer totalSubAppsWith_RecommendedToCNCS_Status=0;
                Integer subAppsRankedWith_RecommendedToCNCS_Status=0;
                for(Prime_Application__c itrPrimApp:lstPrmApp){
                if(itrPrimApp!=null &&  itrPrimApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c!=null && 
                                itrPrimApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c.equalsIgnoreCase('Yes')){
                               // totalSubAppsWith_RecommendedToCNCS_Status=itrPrimApp.Applications__r.size();
                                totalSubAppsWith_RecommendedToCNCS_Status=(itrPrimApp.Applications__r!=null)?(itrPrimApp.Applications__r.size()):0;
                                for(Application3__c itrApp : itrPrimApp.Applications__r) {
                                    if(itrApp.Status__c!=null){
                                        subAppsRankedWith_RecommendedToCNCS_Status+=1;
                                    }
                                }
                                //eventhough it is list as list size is 1 so writing here avoiding same  condition
                                if((totalSubAppsWith_RecommendedToCNCS_Status > 0 && totalSubAppsWith_RecommendedToCNCS_Status < 5  && totalSubAppsWith_RecommendedToCNCS_Status != subAppsRankedWith_RecommendedToCNCS_Status  )
                                   ||(totalSubAppsWith_RecommendedToCNCS_Status >= 5 && totalSubAppsWith_RecommendedToCNCS_Status <= 12 && subAppsRankedWith_RecommendedToCNCS_Status < 5) ||
                                        (totalSubAppsWith_RecommendedToCNCS_Status  >= 13 && totalSubAppsWith_RecommendedToCNCS_Status  <= 24 && subAppsRankedWith_RecommendedToCNCS_Status  < 10) ||
                                        (totalSubAppsWith_RecommendedToCNCS_Status  >= 25 && subAppsRankedWith_RecommendedToCNCS_Status  < 15)){
                                        strErr='RANK_VALIDATION_ERROR';
                                }   
                             }
                        }
                System.debug('***strErr'+strErr);
                System.debug('***totalSubAppsWith_RecommendedToCNCS_Status'+totalSubAppsWith_RecommendedToCNCS_Status);
                System.debug('***subAppsRankedWith_RecommendedToCNCS_Status'+subAppsRankedWith_RecommendedToCNCS_Status);
            }
            catch(Exception exc){
                system.debug('err in method -validateMinRankRequired'+exc.getMessage());
            }
            return strErr;
   
        }
       
       
       //method to validate- Min Apps are to be provided Rank
       public String validateMinRankRequired_old2(String strPrmAppId){
            Prime_Application__c objPrmApp;
            String strErr;
            try{                            
                objPrmApp=[SELECT id,name,Sub_Application_Count__c,NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c,
                                    (SELECT name from Applications__r where rank__c!=null)
                           FROM   Prime_Application__c
                           WHERE   id =:strPrmAppId];
                           
                if(objPrmApp!=null && objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c!=null && 
                        objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c.equalsIgnoreCase('Yes')){
                         
                       
                        Integer subAppCnt=(objPrmApp.Sub_Application_Count__c!=null)? (Integer.valueOf(objPrmApp.Sub_Application_Count__c)):0;          
                        Integer countRankGivenToSubApp=0;
                   
                                        
                        if(objPrmApp!=null && objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c!=null && 
                                objPrmApp.NOFO_RFP__r.Comp_Sub_Applications_Should_be_Ranked__c.equalsIgnoreCase('Yes')){
                                          countRankGivenToSubApp = objPrmApp.Applications__r.size();
                        }
                  
                        if((subAppCnt >= 1 && subAppCnt <= 12 && countRankGivenToSubApp < 5) ||
                                (subAppCnt  >= 13 && subAppCnt  <= 24 && countRankGivenToSubApp  < 10) ||
                                (subAppCnt  >= 25 && countRankGivenToSubApp  < 15)){
                                strErr='RANK_VALIDATION_ERROR';
                        }
                }          
            }
            catch(Exception exc){
                system.debug('err in method -validateMinRankRequired'+exc.getMessage());
            }
            return strErr;
        }
        
       
   
      public PageReference ContPrimeApp(){
            try{
                Prime_Application__c newPrApp = new Prime_Application__c();                 
                newPrApp = pc.Clone(); 
                newPrApp.NOFO_RFP__c = null;  
                newPrApp.CNCS_Status__c = 'Draft';
                newPrApp.Prime_Application__c = pc.Id;
                newPrApp.Type_of_Application__c = 'Continuation';
              //  newPrApp.Project__c = newProj.Id;
                insert newPrApp;
                PageReference pg = new PageReference('/apex/PrimeNofaSelection?id='+newPrApp.Id);
                pg.getParameters().put('isContinuingApp','true');
                pg.getParameters().put('parentId',pc.Id);
                pg.setRedirect(true);
                return pg;   
            }
            catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Unable to create continuing Application due to '+e));                    
                 return null;
            }   
            return null;
        }   
        
    
        public PageReference openSubApplications(){ 
            pc=[select id,name,Competitive_or_Formula__c,State_Application_Identifier1__c,CNCS_Status__c,Prime_Application_Configured_BudgetForms__c,
                   CNCS_Corporate_Program__c,Master_Award__c,NOFO_RFP__c,Type_of_Application__c,Program_Officer__c,Senior_Program_Officer__c,Program_Office_Director__c,
                   Grants_Officer__c,Senior_Grants_Officer__c,Executive_Officer__c,Ex_Officer_Cost_Share__c,Recommended_Award_Amount__c,Total_Recommended_MSYs__c,Issue_Area__c,
                   Subject_to_FAPIIS_Review__c,Date__c,Information_available__c,Satisfactory_Record_Executing_Programs__c,Demonstrates_Ethics_Integrity__c,Mitigating_Circumstances__c,
                   FAPIIS_Review_Comments__c,Program_Type__c, NOFO_RFP__r.Cash_Grants_Awards__c from Prime_Application__c where id=:pc.id];
           System.debug('***pc->Prime_Application_Configured_BudgetForms__c***'+pc.Prime_Application_Configured_BudgetForms__c);
           if(pc.Prime_Application_Configured_BudgetForms__c!=null){    
              pc.CNCS_Status__c = 'Accepting Sub-Applications'; 
           }else{
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'Please Configure Atleast One Form in Budget Form Section'));                    
              return null;
           }
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
        }
    
        public PageReference closeSubApplications(){
           pc.CNCS_Status__c = 'Closed to Sub-Applicants'; 
           PageReference Redirect;
           // If(pc.id!=null && pc.id!='')
           // system.debug('Id = '+id);
           //Redirect = new PageReference('/'+id);
           update pc;
           Redirect = new PageReference('/apex/PrimeApplicationDetail?id='+pc.id);
           Redirect.setRedirect(true);
           return Redirect;
        }
        
        public PageReference primeAppClone(){
            /*Prime_Application__c newPrApp = new Prime_Application__c();                 
            newPrApp = pc.Clone(); 
            newPrApp.CNCS_Status__c = 'In Progress';
            insert newPrApp;*/
            PageReference pg = new PageReference('/apex/PrimeNofaSelectionForClone?parentId='+pc.Id); 
            
            pg.setRedirect(true);
            return pg;   
            //return null;
        }
        
        public PageReference CopyHeldFormulaApplications(){
             
            PageReference pg = new PageReference('/apex/CopyHeldFormulaApps?id='+pc.Id+'&nofaId='+pc.NOFO_RFP__c);            
            pg.setRedirect(true);
            return pg;              
            
        }
    
}