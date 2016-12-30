trigger ContactTrigger on Contact (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    if(trigger.isBefore ){
       if(trigger.isUpdate){
            System.debug('***Contact Before Insert, Before Update***');
            Map<ID, Contact> mpContact = new Map<ID, Contact>([SELECT Id, SSN__c FROM Contact where id IN : Trigger.new]);
            Set<String> setSSN= new Set<String>();
            List<Contact> lstContact=mpContact.values();
            System.debug(lstContact);
            Set<Contact> setContact=new Set<Contact>();
            for(Contact itrContact  :lstContact ){
                  if (itrContact.SSN__c!=NULL && itrContact.SSN__c!=''){
                     setSSN.add(itrContact.SSN__c );
                  }
            }
                
            for(Contact itrContact  :Trigger.new){
                Contact oldContact= Trigger.oldMap.get(itrContact.ID); 
                   
                if((itrContact.SSN__c != oldContact.SSN__c ) ){
                    if(itrContact.SSN__c !=null && itrContact.SSN__c !=''
                                        && setSSN.contains(itrContact.SSN__c ) ){
                                itrContact.addError('SSN should be Unique...');                            
                    }
                }
            }
        }
    }
    
   if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUpdate){
            //Notifying Grantee Admin about Grantee approval - Start.
            
            NotifyGranteeAdmin nGA = new NotifyGranteeAdmin();
            nGA.notifyEmailGranteeAdmin(trigger.new,trigger.oldmap);
            
            //Notifying Grantee Admin about Grantee approval - End.
        }       
    }
    
}