public class AppSlotInformation{
    SlotInformation objSlotInformation{get;set;}
    List<SlotInformation> lstSlotInformation{get;set;}
    
    public AppSlotInformation(){
        objSlotInformation=new SlotInformation();
        lstSlotInformation=new List<SlotInformation>();
    
    }
    
    public void spawnInformation(List<cb3__BudgetLine__c> p_OldlstBdgLns,List<cb3__BudgetLine__c> p_NewlstBdgLns,Map<Id,cb3__BudgetLine__c> p_OldMap,Map<Id,cb3__BudgetLine__c> p_NewMap){
    
       try{
        System.debug('***spawnInformation***');
        Map<Id,cb3__Account_class__c> mpAcctClassIDToAccountclass=
                                        new Map<Id,cb3__Account_class__c>([  SELECT id,name,cb3__Ident__c,cb3__Active__c,cb3__Balance__c,cb3__CRM_Accounts__c,cb3__Default__c,
                                                                                    cb3__Depreciation__c,cb3__Description__c,cb3__FName__c,cb3__GLA__c,cb3__GLA_Info__c,cb3__GLA_Name__c,
                                                                                    cb3__Global_Account__c,cb3__Inserted__c,cb3__Intacct__c,cb3__Location__c,cb3__Number__c,
                                                                                    cb3__Organization__c,cb3__Other__c,cb3__Required__c,cb3__Subtype__c,cb3__Type__c,cb3__Units__c
                                                                              FROM cb3__Account_class__c    ]);
                                                   
        System.debug('***mpAcctClassIDToAccountclass***'+mpAcctClassIDToAccountclass);
        Set<String> setMembersData = new Set<String>();

        for (AccountClassForMembers__c  objAccountClassForMembers : AccountClassForMembers__c.getAll().values()){
            setMembersData.add(objAccountClassForMembers.classname__c);
        }
        
        set<String> setBdgLnId =new Set<String>(); 
        String strAcctClassId;
        String strAcctClassName;
        Map<Id,cb3__BASection3Level__c> mpIdToSec3Lvl=new Map<Id,cb3__BASection3Level__c>([Select id,name,acctClass__c,cb3__isMembers__c,cb3__SectionName__c 
                                                                                           FROM cb3__BASection3Level__c]);
        ///
        set<String> setAppId=new Set<String>();
        set<String> setBdgAppId=new Set<String>();
        Map<id,id> mpBdgLnIdToBdgAppId= new Map<id,id>();
        // Map<Id,ID> mpBdgLineIdToAppId=new Map<Id,ID>();
        for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
             setAppId.add(itrBdgLine.ApplicationId__c);
             setBdgAppId.add(itrBdgLine.cb3__BudgetApplication__c);
             mpBdgLnIDToBdgAppId.put(itrBdgLine.id,itrBdgLine.cb3__BudgetApplication__c);
              //mpBdgLineIdToAppId.put(itrBdgLine.id,itrBdgLine.Application__c);
        }
        System.debug('***setAppId.'+setAppId);
        System.debug('***setBdgAppId'+setBdgAppId);
        System.debug('***mpBdgLnIdToBdgAppId'+mpBdgLnIdToBdgAppId);
        
        Map<Id,cb3__Budget__c> mpBdgAppIdToBdgApp = new Map<Id,cb3__Budget__c>();
        if(setBdgAppId!=null && setBdgAppId.size() >0){
            mpBdgAppIdToBdgApp=new Map<Id,cb3__Budget__c>([SELECT id,name, cb3__BudgetForCurrentApplicationYear__c  
                                                               FROM cb3__Budget__c
                                                               WHERE id in :setBdgAppId]);
        
        }
        
        Map<Id,id> mpAppIdToAwardId=new Map<Id,Id>(); 
        List<application3__C> lstAppWithAward;
        if(setAppId!=null && setAppId.size()>0){
           lstAppWithAward= [select id,name,(select id,name from Award__r) from application3__C where id in :setAppId];
        }
            
        for(application3__C itrApp :lstAppWithAward){
            for(Award__c itAward:itrApp.Award__r){
                  mpAppIdToAwardId.put(itrApp.id,itAward.id);
                  break;
            }
        }
        System.debug('***mpAppIdToAwardId.'+mpAppIdToAwardId);
        cb3__Budget__c  tempBdgApp=new cb3__Budget__c();
        ///
        
        
        for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
            setBdgLnId.add(itrBdgLine.id);
            cb3__BASection3Level__c objBASection3Level =mpIdToSec3Lvl.get(itrBdgLine.cb3__BudgetSection__c);
            strAcctClassId=itrBdgLine.cb3__Account__c;
            if(mpAcctClassIDToAccountclass!=null && mpAcctClassIDToAccountclass.containsKey(strAcctClassId)){
                strAcctClassName=mpAcctClassIDToAccountclass.get(strAcctClassId).Name;
            }
            id tempBdgAppId;
            tempBdgAppId=(mpBdgLnIDToBdgAppId!=null && mpBdgLnIDToBdgAppId.size()>0 
                                && mpBdgLnIDToBdgAppId.containsKey(itrBdgLine.id))
                        ? mpBdgLnIDToBdgAppId.get(itrBdgLine.id )
                        : null;
           
            tempBdgApp = ( tempBdgAppId!=null && mpBdgAppIdToBdgApp!=null && mpBdgAppIdToBdgApp.size() > 0 && mpBdgAppIdToBdgApp.containsKey(tempBdgAppId))
                                   ? mpBdgAppIdToBdgApp.get(tempBdgAppId)
                                   : null;
            
            System.debug('*** strAcctClassName ***'+strAcctClassName);
            System.debug('***objBASection3Level.cb3__SectionName__c***'+objBASection3Level.cb3__SectionName__c);
            System.debug('***objBASection3Level.cb3__isMembers__c***'+objBASection3Level.cb3__isMembers__c);
            System.debug('***itrBdgLine.cb3__BudgetApplication__r.id***'+itrBdgLine.cb3__BudgetApplication__r.id);
            System.debug('***itrBdgLine.cb3__BudgetApplication__r.name***'+itrBdgLine.cb3__BudgetApplication__r.name);
            System.debug('***itrBdgLine.cb3__BudgetApplication__r.cb3__BudgetForCurrentApplicationYear__c***'+itrBdgLine.cb3__BudgetApplication__r.cb3__BudgetForCurrentApplicationYear__c);
            
           /* if(objBASection3Level.cb3__SectionName__c!=null && objBASection3Level.cb3__SectionName__c!='' && objBASection3Level.cb3__SectionName__c.equalsIgnoreCase('Members')
                                                            && (objBASection3Level.cb3__isMembers__c==true) && setMembersData.contains(strAcctClassName)){
           */  
           /*                                             
            if(objBASection3Level.cb3__SectionName__c!=null && objBASection3Level.cb3__SectionName__c!='' 
                                                            && (objBASection3Level.cb3__isMembers__c==true) && setMembersData.contains(strAcctClassName)
                                                            && (itrBdgLine.cb3__BudgetApplication__r.cb3__BudgetForCurrentApplicationYear__c==true)){  
          */
          if(  (objBASection3Level.cb3__isMembers__c==true) && (setMembersData!=null && setMembersData.size() > 0 && setMembersData.contains(strAcctClassName))
                                                           && (tempBdgApp !=null && tempBdgApp.cb3__BudgetForCurrentApplicationYear__c==true)){ 
                                                                                                            
               objSlotInformation=new SlotInformation();
               objSlotInformation.bdglineId=itrBdgLine.id;
               objSlotInformation.acctClassId=itrBdgLine.cb3__Account__c;
            
               System.debug('*** strAcctClassName ***'+strAcctClassName);
               objSlotInformation.slotType= strAcctClassName;
               
               objSlotInformation.quantity_Rate=itrBdgLine.cb3__TotalAmount__c;
               objSlotInformation.livingAllowanceStipendAmountUnits_TotalAmount   =itrBdgLine.cb3__TotalAmount__c ;
               
               /*  
               if(itrBdgLine.cb3__TotalAmount__c > 0){
                     objSlotInformation.reqWAllowance=itrBdgLine.cb3__TotalAmount__c;}
               else {
                    objSlotInformation.reqWOAllowance= itrBdgLine.cb3__TotalAmount__c;
               }
               */
               if(itrBdgLine.cb3__Rate__c    > 0){
                     System.debug('*** if part-itrBdgLine.cb3__Rate__c    > 0 ***'+itrBdgLine.cb3__Rate__c   );
                     objSlotInformation.reqWAllowance=itrBdgLine.cb3__TotalAmount__c;}
               else {
                    System.debug('*** else part-itrBdgLine.cb3__Rate__c    > 0 ***'+itrBdgLine.cb3__Rate__c   );
                    objSlotInformation.reqWOAllowance= itrBdgLine.cb3__TotalAmount__c;
               }
               System.debug('*** after if condition-'+ 'objSlotInformation.reqWAllowance'+ objSlotInformation.reqWAllowance + 'objSlotInformation.reqWOAllowance'+objSlotInformation.reqWOAllowance );  
               objSlotInformation.recWAllowance=objSlotInformation.reqWAllowance;
               objSlotInformation.recWOAllowance=objSlotInformation.reqWOAllowance;
                 
               objSlotInformation.apprvdWAllowance=objSlotInformation.recWAllowance;
               objSlotInformation.apprvdWOAllowance=objSlotInformation.recWOAllowance;
               
               objSlotInformation.appId=itrBdgLine.ApplicationId__c;
              ///// objSlotInformation.primeAppId=itrBdgLine.PrimeApplicationId__c;
              objSlotInformation.primeAppId=itrBdgLine.Prime_Application_Id__c;
                
               
               if(itrBdgLine.ApplicationId__c!=null && mpAppIdToAwardId.get(itrBdgLine.ApplicationId__c)!=null){
                objSlotInformation.awardId=mpAppIdToAwardId.get(itrBdgLine.ApplicationId__c);
               }
               
               if(itrBdgLine.id!=null && mpBdgLnIDToBdgAppId!=null && mpBdgLnIDToBdgAppId.get(itrBdgLine.id)!=null){
                 objSlotInformation.bdgAppId=mpBdgLnIDToBdgAppId.get(itrBdgLine.id);
               }
             
               lstSlotInformation.add(objSlotInformation);
            }
        }
        
