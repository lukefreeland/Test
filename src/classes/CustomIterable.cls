global class  CustomIterable implements Iterator<list<ContactWrapper>>
{ 
   list<ContactWrapper> InnerList{get; set;}
   list<ContactWrapper> ListRequested{get; set;}

   Integer i {get; set;} 
   public Integer setPageSize {get; set;} 

   public CustomIterable(List<ContactWrapper> lstAccWr)
   {
       InnerList = new list<ContactWrapper >(); 
       ListRequested = new list<ContactWrapper >();     
       InnerList = lstAccWr;
       setPageSize = 100;
       i = 0; 
   }   

   global boolean hasNext(){ 
       if(i >= InnerList.size()) {
           return false; 
       } else {
           return true; 
       }
   } 
   
   global boolean hasPrevious(){ 
       system.debug('I am in hasPrevious' + i);
       if(i <= setPageSize) {
           return false; 
       } else {
           return true; 
       }
   }   

   global list<ContactWrapper > next(){       
       system.debug('i value is ' + i);
       ListRequested = new list<ContactWrapper >(); 
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
           
           system.debug('i value is =====' + i);
           system.debug('i value is 2==== ' + (i - setPageSize));
           
           for(integer start = startNumber; start < i; start++)
           {
               ListRequested.add(InnerList[start]);
           }
       } 
       return ListRequested;
   } 
   
   global list<ContactWrapper > previous(){      
       ListRequested = new list<ContactWrapper >(); 
       system.debug('i value is previous before =====' + i);
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
       
       system.debug('i value is previous =====' + i);
       system.debug('i value is 2previous ==== ' + (i - setPageSize));
       
       for(integer start = (i - setPageSize); start < i; ++start)
       {
           ListRequested.add(InnerList[start]);
       } 
       return ListRequested;
   }
   
   global list<ContactWrapper> firstSet(){
   	   ListRequested = new list<ContactWrapper >(); 
       integer startNumber = 0;
       integer size = InnerList.size();
       if(size>100){
	       for(integer start = startNumber; start < 100; start++)
	       {
	           ListRequested.add(InnerList[start]);
	       }
       }else{
       	   for(integer start = startNumber; start < size; start++)
	       {
	           ListRequested.add(InnerList[start]);
	       }
       }
       return ListRequested;
   } 
   
   global list<ContactWrapper> lastSet(){
   	   ListRequested = new list<ContactWrapper>(); 
       integer startNumber = 0;
       integer size = InnerList.size();        
       if(size>100){
       	  integer page = (integer)size/100;
       	  startNumber = size - (page * 100);
       }
             
       for(integer start = startNumber; start < size; start++)
	   {
	      ListRequested.add(InnerList[start]);
	   }
       return ListRequested;
   } 
       
   
}