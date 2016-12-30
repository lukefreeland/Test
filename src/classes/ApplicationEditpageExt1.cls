Public Class ApplicationEditpageExt1{

public Application3__c applicationInput {get; set;}
public Boolean displayMsg{get;set;}
public String id;
public Boolean fieldSet1Visibility {get; set;}
public Boolean fieldSet2Visibility {get; set;}
public Boolean fieldSet3Visibility {get; set;}
public string productType {get;set;}

public list<Application3__c> typeOfProduct {get; set;}

Public ApplicationEditpageExt1(ApexPages.StandardController controller){
  applicationInput=new Application3__c();
  displayMsg=False;
  id=Apexpages.currentPage().getParameters().get('id');
 applicationInput.Status__c='None';
  If(id!=null && id!='')
  //Nofa=[Select Foster_Grandparents_Only__c,RSVP_Only__c from NOFA__c where id=:id]; 
  applicationInput= [Select id,Status__c FROM Application3__c where id = :id];
  
}

public PageReference edit() {   
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/apex/Application?id='+id);

return Redirect;
}

return null;
}



public PageReference save() {   
PageReference Redirect;
If(id!=null && id!=''){
Redirect = new PageReference('/'+id);
applicationInput.Status__c='Submitted';
update applicationInput;
//return Redirect;
}
else
{

applicationInput.Status__c='Submitted';
insert applicationInput;
system.debug('record id-->'+applicationInput.id);

Redirect = new   PageReference('/apex/ApplicationDetailPage?id='+applicationInput.id);
Redirect.setRedirect(true);
//return newpage;
}
return Redirect;
}




public PageReference setEditVisibility() {

        fieldset1Visibility = FALSE;
        fieldset2Visibility = FALSE;
        fieldset3Visibility = FALSE;

       /* if(record.Concept_Paper!= null) {
            productType = record.Concept_Paper;
        } else {
            productType = productSelection;
        }

*/
        if (applicationInput.Status__c == 'None') {

                fieldset1Visibility = false;
        } else if (applicationInput.Status__c == 'Product 2') {

                fieldset2Visibility = TRUE;
        } 
        return null;
    }
    
    Public PageReference SaveAsDraft()
    {
          PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/apex/ApplicationDetailPage'+id);
        applicationInput.Status__c='Pre-Submitted';      
        insert applicationInput;
        System.debug('app;lication values-->'+applicationInput);
       // return Redirect;
        }
        
        else
        {

        applicationInput.Status__c='Pre-Submitted';
        insert applicationInput;
        system.debug('record id-->'+applicationInput.id);

        Redirect = new   PageReference('/apex/ApplicationDetailPage?id='+applicationInput.id);
        Redirect.setRedirect(true);
        //return newpage;
        }

            
        return Redirect;
          
    }
        
      Public PageReference Reopen()
    {
          PageReference Redirect;
        If(id!=null && id!=''){
        Redirect = new PageReference('/'+id);
      
        update applicationInput;
        System.debug('app;lication values-->'+applicationInput);
        return Redirect;
        }
            
        return null;
          
    }  
    
     

}