        System.debug('*** lstSlotInformation***'+lstSlotInformation);
        System.debug('*** setBdgLnId***'+setBdgLnId);
        Map<Id,Slot__c> mpExistingIdToSlot=new Map<Id,Slot__c>();
        List<Slot__c> lstUpsSlot=new List<Slot__c>(); 
        Slot__c objSlot=new Slot__c();
        
        for(SlotInformation itrSlotInformation :lstSlotInformation){
            objSlot=new Slot__c();
            objSlot.Slot_Type__c=itrSlotInformation.slotType;
            objSlot.BudgetLine__c=itrSlotInformation .bdglineId;
            System.debug('*** itrSlotInformation.bdglineId;***'+itrSlotInformation .bdglineId);
            System.debug('*** objSlot.BudgetLine__c***'+objSlot.BudgetLine__c);
            objSlot.Application__c= itrSlotInformation.appId;
            objSlot.Recommended_w_Allowance__c=itrSlotInformation.recWAllowance;
            objSlot.Recommended_w_o_Allowance__c=itrSlotInformation.reqWOAllowance;
            objSlot.Requested_w_Allowance__c=itrSlotInformation.reqWAllowance;
            objSlot.Requested_w_o_Allowance__c= itrSlotInformation.recWOAllowance;
            objSlot.Prime_Application__c=itrSlotInformation.primeAppId;
            objSlot.Award__c     = itrSlotInformation.awardId;
            objSlot.Budget_Application__c=itrSlotInformation.bdgAppId;
            lstUpsSlot.add(objSlot);
        }
        System.debug('*** lstUpsSlot***'+lstUpsSlot);
                
