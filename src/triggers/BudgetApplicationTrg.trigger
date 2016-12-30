trigger BudgetApplicationTrg on cb3__Budget__c (Before insert, before update, after insert,after update, after delete) {
     String tempAppId;
     List<String> lstAppId=new List<String>();
     Map<String,String> mpBdgAppIdToAppId=new Map<String,String>();
     Map<String,String> mpAppIdToBdgAppId=new Map<String,String>();
     Set<String> stAppId =new Set<String>();
     String errAppId='';
     
     String errMsg='Cannot create Budget Applications more than the limit configured against respective NOFA';
     Boolean flag=false;
     
     if (Trigger.isBefore){
         if(Trigger.isInsert){
                  System.debug('***BudgetApplicationTrg- IsBefore, isInsert***');
                  System.debug('***BudgetApplicationTrg- IsBefore, isInsert***');
                  
                for (cb3__Budget__c  objTemp : Trigger.new) {
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
                                                                         (select id,name from Budget_Applications__r) 
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
                       
                      if(objApp.Budget_Applications__r!=null && lmt!=null && ( objApp.Budget_Applications__r.size() >= lmt && lmt !=0)){
                            System.debug('condition error');  
                            errAppId=objApp.id;
                            flag=true;
                            break;
                            //Trigger.addError('Cannot create Budget Applications more than the limit configured against respective NOFA');        
                      }
                }
               
                for (cb3__Budget__c  objTemp : Trigger.new) {
                  if(flag==true && errAppId.equals(objTemp.Parent__c)){
                     System.debug('error'); 
                     objTemp.addError(errMsg);
                  }
                     break;
                }  
        }
        if(trigger.isDelete){
             BudgetApplicationTriggerHandler objBdgAppTrgHndlr=new BudgetApplicationTriggerHandler();
             objBdgAppTrgHndlr.deleteSlotsForDeletedBdgApps(Trigger.old);
     
        }
     }
     
    
    if(trigger.isAfter){
        if(trigger.isUpdate || trigger.isInsert){
         ///
        /*
        set<Id> appIds = new set<Id>();
        for(cb3__Budget__c ba:trigger.new){
            if(ba.Parent__c != null){
                appIds.add(ba.Parent__c);   
            }
        }
        Id appRT = Schema.SObjectType.Application3__c.getRecordTypeInfosByName().get('Application').getRecordTypeId();
        list<Application3__c> apps = new list<Application3__c>([Select Id,Name,RecordTypeId,Application_Signed__c,Authorized_Representative__c,Certifications_Clicked__c,Assurances_Clicked__c,Grantee_Status__c  from Application3__c where id in :appIds 
                                                                and RecordTypeId = :appRT]);
        if(apps.size()>0){ 
            for(Application3__c a: apps){
                if(a.Application_Signed__c){
                    a.Application_Signed__c = false;
                    a.Authorized_Representative__c = null;
                    a.Grantee_Status__c = 'In Progress';
                    a.Certifications_Clicked__c = false;
                    a.Assurances_Clicked__c = false;
                }   
            }             
            update apps;
        } 
        */
        ///
        //above code is commented and implemented in the below method
        BudgetApplicationTriggerHandler objBdgAppTrgHndlr=new BudgetApplicationTriggerHandler();
        objBdgAppTrgHndlr.updateApp_Attributes(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);

        //below method functionality is to update Application's RecommendedAwardAmt
        objBdgAppTrgHndlr=new BudgetApplicationTriggerHandler();
        objBdgAppTrgHndlr.assign_RecommendedAwardAmtToAppFromBdgApp(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
     }
     
   }
   

}