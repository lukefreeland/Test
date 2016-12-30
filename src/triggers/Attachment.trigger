trigger Attachment on Attachment (before insert) {
	
	if(trigger.isBefore){
		if(trigger.isInsert){
			AttachmentHelper.makeApplicationFeedbackAttachmentsPublic(trigger.new); 
		}
	}

}