        Map<String,Slot__c> mapBdgLineIdToExistingSlotRecs=new Map<String,Slot__c>();
        Map<String,Slot__c> mapBdgLineIdToUpsSlotRecs =new Map<String,Slot__c>();
        mapBdgLineIdToExistingSlotRecs=generateMapBdgLineIdToExistingSlotRecs(setBdgLnId);
        System.debug('*** mapBdgLineIdToExistingSlotRecs***'+mapBdgLineIdToExistingSlotRecs);
        mapBdgLineIdToUpsSlotRecs=manipulateSlotRecs(lstUpsSlot,mapBdgLineIdToExistingSlotRecs);
        System.debug('*** mapBdgLineIdToUpsSlotRecs***'+mapBdgLineIdToUpsSlotRecs);
        List<Slot__c> lstUpdNewSlotRecs=new List<Slot__c>();
        if(mapBdgLineIdToUpsSlotRecs!=null){
            lstUpdNewSlotRecs.addAll(mapBdgLineIdToUpsSlotRecs.values());
        }
        if(lstUpdNewSlotRecs!=null && lstUpdNewSlotRecs.size()>0){
             upsertSlot(lstUpdNewSlotRecs);
        }
        }
        catch(Exception exc){
            System.debug('***exception in spawn information***'+exc.getMessage());
        }
    }
    
    public Map<String,Slot__c> generateMapBdgLineIdToExistingSlotRecs(Set<String> p_SetBudgetLineId){
        System.debug('***p_SetBudgetLineIdp_SetBudgetLineId***'+p_SetBudgetLineId);
        List<Slot__c> lstExistingSlotRecs;
        
        if(p_SetBudgetLineId!=null && p_SetBudgetLineId.size()>0){
        lstExistingSlotRecs=[select id,name,Slot_Type__c,Application__c,Aggregate_Recommendation_w_Allowance__c,
                                                                    Aggregate_Recommendation_w_o_Allowance__c,Approved_With_Allowance__c,Approved_WithOut_Allowance__c,
                                                                    Award__c,BdgLineIdExtId__c,Budget_Application__c,BudgetLine__c,Enrollment_End_Date__c,Enrollment_Start_Date__c,
                                                                    Prime_Application__c,Recommended_w_Allowance__c,Recommended_w_o_Allowance__c,
                                                                    Requested_w_Allowance__c,Requested_w_o_Allowance__c
                                                                 from slot__c where BudgetLine__c       in  :p_SetBudgetLineId ];    // :lstTempBdgLineIds];
         }
         List<Slot__c> lstExistingdupSlotRecs=[select id,name,BudgetLine__c       from slot__c ];                                                         
                                                                 
        System.debug('***lstExistingSlotRecs***'+lstExistingSlotRecs);    
                                                                  
        Map<String,Slot__c> mapBdgLineIdToExistingSlotRecs=new Map<String,Slot__c>();                                                        
        for(Slot__c itrExistingSlotRec: lstExistingSlotRecs){
            if(mapBdgLineIdToExistingSlotRecs!=null && !mapBdgLineIdToExistingSlotRecs.containsKey(itrExistingSlotRec.BudgetLine__c)){
                    mapBdgLineIdToExistingSlotRecs.put(itrExistingSlotRec.BudgetLine__c,itrExistingSlotRec);
            }
        }
        return mapBdgLineIdToExistingSlotRecs;
    }
    
    public Map<String,Slot__c> manipulateSlotRecs(List<Slot__c> p_lstUpsSlot,Map<String,Slot__c> p_mapBdgLineIdToExistingSlotRecs){
         Slot__c tempObjSlot=new Slot__c();
         List<Slot__c> lstUpdNewSlotRecs=new List<Slot__c>();
         Map<String,Slot__c> mapBdgLineIdToUpsSlotRecs =new Map<String,Slot__c>();
         for(Slot__c itrUpsSlotRec :p_lstUpsSlot){
                if(p_mapBdgLineIdToExistingSlotRecs!=null && p_mapBdgLineIdToExistingSlotRecs.containsKey(itrUpsSlotRec.BudgetLine__c)){
                    tempObjSlot=p_mapBdgLineIdToExistingSlotRecs.get(itrUpsSlotRec.BudgetLine__c);
                    tempObjSlot.Recommended_w_Allowance__c      =itrUpsSlotRec.Recommended_w_Allowance__c;
                    tempObjSlot.Recommended_w_o_Allowance__c      =itrUpsSlotRec.Recommended_w_o_Allowance__c;
                    tempObjSlot.Requested_w_Allowance__c    =itrUpsSlotRec.Requested_w_Allowance__c;
                    tempObjSlot.Requested_w_o_Allowance__c    =itrUpsSlotRec.Requested_w_o_Allowance__c;
                    System.debug('if part');
                    System.debug('***tempObjSlot***'+tempObjSlot);
                    System.debug('***itrUpsSlotRec***'+itrUpsSlotRec);
                    p_mapBdgLineIdToExistingSlotRecs.put(itrUpsSlotRec.BudgetLine__c,tempObjSlot);
                    mapBdgLineIdToUpsSlotRecs.put(itrUpsSlotRec.BudgetLine__c,tempObjSlot);
                    lstUpdNewSlotRecs.add(tempObjSlot);
                }
                else{
                    System.debug('else part');
                    System.debug('***itrUpsSlotRec***'+itrUpsSlotRec);
                    mapBdgLineIdToUpsSlotRecs.put(itrUpsSlotRec.BudgetLine__c,itrUpsSlotRec);
                    lstUpdNewSlotRecs.add(tempObjSlot);
                }
        }
        System.debug('***mapBdgLineIdToUpsSlotRecs***'+mapBdgLineIdToUpsSlotRecs);
        return mapBdgLineIdToUpsSlotRecs;
    }
    
    public void upsertSlot(List<Slot__c > p_lstSlot){
     try{
           if(p_lstSlot!=null && p_lstSlot.size()>0){
                upsert  p_lstSlot;
           }
         
         }catch(Exception exc){
             System.debug('AppSlot Information upsert error***'+exc.getMessage());
         }  
    }
    
    public void updateApp_TotalRecommendedMSY(List<cb3__BudgetLine__c> p_OldlstBdgLns,
                                            List<cb3__BudgetLine__c> p_NewlstBdgLns,
                                            Map<Id,cb3__BudgetLine__c> p_OldMap,
                                            Map<Id,cb3__BudgetLine__c> p_NewMap ){                     
        System.debug('***updateApp_TotalRecommendedMSY invoked from BdgLinetrigger ***');
        Map<Id,Id> mpBdgLnIdToBdgAppId=new Map<Id,Id>();
        Set<Id> stBdgAppId=new Set<Id>();
        List<cb3__Budget__c> lstBdgAppWithBdgLn= new List<cb3__Budget__c>();
        Boolean bdgForCurrAppYear;
        Map<Id,Double> mpAppIdToTotalRecommendedMSY=new Map<id,Double>();
        List<Application3__c> lstUpdApp=new List<Application3__c>();
        
        try{
            for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
                mpBdgLnIdToBdgAppId.put(itrBdgLine.id,itrBdgLine.cb3__BudgetApplication__c);
                stBdgAppId.add(itrBdgLine.cb3__BudgetApplication__c);
            }
            System.debug('***mpBdgLnIdToBdgAppId***'+mpBdgLnIdToBdgAppId+'***stBdgAppId***'+stBdgAppId);
            lstBdgAppWithBdgLn= [SELECT ID,cb3__BudgetForCurrentApplicationYear__c,
                                    (SELECT Id, Name, applicationId__c,cb3__TotalMSY__c
                                     FROM cb3__BudgetApplicationBudgetLines__r)
                                 FROM cb3__Budget__c
                                 WHERE id in :stBdgAppId];
            System.debug('***lstBdgAppWithBdgLn***'+lstBdgAppWithBdgLn);
            Double bdgLineTotalMSY;
            for(cb3__Budget__c itrBdgApp  :lstBdgAppWithBdgLn){
                mpAppIdToTotalRecommendedMSY=new Map<id,Double>();
                bdgForCurrAppYear=itrBdgApp.cb3__BudgetForCurrentApplicationYear__c;
                bdgLineTotalMSY=0;
                if(bdgForCurrAppYear!=null && bdgForCurrAppYear==true){
                    for(cb3__BudgetLine__c itrBdgLn :itrBdgApp.cb3__BudgetApplicationBudgetLines__r){
                            bdgLineTotalMSY+=itrBdgLn.cb3__TotalMSY__c;
                            /*if(mpAppIdToTotalRecommendedMSY!=null && 
                                    mpAppIdToTotalRecommendedMSY.size()> 0 &&
                                    mpAppIdToTotalRecommendedMSY.containsKey(itrBdgLn.applicationId__c)){*/
                                mpAppIdToTotalRecommendedMSY.put(itrBdgLn.applicationId__c,bdgLineTotalMSY) ;
                            /*}else if(mpAppIdToTotalRecommendedMSY!=null){
                               mpAppIdToTotalRecommendedMSY.put(itrBdgLn.applicationId__c,bdgLineTotalMSY);
                            
                            }*/
                    }
                }   
            }
  
            if(mpAppIdToTotalRecommendedMSY!=null && mpAppIdToTotalRecommendedMSY.size() > 0 ){
                Application3__c tempApp;
                for(Id itrId : mpAppIdToTotalRecommendedMSY.keyset()){
                    tempApp=new Application3__c();
                    tempApp.id=itrId;
                    tempApp.Total_Recommended_MSYs__c=mpAppIdToTotalRecommendedMSY.get(itrId);
                    lstUpdApp.add(tempApp);
                }
                system.debug('***lstUpdApp***'+lstUpdApp);
                if(lstUpdApp!=null && lstUpdApp.size()>0){
                    system.debug('***lstUpdApp***'+lstUpdApp);
                    update lstUpdApp;
                }
            }
        }
        catch(QueryException qryExc){
                System.debug('***QueryException in method-deleteSlotsForDeletedBdgLine()-*** '+qryExc.getMessage());
        }
        catch(DmlException dmlExc){
                System.debug('***DMLException in method-deleteSlotsForDeletedBdgLine()-*** '+dmlExc.getMessage());
        }
        catch(NoDataFoundException noDataFoundExc){
                System.debug('***No data found exception in method-deleteSlotsForDeletedBdgLine()-*** '+noDataFoundExc.getMessage());
        }
        catch(Exception exc){
              System.debug('***Exception in method-deleteSlotsForDeletedBdgLine()-*** '+exc.getMessage());
        }
    } 
    
    
    
    //this method is not used
    public void updateApp_TotalRecommendedMSY_old(List<cb3__BudgetLine__c> p_OldlstBdgLns,List<cb3__BudgetLine__c> p_NewlstBdgLns,Map<Id,cb3__BudgetLine__c> p_OldMap,Map<Id,cb3__BudgetLine__c> p_NewMap ){                     
         System.debug('***updateApp_TotalRecommendedMSY invoked from BdgLinetrigger ***');
        Double tempTotalMSY=0;
        Double bdgLineTotalMSY;
        Boolean bdgForCurrAppYear;
        String appId;
        Map<String,Double> mpAppIdToTotalMSY=new Map<String,Double>();
        Map<Id,Id> mpBdgLnIdToBdgAppId=new Map<Id,Id>(); 
        Set<Id> stBdgAppId=new Set<Id>();
        Map<Id,cb3__Budget__c> mapBdgAppidToBdgApp= new map<Id,cb3__Budget__c>();
        cb3__Budget__c tempBdgAppRec = new cb3__Budget__c();
        id tempBdgAppid;
        try{
        
            //
            stBdgAppId=new Set<Id>();
            for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
                mpBdgLnIdToBdgAppId.put(itrBdgLine.id,itrBdgLine.cb3__BudgetApplication__c);
                stBdgAppId.add(itrBdgLine.cb3__BudgetApplication__c);
            }
            System.debug('***mpBdgLnIdToBdgAppId***'+mpBdgLnIdToBdgAppId+'***stBdgAppId***'+stBdgAppId);
            
            mapBdgAppidToBdgApp= new Map<Id,cb3__Budget__c>([SELECT ID,cb3__BudgetForCurrentApplicationYear__c 
                                 FROM cb3__Budget__c
                                 WHERE id in :stBdgAppId]);
            
            System.debug('***mapBdgAppidToBdgApp***'+mapBdgAppidToBdgApp);
            //
            
            for(cb3__BudgetLine__c itrBdgLine :p_NewlstBdgLns){
                //bdgForCurrAppYear=itrBdgLine.cb3__BudgetApplication__r.cb3__BudgetForCurrentApplicationYear__c;
                if(mpBdgLnIdToBdgAppId!=null && mpBdgLnIdToBdgAppId.size()>0 &&  mpBdgLnIdToBdgAppId.containsKey(itrBdgLine.id)){
                    tempBdgAppid=mpBdgLnIdToBdgAppId.get(itrBdgLine.id);
                    if(mapBdgAppidToBdgApp!=null && mapBdgAppidToBdgApp.size()>0 && mapBdgAppidToBdgApp.containskey(tempBdgAppid)){
                        tempBdgAppRec=mapBdgAppidToBdgApp.get(tempBdgAppid);
                    }
                }
                bdgForCurrAppYear=tempBdgAppRec.cb3__BudgetForCurrentApplicationYear__c;
                appId=itrBdgLine.applicationId__c;
                System.debug('***bdgForCurrAppYear***'+bdgForCurrAppYear+'***appId***'+appId);
                System.debug('***mpAppIdToTotalMSY***'+mpAppIdToTotalMSY);
                if(bdgForCurrAppYear!=null && bdgForCurrAppYear==true){
                    if(mpAppIdToTotalMSY!=null && mpAppIdToTotalMSY.size()>0 && mpAppIdToTotalMSY.containsKey(appid)){
                        System.debug('*** if part-appid exists in Map***');
                        tempTotalMSY=mpAppIdToTotalMSY.get(appId);
                        bdgLineTotalMSY=(itrBdgLine.cb3__TotalMSY__c!=null )?itrBdgLine.cb3__TotalMSY__c:0;
                        tempTotalMSY+=bdgLineTotalMSY;
                        mpAppIdToTotalMSY.put(appId,tempTotalMSY);
                    }
                    else if(mpAppIdToTotalMSY!=null){
                           System.debug('*** else part-appid does not exists in Map***');
                           bdgLineTotalMSY=(itrBdgLine.cb3__TotalMSY__c!=null )?itrBdgLine.cb3__TotalMSY__c:0;
                           mpAppIdToTotalMSY.put(appId,bdgLineTotalMSY); 
                    }
               }
            }
            System.debug('***mpAppIdToTotalMSY***'+mpAppIdToTotalMSY);
            List<Application3__c> lstApp=new List<Application3__c>();
            Application3__c objApp=new Application3__c();
            for (String strAppId : mpAppIdToTotalMSY.keySet()) {
                tempTotalMSY=mpAppIdToTotalMSY.get(strAppId);
                objApp=new Application3__c();
                objApp.id=strAppId;
                objApp.Total_Recommended_MSYs__c=tempTotalMSY;
                lstApp.add(objApp);
            }
            system.debug('***lstApp***'+lstApp);
            if(lstApp!=null && lstApp.size()>0){
                system.debug('***lstApp***'+lstApp);
                update lstApp;
            
            }
        }catch(Exception exc){
           System.debug('***exception in method-updateApp_TotalRecommendedMSY');
        }   
    } 
    
    /* this method is invoked on deleting record(s) of object BudgdgetLine(cb3__BudgetLine__c) to delete associated slot records */
    public void deleteSlotsForDeletedBdgLine(List<cb3__BudgetLine__c> p_OldLstBdgLn){
        List<Slot__c> lstSlotsToBeDeleted = new List<Slot__c>();
        Set<String> setBdgLnId=new Set<String>();
        Database.DeleteResult[] delRes;
        try{
             for(cb3__BudgetLine__c itrBdgLn : p_OldLstBdgLn){
                 setBdgLnId.add(itrBdgLn.id);
             }
             
            if(setBdgLnId!=null && setBdgLnId.size()>0){
                lstSlotsToBeDeleted =[SELECT id,BudgetLine__c  
                                      From Slot__c 
                                      WHERE BudgetLine__c in :setBdgLnId];
                
                if( lstSlotsToBeDeleted !=null && lstSlotsToBeDeleted.size() > 0) {
                   delRes = Database.DELETE(lstSlotsToBeDeleted);
                }                  
            }
       }
       catch(QueryException qryExc){
            System.debug('***QueryException in method-deleteSlotsForDeletedBdgLine()-*** '+qryExc.getMessage());
       }
       catch(DmlException dmlExc){
            System.debug('***DMLException in method-deleteSlotsForDeletedBdgLine()-*** '+dmlExc.getMessage());
            for (Database.DeleteResult del: delRes){
                if(del.isSuccess()){
                        SYSTEM.DEBUG(' Deleted record(Slot__c)Id  :'+del.getId());
                }else{
                    SYSTEM.DEBUG('ERROR : Error occurs unable to delete (Slot__c)record :'+del.getErrors());
                }
            }
        }
        catch(NoDataFoundException noDataFoundExc){
            System.debug('***No data found exception in method-deleteSlotsForDeletedBdgLine()-*** '+noDataFoundExc.getMessage());
        }
        catch(Exception exc){
          System.debug('***Exception in method-deleteSlotsForDeletedBdgLine()-*** '+exc.getMessage());
        }
    } 
    
    
    
}