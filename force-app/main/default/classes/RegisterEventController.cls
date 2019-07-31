public with sharing class RegisterEventController {
    public Event__c event {get;set;}

    public RegisterEventController() {
        String eventId = Apexpages.currentpage().getparameters().get('eventId');
        if( eventId != null && eventId != '' ){
            event = [SELECT Id, Name, StartDate__c, EndDate__c, Image__c FROM Event__c WHERE Id =: eventId];
            
        }
    }
}
