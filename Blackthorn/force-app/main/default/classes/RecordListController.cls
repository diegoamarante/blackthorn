public with sharing class RecordListController {
    
    @AuraEnabled
    public static List<Attendee__c> getRecords(Id recordId){
        return Database.query('Select Id, Name, Birthday__c From Attendee__c ');
    }
}
