public class CreateExternalAccountCntrl {
      
    public String Address{get;set;}
    public List<SelectOption> options{get;set;}
    public Account Account{get;set;}
    public Boolean displayPopup {get; set;} 
    public Boolean PhoneValidation {get; set;}
    public String userId;
    public Map<String,String> mpSuggestedAddresses;
    public String strProcessStatusMsg{get;set;}
   
    public CreateExternalAccountCntrl (){
         userId = ApexPages.currentPage().getParameters().get('uid');
         system.Debug('userId-------'+userId);
         mpSuggestedAddresses=new map<String,String>();
         Account = new Account();
         String strURL=System.URL.getSalesforceBaseUrl().toExternalForm();
    }
     
    public AddressRequest  prepareRequestForAddressDoctor(){
     
         AddressRequest objAddressRequest = new AddressRequest();
         String  strSplittedAddress;
         //assign data
         if(Account!=null && Account.Address_1__c!=''){
            //String  strSplittedAddress1='2520  dulles station blvd';
            strSplittedAddress=Account.Address_1__c;
            String []str; 
            if(strSplittedAddress.contains(' ')){
                integer spaceIndex= strSplittedAddress.indexof(' ');
                System.debug('spaceindex'+spaceIndex);
                String strHno=strSplittedAddress.subString(0,spaceIndex);
                System.debug('strHno'+strHno);
                String strStreet=strSplittedAddress.subString(spaceIndex+1,strSplittedAddress.length());
                System.debug('strStreet'+strStreet);
                objAddressRequest.houseNumber = new List<String>{strHno};
                objAddressRequest.street = new List<String>{strStreet};
            }
            else{
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please provide House Number along with Street'));
                  
            }
            // objAddressRequest.houseNumber = new List<String>{'123'};
            //System.debug('House Number Value ....... @@@@@@@@@@@@' +objAddressRequest.houseNumber);
            // objAddressRequest.street = new List<String>{Account.Address_1__c};
            // System.debug('Street Value ....... @@@@@@@@@@@@' +objAddressRequest.street);
             objAddressRequest.locality= new List<String>{Account.City__c};
             System.debug('City Value ....... @@@@@@@@@@@@' +objAddressRequest.locality);
             objAddressRequest.province = new List<String>{Account.States__c};
             System.debug('Province Value ....... @@@@@@@@@@@@' +objAddressRequest.province);
             objAddressRequest.postalCode = new List<String>{Account.Zip1__c};
             System.debug('Postal code Value ....... @@@@@@@@@@@@' +objAddressRequest.postalCode);
             objAddressRequest.country = new List<String>{'United States'};
             System.debug('Country Value ....... @@@@@@@@@@@@' +objAddressRequest.country);
             return objAddressRequest;
         }
         else{
           // Apexpages.addMessage('Please provide Address details');
            return null;
        }
    }
     
     public void invokeAddressDoctor(){
         try{
             AddressRequest objAddressRequest = prepareRequestForAddressDoctor();
             System.debug('***objAddressRequest ***'+objAddressRequest );
             CNCS_WebServiceGateWay objCNCS_WebServiceGateWay=new CNCS_WebServiceGateWay('ADDRESSDOCTOR');
             AddressDoctorWSStub.Response objAddressDoctorWSStubResponse=objCNCS_WebServiceGateWay.connectToAddressDoctor(objAddressRequest);
             System.debug('***objAddressDoctorWSStubResponse***'+objAddressDoctorWSStubResponse);
             AddressDoctorResponse  objAddressDoctorResponse =AddressDoctorResponse.parseAddressDoctorWSStubResponse(objAddressDoctorWSStubResponse);
             System.debug('*** in method invokeAddressDoctor===>objAddressDoctorResponse ***'+objAddressDoctorResponse );
             
             fillNewSuggestedAddress(objAddressDoctorResponse);
          }
         //add callout exception
         catch(NullPointerException nullPtrExc){
             System.debug('*** invokeAddressDoctor NullPointerException ***'+nullPtrExc);
         }
         catch(Exception exc){
             System.debug('*** invokeAddressDoctor Exception ***'+exc);
         }
     }
     
