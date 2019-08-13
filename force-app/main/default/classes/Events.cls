public class Events extends fflib_SObjectDomain {

    public Events(List<Event__c> records){
        super(records);
    }

    public override void onApplyDefaults() {
    }

    public override void onValidate(){
    }

    public override void onValidate(Map<Id,SObject> existingRecords){
    }

    public override void onAfterInsert(){
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new List<Schema.SObjectType>{Event__c.SObjectType});
        FESettings__c settings = FESettings__c.getInstance();
        if( settings.SiteURL__c != null && settings.SiteURL__c != '' ){
            for(Event__c record : (List<Event__c>) Records){
                Event__c e = record.clone(true);
                e.URL__c = settings.SiteURL__c + '/RegisterEvent?id=' + String.valueOf(e.Id);
                system.debug(e);
                uow.registerDirty(e);
            }
            uow.commitWork();
        }
    }

    public override void onBeforeUpdate(Map<Id,SObject> existingRecords) {
        FESettings__c settings = FESettings__c.getInstance();
        if( settings.SiteURL__c != null && settings.SiteURL__c != '' ){
            for(Event__c record : (List<Event__c>) Records){
                if( String.isEmpty(record.URL__c) ){
                    record.URL__c = settings.SiteURL__c + '/RegisterEvent?id=' + String.valueOf(record.Id);
                    system.debug(record);
                }
            }
        }
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable2{

        public fflib_SObjectDomain construct(List<SObject> sObjectList){
            return new Events(sObjectList);
        }

        public fflib_SObjectDomain construct(List<SObject> sObjectList, SObjectType sObjectType){
            return new Events(sObjectList);
        }
    }
}