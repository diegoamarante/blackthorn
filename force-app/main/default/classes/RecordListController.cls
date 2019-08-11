public with sharing class RecordListController {
    
    @AuraEnabled
    public static List<Attendee__c> getRecords(Id recordId){
        Set<Id> attendeeIds = new Set<Id>();
        for(EventAttendee__c ea : new EventAttendeeSelector().selectByEvent(new Set<Id>{recordId})){
            attendeeIds.add(ea.Attendee__c);
        }
        return new AttendeesSelector().selectById(attendeeIds);
    }

    @AuraEnabled
    public static string deleteRecord(Id recordId){
        try {
            delete new EventAttendeeSelector().selectByID(new Set<Id>{recordId});
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'Ok';
    }
}
