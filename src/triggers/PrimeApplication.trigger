trigger PrimeApplication on Prime_Application__c (before insert,before update,after insert,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            PrimeApplicationHelper.shareRecords(trigger.new); 
        }
        if(trigger.isUpdate){
            PrimeApplicationHelper.shareRecordsWithGrantees(trigger.new);
        }
    }
    if(trigger.isAfter){
        if(trigger.isUpdate){
            primeApplicationHelper.updateFormulaSubAppsToAwarded(trigger.oldMap,trigger.newMap);
            primeApplicationHelper.updateSubAppsToAccepted(trigger.oldMap,trigger.newMap); 
        }
    }
    if(trigger.isBefore){
        if(trigger.isUpdate){
            primeApplicationHelper.populateProgramDates(trigger.OldMap,trigger.newMap);
            //primeApplicationHelper.projectTitleUpdate(trigger.new);
        }
        if(trigger.isInsert){
            primeApplicationHelper.populateCorpProg(trigger.new);
        }
    }

}