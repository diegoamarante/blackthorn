public with sharing class EventsService {
    
    /*
        Service to register Attendees to the Events
    */
    public static Map<Id, Set<Id>> registerAttendees(List<Event__c> events, List<Attendee__c> attendees){
        System.debug('Record '+events);
        System.debug('Attendee '+attendees);
        Map<Id, Set<Id>> resultsMap = new Map<Id, Set<Id>>();
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new List<Schema.SObjectType>{Attendee__c.SObjectType, EventAttendee__c.SObjectType});
        if( !events.isEmpty() && !attendees.isEmpty() ){
            //List<EventAttendee__c> eventAttendees = [SELECT Id, Event__c, Attendee__c FROM EventAttendee__c WHERE Event__c In: events AND Attendee__c In: attendees];
            Set<Id> eventIds = new Set<Id>();
            Set<Id> attendeeIds = new Set<Id>();
            for(Event__c e : events){
                eventIds.add(e.Id);
            }
            for(Attendee__c a : attendees){
                attendeeIds.add(a.Id);
            }
            List<EventAttendee__c> eventAttendees = new EventAttendeeSelector().selectByEventAndAttendees(eventIds, attendeeIds);
            Map<Id, Set<Id>> eventAttendeesMap = new Map<Id, Set<Id>>();
            for(EventAttendee__c ea : eventAttendees){
                if( !eventAttendeesMap.containsKey(ea.Event__c) ){
                    eventAttendeesMap.put(ea.Event__c, new Set<Id>{ea.Attendee__c});
                } else {
                    eventAttendeesMap.get(ea.Event__c).add(ea.Attendee__c);
                }
            }

            for(Event__c e : events){
                for(Attendee__c a : attendees){
                    if( !eventAttendeesMap.containsKey(e.Id) || !eventAttendeesMap.get(e.Id).contains(a.Id) ){
                        uow.registerNew(new EventAttendee__c(Event__c = e.Id, Attendee__c = a.Id));
                        if( !resultsMap.containsKey(e.Id) ){
                            resultsMap.put(e.Id, new Set<Id>{a.Id});
                        } else {
                            resultsMap.get(e.Id).add(a.Id);
                        }
                    } 
                }
            }
            system.debug(uow);
            uow.commitWork();            
        }
        return resultsMap;
    } 
}
