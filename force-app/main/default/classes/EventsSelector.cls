public with sharing class EventsSelector extends fflib_SObjectSelector {
 
    public Schema.SObjectType getSObjectType(){
        return Event__c.sObjectType;
    }
    public EventsSelector() {
        super(false);
    }
    
    public EventsSelector(Boolean includeFieldSetFields) {
        super(includeFieldSetFields);
    }
 
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField> {
            Event__c.Id,
            Event__c.Name,
            Event__c.Description__c,
            Event__c.StartDate__c,
            Event__c.EndDate__c,
            Event__c.Image__c
        };
    }
   
    public List<Event__c> selectById(Set<Id> idSet){
        return (List<Event__c>) selectSObjectsById(idSet);
    }
}