public with sharing class AttendeesSelector extends fflib_SObjectSelector {
 
    public Schema.SObjectType getSObjectType(){
        return Attendee__c.sObjectType;
    }
    public AttendeesSelector() {
        super(false);
    }
    
    public AttendeesSelector(Boolean includeFieldSetFields) {
        super(includeFieldSetFields);
    }
 
   public List<Schema.SObjectField> getSObjectFieldList(){
      return new List<Schema.SObjectField> {
         Attendee__c.Id,
         Attendee__c.Name,
         Attendee__c.Birthday__c,
         Attendee__c.Email__c
      };
   }

    public List<Attendee__c> selectById(Set<Id> idSet){
        return (List<Attendee__c>) selectSObjectsById(idSet);
    }
   
    public List<Attendee__c> selectByEmail(Set<String> emails) {
        String query = String.format(
            'select {0} from {1} ' +
            'where Email__c In: emails ',
            new List<String> {
                getFieldListString(),
                getSObjectName(),
                getOrderBy()
            }
            );
        return (List<Attendee__c>) Database.query(query);
    }
}