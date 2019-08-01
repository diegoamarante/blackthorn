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
        for(Event__c record : (List<Event__c>) Records){
            
        }

        // Site mySite = [SELECT Id FROM Site ];
        // String mySiteUrl = mySite.getPublicUrl();
        // System.debug(mySiteUrl);
        // system.debug(Site.getBaseUrl());


        // Site site = [SELECT GuestUserId, Name, Subdomain, UrlPathPrefix FROM Site WHERE Name = :'BTTest'];

        // Organization org = [SELECT InstanceName, IsSandbox, OrganizationType FROM Organization];

        // String siteFullUrl = 'https://' + site.Subdomain + '.';
        // siteFullUrl += (org.IsSandbox || org.OrganizationType == 'Developer Edition' ? (org.InstanceName.toLowerCase() + '.') : '') + 'force.com';
        // siteFullUrl += '/' + site.UrlPathPrefix;
        // system.debug(siteFullUrl);

    }

    public override void onAfterUpdate(Map<Id,SObject> existingRecords) {
        for(Event__c record : (List<Event__c>) Records){
            
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