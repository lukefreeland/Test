public class SlotInformationWithAwardCntrl{

    public ApexPages.StandardController stdController;
    public Award__c award{get;set;}
    public List<Slot__c> lstSlot{get;set;}
    //
   // public List<SlotInformationWithPrmAppCntrl.SlotGroupedData> lstSlotGroupedData{get;set;}
    public List<SlotGroupedData> lstSlotGroupedData{get;set;}
    public Boolean flgPrmAward{get;set;}
    //
    
    public SlotInformationWithAwardCntrl(){
          System.debug('***SlotInformationWithAwardCntrl constructor***');
    
    }
     
    public SlotInformationWithAwardCntrl(ApexPages.StandardController p_controller){
    try{
      this.stdController= p_controller;
      this.award= (Award__c )stdController.getrecord();
      System.debug('***award***'+award.id);
      String strAwardId='';
      strAwardId=(award!=null )? award.id:'';
      String strAppId=(award!=null )? award.Application_ID__c:'';
      //
          String strPrmAppId=(award!=null )? award.Prime_Application__c:null;
          System.debug('***strPrmAppId***'+strPrmAppId);
          String awrdRecTypeId=(award!=null )? award.RecordTypeId:null;
          System.debug('***awrdRecTypeId***'+awrdRecTypeId);
          String prmAwrdRecTypeId=CNCS_ObjectUtility.getObjectRecordTypeId(AWARD__c.SObjectType, 'Prime Award');
          flgPrmAward=(prmAwrdRecTypeId==awrdRecTypeId && strPrmAppId!=null && strPrmAppId!='')?true:false;
          System.debug('***flgPrmAward***'+flgPrmAward);
          if(flgPrmAward){
            //SlotInformationWithPrmAppCntrl objSlotInformationWithPrmAppCntrl= new SlotInformationWithPrmAppCntrl();
            //objSlotInformationWithPrmAppCntrl.deriveAggregateData(strPrmAppId);
            deriveAggregateData(strPrmAppId);
          }
          else{
              readSlotInformation(strAwardId,strAppId);
          }
      }
      catch(Exception exc){
                 System.debug('***error in SlotInformationWithAwardCntrl constructor***'+exc.getMessage());
      }   
   }
     
    public void readSlotInformation(String p_StrAwardId,String p_StrAppId){
         System.debug('***p_StrAwardId***'+p_StrAwardId+'***p_StrAppId***'+p_StrAppId);
         if((p_StrAwardId!=null && p_StrAwardId!='')||(p_StrAppId!=null && p_StrAppId!='')){
              lstSlot =[SELECT ID,NAME,Slot_Type__c,Award__c,Prime_Application__c,ApplicationId__c,Application__c,Budget_Application__c,BudgetLine__c,
                               Requested_w_Allowance__c,Requested_w_o_Allowance__c,
                               Recommended_w_Allowance__c,Recommended_w_o_Allowance__c,
                               Aggregate_Recommendation_w_Allowance__c,Aggregate_Recommendation_w_o_Allowance__c,
                              /* Enrollment_Start_Date__c,Enrollment_End_Date__c,*/  //commented as per Khalid bugs list doc- dated 09272016
                               Approved_With_Allowance__c,Approved_WithOut_Allowance__c 
                        FROM SLOT__c  Where (Application__c != null) 
                            AND (Award__c= :p_StrAwardId or Application__c= :p_StrAppId) and BudgetLine__c!=null];
         }                 
         System.debug('*** lstSlot ***'+lstSlot );    
    }
    
    public PageReference updateSlotRecs(){
        try{
           System.debug('*** lstSlot ***'+lstSlot );
           if(lstSlot !=null && lstSlot.size()>0){
             Update lstSlot ;
           }
        }
        catch(DMLException dmlExc){
            System.debug('***DMLException -lstSlot ***'+dmlExc);
        }
        catch(Exception exc){
            System.debug('***lstSlot ***'+exc );
             //System.debug('***excMsg***' +exc.getMesssage());
        }
        return null;
    }
    
     public void deriveAggregateData(String p_strPrmAppId){  
            
        AggregateResult[] groupedResults;
        //List<SLOt__c> lstSlot=[select name from slot__c where name = :strPrmAppId];
        //System.debug('***lstSlot' + lstSlot);
        try{
            groupedResults=[select Slot_Type__c st,sum(Recommended_w_Allowance__c) awa,sum(Recommended_w_o_Allowance__c) awoa 
                                  from slot__c where Prime_Application__c= :p_strPrmAppId  and BudgetLine__c !=null
                                  group by  Slot_Type__c];
            System.debug('***groupedResults' + groupedResults);
            
            SlotGroupedData objTempSlotGroupedData=new SlotGroupedData();
            lstSlotGroupedData=new List<SlotGroupedData>();
            for (AggregateResult ar : groupedResults)  {
                System.debug('st' + ar.get('st'));
                System.debug('Aggr Recommended_w_Allowance' + ar.get('awa'));
                System.debug('Aggr Recommended_w_o_Allowance' + ar.get('awoa'));
                objTempSlotGroupedData=new SlotGroupedData();
                objTempSlotGroupedData.strSlotType=(ar.get('st')!=null )?String.valueOf(ar.get('st')):'';
                /*
                objTempSlotGroupedData.AggregateRecommendationWAllowance= (ar.get('awa')!=null )?String.valueOf(ar.get('awa')):'';    
                objTempSlotGroupedData.AggregateRecommendationWOAllowance=(ar.get('awoa')!=null) ?String.valueOf(ar.get('awoa')):''; 
                */
                if(ar.get('awa')!=null && ar.get('awa')!=0){
                    objTempSlotGroupedData.AggregateRecommendationWAllowance=String.valueOf(ar.get('awa'));   
                }else if(ar.get('awa')!=null && ar.get('awa')==0){
                    objTempSlotGroupedData.AggregateRecommendationWOAllowance=String.valueOf(ar.get('awa'));
                }

                if(ar.get('awoa')!=null ){
                    objTempSlotGroupedData.AggregateRecommendationWOAllowance=String.valueOf(ar.get('awoa'));   
                }
                
                
                lstSlotGroupedData.add(objTempSlotGroupedData);
            }
       }catch(DMLException sqlExc){
          System.debug('SQLException in method deriveAggregateData'+sqlExc);
       }
       catch(Exception exc){
           System.debug('SQLException in method deriveAggregateData'+exc);
       }     
    }   
    
    
    public class SlotGroupedData{
                public String strSlotType{get;set;}
                Public String AggregateRecommendationWAllowance{get;set;}
                Public String AggregateRecommendationWOAllowance{get;set;}
    } 
}