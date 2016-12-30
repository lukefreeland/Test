trigger RFPClassYear on RFP_Class_year__c (before insert, before update) {
	if(trigger.isbefore){
		if(trigger.isInsert){
			RFPClassYearHelper.preventClassYearforCampus(trigger.new); 
		}
	}

}