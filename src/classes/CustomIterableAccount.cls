global class CustomIterableAccount implements Iterator<list<AccountWrapper>>{
    list<AccountWrapper> InnerList{get;set;}
    list<AccountWrapper> ListRequested{get;set;}
    
    Integer i{get;set;}
    public Integer setPageSize{get;set;}
    
    public CustomIterableAccount(List<AccountWrapper> lstAccWr){
    	InnerList = new list<AccountWrapper>();
    	ListRequested = new list<AccountWrapper>();
    	InnerList = lstAccWr;
    	setPageSize = 10;
    	i=0;
    }
    
    global boolean hasNext(){
    	if(i>=InnerList.size()){
    		return false;
    	} else {
    		return true;
    	}
    }
    
    global boolean hasPrevious(){
    	if(i<=setPageSize){
    		return false;
    	}else{
    		return true;
    	}
    }
    
       global list<AccountWrapper > next(){       
       ListRequested = new list<AccountWrapper>(); 
       integer startNumber;
       integer size = InnerList.size();
       if(hasNext())
       {  
           if(size <= (i + setPageSize))
           {
               startNumber = i;
               i = size;
           }
           else
           {
               i = (i + setPageSize);
               startNumber = (i - setPageSize);
           }
           
           for(integer start = startNumber; start < i; start++)
           {
               ListRequested.add(InnerList[start]);
           }
       } 
       return ListRequested;
   }
   
   global list<AccountWrapper> previous(){      
       ListRequested = new list<AccountWrapper >(); 
       integer size = InnerList.size(); 
       if(i == size)
       {
           if(math.mod(size, setPageSize) > 0)
           {    
               i = size - math.mod(size, setPageSize);
           }
           else
           {
               i = (size - setPageSize);
           } 
       }
       else
       {
           i = (i - setPageSize);
       } 
       for(integer start = (i - setPageSize); start < i; ++start)
       {
           ListRequested.add(InnerList[start]);
       } 
       return ListRequested;
   }   
}