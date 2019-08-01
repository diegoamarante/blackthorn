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
}
