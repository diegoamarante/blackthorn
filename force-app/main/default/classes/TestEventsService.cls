@IsTest
public with sharing class TestEventsService {
    
    @IsTest
    static void registerEvents(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        Attendee__c attendee = new Attendee__c(Name = 'test', Email__c = 'test@test.com');
        insert attendee;

        Test.startTest();
            EventsService.registerAttendees(new List<Event__c>{event}, new List<Attendee__c>{attendee});
        Test.stopTest();
        
        System.assertEquals(1, [Select Id from EventAttendee__c Where Attendee__r.Email__c =: attendee.Email__c].size());
    }

    @IsTest
    static void registerEvents_1(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        List<Attendee__c> attendees = new List<Attendee__c>();
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test@test.com') );
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test1@test1.com') );
        insert attendees;
        
        Test.startTest();
            EventsService.registerAttendees(new List<Event__c>{event}, attendees);
        Test.stopTest();
        
        System.assertEquals(2, [Select Id from EventAttendee__c ].size());
    }

    @IsTest
    static void registerEvents_2(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        List<Attendee__c> attendees = new List<Attendee__c>();
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test@test.com') );
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test1@test1.com') );
        insert attendees;

        insert new EventAttendee__c(Event__c = event.Id, Attendee__c = attendees.get(0).Id);
        
        Test.startTest();
            EventsService.registerAttendees(new List<Event__c>{event}, attendees);
        Test.stopTest();
        
        System.assertEquals(2, [Select Id from EventAttendee__c ].size());
    }

    @IsTest
    static void registerEvents_3(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        List<Attendee__c> attendees = new List<Attendee__c>();
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test@test.com') );
        attendees.add( new Attendee__c(Name = 'test', Email__c = 'test1@test1.com') );
        insert attendees;

        insert new EventAttendee__c(Event__c = event.Id, Attendee__c = attendees.get(0).Id);
        
        Test.startTest();
            EventsService.registerAttendees(new List<Event__c>{event}, attendees);
        Test.stopTest();
        
        System.assertEquals(2, [Select Id from EventAttendee__c ].size());
    }

    @IsTest
    static void registerEventsControllerTest1(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        Attendee__c attendee = new Attendee__c(Name = 'test', Email__c = 'test@test.com');
        
        Test.startTest();
            RegisterEventController.registerAttendee(event.Id, attendee);
        Test.stopTest();
        
        System.assertEquals(1, [Select Id from EventAttendee__c ].size());
    }

    @IsTest
    static void registerEventsControllerTest2(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        
        Test.startTest();
            Event__c record = RegisterEventController.getEvent(event.Id);
        Test.stopTest();
        
        System.assertEquals(event.Id, record.Id);
    }

    @IsTest
    static void eventSetURL(){
        FESettings__c settings = FESettings__c.getInstance();
        settings.SiteURL__c = 'test.com';
        insert settings;
        
        Test.startTest();
            Event__c event = new Event__c(Name = 'Test');
            insert event;
        Test.stopTest();
        
        String url = 'test.com/RegisterEvent?id='+String.valueOf(event.Id);
        System.assertEquals(url, [Select Id, Url__c FROM Event__c WHERE ID =: event.Id limit 1].URL__c);
    }

    @IsTest
    static void testRecordListGet(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        Attendee__c attendee = new Attendee__c(Name = 'test', Email__c = 'test@test.com');
        insert attendee;
        EventAttendee__c eventAttendee = new EventAttendee__c(Event__c = event.Id, Attendee__c = attendee.Id);
        insert eventAttendee;
        
        Test.startTest();
            List<Attendee__c> attendees = RecordListController.getRecords(event.Id);
        Test.stopTest();
        
        System.assertEquals(1, attendees.size());
    }

    @IsTest
    static void testRecordListDelete(){
        Event__c event = new Event__c(Name = 'Test');
        insert event;
        Attendee__c attendee = new Attendee__c(Name = 'test', Email__c = 'test@test.com');
        insert attendee;
        EventAttendee__c eventAttendee = new EventAttendee__c(Event__c = event.Id, Attendee__c = attendee.Id);
        insert eventAttendee;
        
        Test.startTest();
            RecordListController.deleteRecord(eventAttendee.Id);
        Test.stopTest();
        
        System.assertEquals(0, [Select Id from EventAttendee__c].size());
    }
}
