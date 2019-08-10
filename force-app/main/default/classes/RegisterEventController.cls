public with sharing class RegisterEventController {
    
    @AuraEnabled
    public static Event__c getEvent(String recordId){
        System.debug('asddsd '+recordId);
        if( recordId != null && recordId != '' ){
            List<Event__c> events = new EventsSelector().selectById(new Set<Id>{recordId});
            //Event__c event = [SELECT Id, Name, Description__c, StartDate__c, EndDate__c, Image__c FROM Event__c WHERE Id =: recordId];
            system.debug(events);
            if( !events.isEmpty() ){
                return events.get(0);
            }
        }
        return null;
    }

    @AuraEnabled
    public static String registerAttendee(String eventId, Attendee__c attendee){
        System.debug('Record '+eventId);
        System.debug('Attendee '+attendee);
        if( attendee.Email__c == null || attendee.Email__c == '' ){
            throw new AuraHandledException('Must enter an email');
        }
        try {
            List<Attendee__c> attendees = new AttendeesSelector().selectbyEmail(new Set<String>{attendee.Email__c});
            if( attendees.isEmpty() ){
                insert attendee;
            }
            attendees.add(attendee);
            List<Event__c> events = new EventsSelector().selectById(new Set<Id>{eventId});
            EventsService.registerAttendees(events, attendees);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

        return 'Ok';
    }
}