    public void fillNewSuggestedAddress(AddressDoctorResponse  objAddressDoctorResponse){
        //for adding the suggested address from AddressDoctor into RadioButtons
        mpSuggestedAddresses=new map<String,String>();
        options = new List<SelectOption>();
        for(AddressDoctorResponse.Result itrObjAddressDoctorResponseResult    : objAddressDoctorResponse.lstResult){
            if(itrObjAddressDoctorResponseResult.processStatus!=null 
                                && itrObjAddressDoctorResponseResult.processStatus!=''){
                strProcessStatusMsg=AddressDoctorResponse.evaluateProcessStatus(itrObjAddressDoctorResponseResult.processStatus);
            }
            /*if(itrObjAddressDoctorResponseResult.mailabilityScore!=null && itrObjAddressDoctorResponseResult.mailabilityScore!=''){
                strMailabilityScoreMsg=AddressDoctorResponse.evaluateMailabilityScore(itrObjAddressDoctorResponseResult.mailabilityScore);
            }*/
            // options.add(new SelectOption(itrObjAddressDoctorResponseResult.addressComplete,itrObjAddressDoctorResponseResult.addressComplete+ '*** Mailability '+  strMailabilityScoreMsg)); 
            options.add(new SelectOption(itrObjAddressDoctorResponseResult.addressComplete,itrObjAddressDoctorResponseResult.addressComplete)); 
            ///String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.houseNumber+' '+itrObjAddressDoctorResponseResult.street+'~';
            String strConcatenatedAddressWithTilde=itrObjAddressDoctorResponseResult.street+'~';
            strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.locality+'~';
            strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.province+'~';
            strConcatenatedAddressWithTilde+=itrObjAddressDoctorResponseResult.postalCode;
            mpSuggestedAddresses.put(itrObjAddressDoctorResponseResult.addressComplete,strConcatenatedAddressWithTilde);
        } 
    }
     
