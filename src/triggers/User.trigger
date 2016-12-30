trigger User on User (after insert,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            UserHelper.shareOrganizationEditPermission(trigger.oldmap,trigger.newmap);
            //UserHelper.assignUserstoGroup(trigger.newmap);             
            UserHelper.shareRecords(trigger.oldmap,trigger.newmap);                          
        }       
    }
    

}