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
}
