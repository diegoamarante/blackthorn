public with sharing class RecordListController {
    
    @AuraEnabled
    public static List<Attendee__c> getRecords(Id recordId){
        //Usar EventAttendeeSelector
        return Database.query('Select Id, Name, Birthday__c From Attendee__c ');
    }

    @AuraEnabled
    public static string deleteRecord(Id recordId){
        try {
            //Usar EventAttendeeSelector
            delete [SELECT Id FROM EventAttendee__c Where Id =: recordId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return 'Ok';
    }
}
