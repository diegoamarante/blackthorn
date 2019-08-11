trigger Events on Event__c (before insert, before update, after insert, after update) {
    fflib_SObjectDomain.triggerHandler(Events.class);
}