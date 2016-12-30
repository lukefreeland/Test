@isTest
private class CustomLoginControllerTest {

    static testMethod void granteeLoginPageTest(){
    	
    	Account acc = UtilityClass.createOrganization();
    	insert acc;
    	
    	Contact con = UtilityClass.createContact();
    	con.AccountId = acc.Id;
    	con.Email = 'test@test.com';
    	insert con;
    	
    	User u = UtilityClass.createUser('Grantee Admin');
    	//u.AccountId = acc.Id;
    	u.ContactId = con.Id;
    	u.Username = 'test@test.com';    	
    	   	
        Pagereference pref = Page.Login_Page;
        test.setCurrentPage(pref);
        
        CustomLoginController controller = new CustomLoginController();
        controller.username = 'test@test.com';
        controller.password = 'Washington#1';
        controller.login();
        controller.joincommunity();
        controller.createOrg();
        controller.forgotPwd();                       
        
    }
    
    static testMethod void erLoginPageTest(){
    	Account acc = UtilityClass.createOrganization();
    	insert acc;
    	
    	Contact con = UtilityClass.createContact();
    	con.AccountId = acc.Id;
    	con.Email = 'test@test.com';
    	insert con;
    	
    	User u = UtilityClass.createUser('Expert Reviewers');
    	//u.AccountId = acc.Id;
    	u.ContactId = con.Id;
    	u.Username = 'test@test.com';    	
    	   	
        Pagereference pref = Page.Login_Page;
        test.setCurrentPage(pref);
        
        CustomLoginController1 controller = new CustomLoginController1();
        controller.username = 'test@test.com';
        controller.password = 'Washington#1';
		controller.login();
		controller.createOrg();
		controller.forgotPwd();
		controller.forwardToCustomAuthPage();
		              
    	
    }
}