global class ContactWrapper
{
public Boolean isSelected {get;set;}
public Contact con{get;set;}        
    public ContactWrapper(Contact cont,Boolean isSelected)
    {
        this.con= cont;
        this.isSelected= isSelected;
    }
    
}