public class BudgetApplicationTriggerHandler{


    public BudgetApplicationTriggerHandler(){
    
    }
    
    //invoked before insert,update of BudgetApplication(cb3__Budget__c) in restricting budgetapplications more than than limit configured 
    public void restrictBdgAppsWithInLmts(List<cb3__Budget__c> p_OldLstBdgApps,List<cb3__Budget__c> p_NewLstBdgApps,
                                Map<Id,cb3__Budget__c> p_OldMapBdgApps,Map<Id,cb3__Budget__c> p_NewMapBdgApps){

        String tempAppId;
        List<String> lstAppId=new List<String>();
        Map<String,String> mpBdgAppIdToAppId=new Map<String,String>();
        Map<String,String> mpAppIdToBdgAppId=new Map<String,String>();
        Set<String> stAppId =new Set<String>();
        String errAppId='';
    
        String errMsg='Cannot create Budget Applications more than the limit configured against respective NOFA';
        Boolean flag=false;
        try{
    
            for (cb3__Budget__c  objTemp : p_NewLstBdgApps) {
                            tempAppId =objTemp.Parent__c; 
                            System.debug('***tempAppId ***'+tempAppId );
                            System.debug('***tempAppId ***'+objTemp);
                            if(tempAppId!=null){ 
                                 lstAppId.add(tempAppId); 
                                 stAppId.add(tempAppId );
                                 mpBdgAppIdToAppId.put(objTemp.id,objTemp.parent__c);
                            }    
            }
            Integer lmt=0;
            System.debug('stAppId'+stAppId);
            List<Application3__c> lstAppForNofaLimit_BdgApp= [SELECT id,name,NOFA_RFP__r.Budget_Application_Limit__c,
                                                                     (SELECT id,name from Budget_Applications__r) 
                                                              FROM application3__c 
                                                              WHERE id in :stAppId];  
            for(Application3__c objApp:lstAppForNofaLimit_BdgApp) {
                if(objApp.NOFA_RFP__r!=null && objApp.NOFA_RFP__r.Budget_Application_Limit__c!=null){
                   lmt=Integer.valueof(objApp.NOFA_RFP__r.Budget_Application_Limit__c);
                }    
                System.debug('objApp.NOFA_RFP__r.Budget_Application_Limit__c'+objApp.NOFA_RFP__r.Budget_Application_Limit__c); 
                if(objApp.Budget_Applications__r!=null){
                    System.debug('objApp.Budget_Applications__r.size()'+objApp.Budget_Applications__r.size());  
                }
    
                if(objApp.Budget_Applications__r!=null && lmt!=null 
                        && ( objApp.Budget_Applications__r.size() >= lmt && lmt !=0)){
                    System.debug('condition error');  
                    errAppId=objApp.id;
                    flag=true;
                    break;
                    //Trigger.addError('Cannot create Budget Applications more than the limit configured against respective NOFA');        
                }
            }
            
            for (cb3__Budget__c  objTemp : p_NewLstBdgApps) {
                  if(flag==true && errAppId.equals(objTemp.Parent__c)){
                     System.debug('error'); 
                     objTemp.addError(errMsg);
                  }
                  break;
            }  
        }
        catch(Exception exc){
          System.debug('***Exception in method-restrictBdgAppsWithInLmts **'+exc.getMessage());
        }            
    }
    
    //method invoked after insert,update of BudgetApplication(cb3__Budget__c) records to update application3__c fields
    public void updateApp_Attributes(List<cb3__Budget__c> p_OldLstBdgApps,
                                    List<cb3__Budget__c> p_NewLstBdgApps,
                                    Map<Id,cb3__Budget__c> p_OldMapBdgApps,
                                    Map<Id,cb3__Budget__c> p_NewMapBdgApps ){

    try{
    
        set<Id> appIds = new set<Id>();
        for(cb3__Budget__c itrBdgApp: p_NewLstBdgApps){
            if(itrBdgApp.Parent__c != null){
                appIds.add(itrBdgApp.Parent__c);   
            }
        }
        Id appRT = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        list<Application3__c> apps = [SELECT Id,Name,RecordTypeId,Application_Signed__c,Authorized_Representative__c,
                                             Certifications_Clicked__c,Assurances_Clicked__c,Grantee_Status__c  
                                      FROM Application3__c 
                                      WHERE id in :appIds and RecordTypeId = :appRT];
        
        list<Application3__c> appsToUpdate = new list<Application3__c>();                    
            if(apps!=null && apps.size()>0){ 
                for(Application3__c itrApp: apps){
                    if(itrApp.Application_Signed__c){
                        itrApp.Application_Signed__c = false;
                        itrApp.Authorized_Representative__c = null;
                        itrApp.Grantee_Status__c = 'In Progress';
                        itrApp.Certifications_Clicked__c = false;
                        itrApp.Assurances_Clicked__c = false;
                        appsToUpdate.add(itrApp);
                    }   
                }
                if(appsToUpdate.size()>0){
                	update appsToUpdate;
                }
            }                   
        }
        catch(Exception exc){
            System.debug('***Exception in method -updateApp_certainFields-***'+exc.getMessage());
    
        }
    }
    
