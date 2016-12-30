public with sharing class RFPClassYearHelper {
    public static void preventClassYearforCampus(list<RFP_Class_year__c> rfpCls){
        set<Id> rfpIds = new set<Id>();
        set<Id> clsIds = new set<Id>();
        for(RFP_Class_year__c r:rfpCls){
            if(r.NOFO_RFP__c != null){
                rfpIds.add(r.NOFO_RFP__c);              
            }
            if(r.Class_Year__c!=null){
                clsIds.add(r.Class_Year__c);
            }
        }
        list<RFP_Class_year__c> existingRfpCls = new list<RFP_Class_year__c>([Select Id,Name,NOFO_RFP__c,Class_Year__c,Class_Year__r.Region__c from RFP_Class_year__c where NOFO_RFP__c in :rfpIds]);
        Map<Id,Class__c> clsYrMap = new Map<Id,Class__c>([Select Id,Name,Region__c from Class__c where Id in :clsIds]);
        for(RFP_Class_year__c r:rfpCls){
            for(RFP_Class_year__c er:existingRfpCls){
                if(r.NOFO_RFP__c == er.NOFO_RFP__c){
                    if(er.Class_Year__r.Region__c == clsYrMap.get(r.Class_Year__c).Region__c){
                        r.adderror('The campus for the selected class year must be unique');
                    }
                }
            }
        }
         
    }
}