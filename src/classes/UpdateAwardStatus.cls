global class UpdateAwardStatus implements Schedulable {
   global void execute(SchedulableContext ctx) {
      set<Id> awardIds = new set<Id>();
      list<Team_Assignment__c> tas = new list<Team_Assignment__c>([Select Id,Award__c,Project_Arrival_Date__c from Team_Assignment__c where Project_Arrival_Date__c = Today]);
      for(Team_Assignment__c ta: tas){
          awardIds.add(ta.Award__c);
      }
      if(awardIds.size()>0){
          list<Award__c> awards = new list<Award__c>([Select Id,Grant_Status__c from Award__c where Id in :awardIds]);
          if(awards.size()>0){
              for(Award__c a: awards){
                  a.Grant_Status__c = 'Awarded';
              }
              update awards;
          }
      }      
   }   
}