    //method invoked after insert,update of BudgetApplication(cb3__Budget__c) records to update application3__c 
    //field (Recommended_Award_Amount__c ) with the field(cb3__Q1__c) value of BudgetApplication
    public void assign_RecommendedAwardAmtToAppFromBdgApp(List<cb3__Budget__c> p_OldLstBdgApps,
                                                                List<cb3__Budget__c> p_NewLstBdgApps,
                                                                Map<Id,cb3__Budget__c> p_OldMapBdgApps,
                                                                Map<Id,cb3__Budget__c> p_NewMapBdgApps){
       Set<String> setAppId=new Set<String>();
       Map<String,String> mapBdgAppIdToAppId =new Map<String,String>();
       try{
           for(cb3__Budget__c itrBdgApp : p_NewLstBdgApps){
               if(itrBdgApp.cb3__BudgetForCurrentApplicationYear__c!=null && itrBdgApp.cb3__BudgetForCurrentApplicationYear__c==true){
                   setAppId.add(itrBdgApp.Parent__c);
                   mapBdgAppIdToAppId.put(itrBdgApp.id,itrBdgApp.Parent__c);
               }
           }
       
           System.debug('***setAppId***'+setAppId+ '***mapBdgAppIdToAppId***'+mapBdgAppIdToAppId);
           Id appRT = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
           Map<Id,Application3__c> mapApp=new Map<Id,Application3__c>([SELECT id,name,Recommended_Award_Amount__c 
                                                                       FROM Application3__c 
                                                                       WHERE id in :setAppId and RecordTypeId = :appRT]);
           List<Application3__c> lstUpdateApp=new List<Application3__c>();
           Application3__c tempApp=new Application3__c();
       
           for(cb3__Budget__c itrBdgApp : p_NewLstBdgApps){
               if(itrBdgApp.cb3__BudgetForCurrentApplicationYear__c!=null && itrBdgApp.cb3__BudgetForCurrentApplicationYear__c==true){
                    if(mapApp!=null && mapApp.containskey(itrBdgApp.Parent__c)){
                        tempApp=new Application3__c();
                        tempApp= mapApp.get(itrBdgApp.Parent__c);
                        tempApp.Recommended_Award_Amount__c =itrBdgApp.cb3__Q1__c;
                        mapApp.put(itrBdgApp.Parent__c,tempApp);
                    }
               }     
           }
           
           if(mapApp!=null && mapApp.size() > 0 ){
                   lstUpdateApp.addAll(mapApp.values());
                   if(lstUpdateApp!=null && lstUpdateApp.size()>0){
                       Update lstUpdateApp;
                   }
           }
       }
       catch(Exception exc){
          System.debug('***Exception in method-assign_RecommendedAwardAmtToAppFromBdgApp()-*** '+exc.getMessage());
       }
    }
    
    public void deleteSlotsForDeletedBdgApps(List<cb3__Budget__c> p_OldLstBdgApps){
        List<Slot__c> lstSlotsToBeDeleted = new List<Slot__c>();
        Set<String> setBdgAppId=new Set<String>();
        try{
             for(cb3__Budget__c itrBdgApp : p_OldLstBdgApps){
                 setBdgAppId.add(itrBdgApp.id);
             }
             
             if(setBdgAppId!=null && setBdgAppId.size()>0){
                lstSlotsToBeDeleted =[SELECT id,Budget_Application__c  
                                      From Slot__c 
                                      WHERE Budget_Application__c in :setBdgAppId];
                if(    lstSlotsToBeDeleted !=null && lstSlotsToBeDeleted.size() > 0) {
                  delete lstSlotsToBeDeleted;
                }                  
             
             }
       
        }
        
        catch(QueryException qryExc){
            System.debug('***QueryException in method-deleteSlotsForDeletedBdgApps()-*** '+qryExc.getMessage());
        }
        catch(DmlException dmlExc){
            System.debug('***DMLException in method-deleteSlotsForDeletedBdgApps()-*** '+dmlExc.getMessage());
        }
        catch(NoDataFoundException noDataFoundExc){
            System.debug('***No data found exception in method-deleteSlotsForDeletedBdgApps()-*** '+noDataFoundExc.getMessage());
        }
        catch(Exception exc){
          System.debug('***Exception in method-deleteSlotsForDeletedBdgApps()-*** '+exc.getMessage());
       }
    
    
    }

}