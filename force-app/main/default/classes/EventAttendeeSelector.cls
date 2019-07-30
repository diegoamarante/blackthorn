public class EventAttendeeSelector extends fflib_SObjectSelector {
 
    public Schema.SObjectType getSObjectType(){
        return EventAttendee__c.sObjectType;
    }
    public EventAttendeeSelector() {
        super(false);
    }
    
    public EventAttendeeSelector(Boolean includeFieldSetFields) {
        super(includeFieldSetFields);
    }
 
   public List<Schema.SObjectField> getSObjectFieldList(){
      return new List<Schema.SObjectField> {
         EventAttendee__c.Id,
         EventAttendee__c.Name
      };
   }
   
    public List<EventAttendee__c> selectByEvente(Set<Id> recordIds) {
        String query = String.format(
            'select {0} from {1} ' +
            'where Event__c =: recordIds ' +
            'order by {2} limit {3}',
            new List<String> {
                getFieldListString(),
                getSObjectName(),
                getOrderBy()
            }
            );
        return (List<EventAttendee__c>) Database.query(query);
    }
}