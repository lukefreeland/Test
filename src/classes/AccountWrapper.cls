global class AccountWrapper {
    public Boolean isSelected {get;set;}
    public Account acct{get;set;}
    
    public AccountWrapper(Account acct,Boolean isSelected)
    {
    	this.acct=acct;
    	this.isSelected=isSelected;
    }
}