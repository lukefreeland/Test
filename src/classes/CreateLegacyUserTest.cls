@isTest
Public Class CreateLegacyUserTest
{
    static testmethod void CreateLegacyUserTest(){
        Profile p = [SELECT Id FROM Profile WHERE Name='Grantee Admin'];
        Profile p1 = [SELECT Id FROM Profile WHERE Name='Applicant'];
        Profile p2 = [SELECT Id FROM Profile WHERE Name='Expert Reviewers'];
        
        Account a = new Account();
        a = UtilityClass.createOrganization();
        insert a ;
        Contact c = new Contact();
        //if(c.Dataloader_input__c==true){
        c.FirstName = 'Test FirstName';
        c.Dataloader_input__c = true;
        c.LastName = 'Test LastName';
        c.Primary_Phone__c = '230-908-1098';
        //c.CommunityAuto__c = 'Test';
        c.Email = 'test@email.com';
        c.Mailing_Street_Address_1__c = '2400 S Glebe Rd';
        c.Mailing_State__c ='VA';
        c.Mailing_City__c = 'Arlington';
        c.Mailing_Zip_Code__c = '22206';
        c.Accountid = a.id;
        //}
        insert c;
        
        User u = new User();
                if(c.Dataloader_input__c == true){
                     if(c.RecordTypeId == '012r00000004KUn'){
                            u.ProfileId = p.Id;
                            u.UserName = c.Email+'.grantee';
                        }
                    if(c.RecordTypeId == '012r00000004KUm'){
                            u.ProfileId = p1.Id;
                            u.UserName = c.Email+'.grantee';
                        }
                    if(c.RecordTypeId == '012r00000004KUl'){
                            u.ProfileId = p2.Id;
                            u.UserName = c.Email+'.externalreviewer';
                        }
                            u.FirstName=c.FirstName;
                            u.LastName=c.LastName;
                            u.UserName=c.Email;
                            u.ProfileId = p.Id;
                            //u.UserRole= c.LastName+ 'Customer user';
                            u.Alias = (c.FirstName+''+c.LastName).substring(0,1);
                            u.Email=c.Email;
                            u.ContactId=c.Id;
                            u.CommunityNickname = c.FirstName+''+c.LastName+''+c.CommunityAuto__c;
                            u.EmailEncodingKey = 'ISO-8859-1';
                            u.LanguageLocaleKey = 'en_US';
                            u.LocaleSidKey = 'en_US';
                            u.TimeZoneSidKey = 'America/New_York';
                }
                //insert u;
                
                /*System.runAs(u){
       
        }*/
    }
}