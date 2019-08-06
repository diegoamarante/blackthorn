public with sharing class RegisterEventController {
    
    @AuraEnabled
    public static Event__c getEvent(String recordId){
        System.debug('asddsd '+recordId);
        if( recordId != null && recordId != '' ){
            Event__c event = [SELECT Id, Name, Description__c, StartDate__c, EndDate__c, Image__c FROM Event__c WHERE Id =: recordId];
            system.debug(event);
            return event;
        }
        return null;
    }

    @AuraEnabled
    public static String registerAttendee(String recordId, Attendee__c attendee){
        System.debug('Record '+recordId);
        System.debug('Attendee '+attendee);
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new List<Schema.SObjectType>{Attendee__c.SObjectType, EventAttendee__c.SObjectType});
        if( recordId != null && recordId != '' && attendee != null){
            //If the attendee does not exist
            List<Attendee__c> att = [SELECT Id FROM Attendee__c WHERE Email__c =: attendee.Email__c];
            if( att.isEmpty() ){
                uow.registerNew(attendee);
                uow.registerNew(new EventAttendee__c(Event__c = recordId), EventAttendee__c.Attendee__c, attendee);
            } else {
                //If the attendee already register to the event
                List<EventAttendee__c> eventAttendees = [SELECT Id FROM EventAttendee__c WHERE Attendee__c =: att.get(0).Id];
                if( eventAttendees.isEmpty() ){
                    uow.registerNew(new EventAttendee__c(Event__c = recordId), EventAttendee__c.Attendee__c, attendee);
                } else {
                    throw new AuraException('Already register to the Event');
                }
            }
            //uow.commitWork();
        }
        return 'Ok';
    }
}
