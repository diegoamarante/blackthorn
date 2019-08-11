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
         EventAttendee__c.Name,
         EventAttendee__c.Event__c,
         EventAttendee__c.Attendee__c
        };
    }

    public List<Event__c> selectById(Set<Id> idSet){
        return (List<Event__c>) selectSObjectsById(idSet);
    }
   
    public List<EventAttendee__c> selectByEventAndAttendees(Set<Id> eventIds, Set<Id> attendeeIds) {
        String query = String.format(
            'select {0} from {1} ' +
            'where Event__c =: eventIds AND Attendee__c =: attendeeIds',
            new List<String> {
                getFieldListString(),
                getSObjectName(),
                getOrderBy()
            }
            );
        return (List<EventAttendee__c>) Database.query(query);
    }

    public List<EventAttendee__c> selectByEvent(Set<Id> eventIds) {
        String query = String.format(
            'select {0} from {1} ' +
            'where Event__c =: eventIds ',
            new List<String> {
                getFieldListString(),
                getSObjectName(),
                getOrderBy()
            }
            );
        return (List<EventAttendee__c>) Database.query(query);
    }
}