    public PageReference addressSelection(){
        try{
            if(Address!=null){
                 System.debug('###mpSuggestedAddresses###'+mpSuggestedAddresses+'###Address###'+Address);
                 String strSelectedAddress=mpSuggestedAddresses.get(Address);
                 List<String> lstAddressSubFields=strSelectedAddress.split('~');
                 System.debug('###lstAddressSubFields###'+lstAddressSubFields);
                if(lstAddressSubFields!=null && lstAddressSubFields.size()>0){
                    displayPopup = false;
                    Account.Address_1__c=lstAddressSubFields[0].subString(1,lstAddressSubFields[0].length()-1);
                    Account.City__c=lstAddressSubFields[1].subString(1,lstAddressSubFields[1].length()-1);
                    string tempStates=lstAddressSubFields[2].split(',')[0];
                    Account.States__c=tempStates.subString(1,3);
                    if(lstAddressSubFields[3]!=Null && lstAddressSubFields[3].contains('-')){
                        String tempZip=lstAddressSubFields[3].split('-')[0];
                        Account.Zip1__c=tempZip.subString(1,tempZip.length());
                        //Account.Zip1__c=lstAddressSubFields[3].subString(1,lstAddressSubFields[3].length()-1);
                        //if(lstAddressSubFields[3]!=Null && lstAddressSubFields[3].contains('-')){
                        String tempZip1=lstAddressSubFields[3].split('-')[1];
                        Account.Zip_4__c=tempZip1.subString(0,tempZip1.length()-1);
                    }
                    //return createuser();
                    return  createNewUser();
                   // pagereference pr =new pagereference('/apex/granteeportal/Createorganization');
                    // return pr;
                }
            }
            else{
                ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Warning,'Please select one option to update' );
                ApexPages.addmessage(msg);
            }
        }
        catch(NullPointerException npExc){
             System.debug('***NullPointerException in Method addressSelection***'+npExc.getMessage());
        }
        catch(Exception exc){
             System.debug('***Exception in Method addressSelection***'+exc.getMessage());
        }
             return null; 
    } 
    
    public boolean validatePhone(){ 
    if(Account.Phone__c != null){ 
        String phoneNumber = Account.Phone__c ; 
        Pattern phonePattern = Pattern.compile('\\D*?(\\d\\D*?){10}'); 
        Pattern numericPattern = Pattern.compile('[0-9]{10}'); 
        Matcher phoneMatcher = phonePattern.matcher(phoneNumber); 
        if(phoneNumber.length() == 10){ 
            Matcher numericMatcher = numericPattern.matcher(phoneNumber); 
            if(numericMatcher.matches()){ 
                return true; 
            } 
            else{ 
                return false; 
            } 
        } 
        else{ 
            return false ; 
        } 
    }
    return null; 
}

        
    Public PageReference PageRedirect(){
        PhoneValidation = validatePhone();
        if(Account.Zip1__c.length()== 5 && (Account.DUNS__c==null || Account.DUNS__c=='' || Account.DUNS__c.length()==9) && PhoneValidation==True){
       
             displayPopup = true;
             invokeAddressDoctor();
          }
           else{
             if(Account.Zip1__c.length()!=5){
              ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Zip field Should contain 5 digits' );
              ApexPages.addmessage(msg);
             }
             if(Account.DUNS__c!=null && Account.DUNS__c.length()!=9){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'DUNS number should contain 9 digits'));
             }
             if(PhoneValidation == False){
                 ApexPages.Message msg = new Apexpages.Message(ApexPages.Severity.Error,'Please Enter Valid Phone Number' );
                 ApexPages.addmessage(msg);
             
             }    
          }
        return null;
    }  

    public pagereference closePopup() {        
        displayPopup = false;    
        pagereference pr;
        //pr = createuser();
        return createNewUser();
        return pr;
    }
         
    public void showPopup() {        
        displayPopup = true;    
    }
    
    public void unshowPopup(){
        displayPopup = false;
    }
          
    public void create(){
        PageReference pr =null;
        try{
            system.Debug(LoggingLevel.Info,+account.Ein__c);
            
           if(account.EIN__c == null || account.EIN__c ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter a value for EIN number'));
           }
           pageRedirect();
        }
        catch(Exception e){  
           system.debug('e = '+e);  
           String msg = e.getMessage();  
           if(msg.contains('You can select only')){
               //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You can select only three values from the Organization Type list'));
           }else{ 
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,''+e.getMessage()));
           }
        }
        //   return pr;
    }
    
    public PageReference cancelRecord(){
       PageReference pr  =new PageReference('/apex/Login_Page'); 
       return pr;
    }
    
    public Account  createNewAccount(){
        Profile  prof = [Select id, Name 
                         FROM Profile 
                         WHERE Name = 'System Administrator' limit 1];
                         
        User newUser = [Select id, Name 
                        FROM User 
                        WHERE ProfileId =: prof.Id 
                        ORDER BY FirstName ASC Limit 1];
        account.ownerId = newUser.Id;
        account.Created_from_Portal__c = true;
        insert account;
        return account;
    }
    
    public Contact updateNewContact(Account account){
        Contact newContact =[SELECT id,AccountId,RecordtypeId,FirstName,LastName,Email,CommunityAuto__c 
                             FROM Contact 
                             WHERE  Id =:userId limit 1];
        newContact.AccountId = account.Id;
        //Added Code by Sravan on 12/19/2015 - Start
        newContact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Grantee Admin').getRecordTypeId();
        newContact.Status__c = 'Accepted';
        //Added Code by Sravan on 12/19/2015 - End
        update newContact;
        return newContact;
    }
        
    public PageReference createNewUser(){
        PageReference pr=null;
        try{
            account=createNewAccount();
            Contact newContact=updateNewContact(account);
            
            //Added Code by Sravan on 12/19/2015 - Start
            User u = new User(ProfileId = ApexPages.currentPage().getParameters().get('profile'));
            u.Username = ApexPages.currentPage().getParameters().get('uname');
            u.Email = newContact.Email;
            u.FirstName = newContact.FirstName;
            u.LastName = newContact.LastName;
            u.Contactid=newContact.Id;
            u.CommunityNickname = newContact.FirstName+''+newContact.LastName+''+newContact.CommunityAuto__c;
            u.Alias = (newContact.FirstName+''+newContact.LastName).substring(0,1);
            u.EmailEncodingKey = 'ISO-8859-1';
            u.LanguageLocaleKey = 'en_US';
            u.LocaleSidKey = 'en_US';
            u.TimeZoneSidKey = 'America/New_York';
            insert u;
            newContact.Grantee_With_Budget__c=true;
            update newContact;
            pr =new PageReference('/apex/CommunitiesSelfRegConfirm');
        }
        catch(NullPointerException nullPtrExc){
           System.debug('***'+nullPtrExc);
        }
        catch(DMLException dmlExc){
           System.debug('***'+dmlExc);
        }
        catch(Exception exc){
            System.debug('***'+exc);
        }
        return pr;
    }
}