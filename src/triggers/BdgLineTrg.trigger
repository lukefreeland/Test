/* trigger used for after insert, after update, before delete record operations on object budgetLine(cb3__BudgetLine__c) */
trigger BdgLineTrg on cb3__BudgetLine__c (after insert, after update) {
    System.debug('***BudgetLine***');
    if (Trigger.isAfter){
         if (Trigger.isInsert || Trigger.isUpdate){
             System.debug('***BdgLineTrg isAfter-Insert, Update***');
             AppSlotInformation objSlotInformation= new AppSlotInformation();
             objSlotInformation.spawnInformation(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
             objSlotInformation.updateApp_TotalRecommendedMSY(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
         }
     }
     if (Trigger.isBefore){
        /* below block of code is to delete slot records on the deletion of BudgetLine(cb3__BudgetLine__c) records */
        if(trigger.isDelete){
             AppSlotInformation objSlotInformation= new AppSlotInformation();
             System.debug('***BdgLineTrg isAfter-Delete***');
             objSlotInformation.deleteSlotsForDeletedBdgLine(Trigger.old);
        }
    }
}