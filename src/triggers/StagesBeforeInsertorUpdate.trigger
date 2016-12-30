trigger StagesBeforeInsertorUpdate on Stages__c (before insert,before update) {
        
        /*Set<Id> NOFAGroups = New Set<Id>();
        Set<Id> NOFAIds = New Set<Id>();
        Map<string,string> statesmap = new Map<string,string>();
        Map<string,Decimal> statesequencemap = new Map<string,Decimal>();
        set<string> uniquesequencevalue = new set<string>();
        
        for(Stages__c stgitem :Trigger.new){
              NOFAGroups.add(stgitem.NOFA_Group__c);  
        }
        Map<string,string> NofaMemberandGroupMap = new Map<string,string>();
        
        for(NOFA_Member__c NMitem: [select id,NOFA_Group__c,NOFA__c from NOFA_Member__c where NOFA_Group__c in: NOFAGroups limit 49000 ] ){
                if(NMItem.NOFA__c != null) {
                    NOFAIds.add(NMItem.NOFA__c);
                }
                NofaMemberandGroupMap.put(NMitem.NOFA_Group__c,NMitem.NOFA__c);
        }
        for(Application3__c app: [select Organization__r.states__c,NOFA_RFP__c from Application3__c where NOFA_RFP__c in: NOFAIds limit 49999]){
            statesmap.put(app.NOFA_RFP__c,app.Organization__r.states__c);
        }
        for(Stages__c stgitem :[select Stage_Sequence_with_Nofo_Group__c  from stages__c where NOFA_Group__c in : NOFAGroups]){
                uniquesequencevalue.add(stgitem.Stage_Sequence_with_Nofo_Group__c);
        }
        if(Trigger.isinsert && Trigger.isBefore){
        
            for(Stages__c stgitem :Trigger.new){
                stgitem.Stage_Sequence__c = 1;
                if(NofaMemberandGroupMap.isempty()){
                    stgitem.addError('Please add NOFOs to the NOFO group to add stages.');
                }
                
                if(NofaMemberandGroupMap.get(stgitem.NOFA_Group__c) != null && statesmap.containskey(NofaMemberandGroupMap.get(stgitem.NOFA_Group__c)) ){
                     if(!statesequencemap.containskey(NofaMemberandGroupMap.get(stgitem.NOFA_Group__c)) ) {
                         if(stgitem.Stage_Sequence__c != null ){
                            stgitem.Stage_Sequence_with_Nofo_Group__c = stgitem.NOFA_Group__c +'-'+statesmap.get(NofaMemberandGroupMap.get(stgitem.NOFA_Group__c))+'-'+stgitem.Stage_Sequence__c;
                            
                         }
                     }
                     if(uniquesequencevalue.size()>0){
                        for(string s: uniquesequencevalue){
                            if(stgitem.Stage_Sequence_with_Nofo_Group__c == s) {
                                stgitem.Stage_Sequence__c = stgitem.Stage_Sequence__c+1;
                                stgitem.Stage_Sequence_with_Nofo_Group__c = stgitem.NOFA_Group__c +'-'+statesmap.get(NofaMemberandGroupMap.get(stgitem.NOFA_Group__c))+'-'+stgitem.Stage_Sequence__c;
                            }
                        }
                     }
                                        
                }
               }
                            
         }
         
         //Before Update  
         if(Trigger.isupdate && Trigger.isBefore){
            for(Stages__c stgitem :Trigger.new){
                if(NofaMemberandGroupMap.isempty()){
                     stgitem.addError('Please add NOFOs to the NOFO group to add stages.');
                }
             }
          }*/
          
          if(trigger.isBefore){
          	if(trigger.isInsert || trigger.isUpdate){
          		set<Id> nofaGrpIds = new set<Id>();
          		if(trigger.isUpdate){
          			for(Stages__c s: trigger.oldMap.values()){
	          			if(s.Campus__c != trigger.oldMap.get(s.Id).Campus__c && s.NOFA_Group__c!=null){
	          				nofaGrpIds.add(s.NOFA_Group__c);
	          			}
	          		}
          		}else{
	          		for(Stages__c s: trigger.new){
	          			if(s.NOFA_Group__c!=null){
	          				nofaGrpIds.add(s.NOFA_Group__c);
	          			}
	          		}
          		}
          		if(nofaGrpIds.size()>0){
	          		map<Id,NOFA_Group__c> nofaGrpMap = new map<Id,NOFA_Group__c>([Select Id,Name,(Select Id,Campus__c,Stage_Sequence__c from Stages__r order by Stage_Sequence__c DESC) from NOFA_Group__c where Id in :nofaGrpIds]);
	          		for(Stages__c s:trigger.new){
	          			system.debug(s.NOFA_Group__c);
	          			if(nofaGrpMap.get(s.NOFA_Group__c).Stages__r.size()>0){
	          				for(Stages__c existingStage: nofaGrpMap.get(s.NOFA_Group__c).Stages__r){
	          					if(existingStage.Campus__c == s.Campus__c){
	          						system.debug('got here if campus is same ');
	          						if(existingStage.Stage_Sequence__c != null){
	          							s.Stage_Sequence__c = existingStage.Stage_Sequence__c + 1;
	          							break;
	          						}else{
	          							s.Stage_Sequence__c = 1;
	          						}
	          					}else{
	          						s.Stage_Sequence__c = 1;
	          					}
	          				}
	          			}else{
	          				s.Stage_Sequence__c = 1;
	          			}
	          		}	
          		}
          			
          		
          	}
          }
}