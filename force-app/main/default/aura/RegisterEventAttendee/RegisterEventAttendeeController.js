({
    doInit : function(component, event, helper) {
        // in the server-side controller
        var action = component.get('c.getEvent');
        action.setParams({ 
            recordId : component.get('v.eventId')
        });

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                if( response.getReturnValue() ){
                    component.set('v.name',response.getReturnValue().Name);
                    component.set('v.description',response.getReturnValue().BTTrial__Description__c);
                    component.set('v.startDate',response.getReturnValue().BTTrial__StartDate__c);
                    component.set('v.endDate',response.getReturnValue().BTTrial__EndDate__c);
                    component.set('v.image',response.getReturnValue().BTTrial__Image__c);
                }
                console.log(response.getReturnValue())

            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);    
    },
    showTicket : function(component, event, helper) {
        component.set('v.showTicket', true);
        component.set('v.showResult', true);
        component.set('v.showButtonTicket', true);
    },
    clickCreate : function(component, event, helper) {
        component.set('v.showSpinner', true);
        component.set('v.showTicket', false);

        var attendee = {};
        attendee.Name = component.get('v.attendeeName');
        attendee.BTTrial__Birthday__c = component.get('v.attendeeBirthday');
        attendee.BTTrial__Email__c = component.get('v.attendeeEmail');
        console.log(attendee);

        var registerAttendee = component.get('c.registerAttendee');
        registerAttendee.setParams({ 
            eventId : component.get('v.eventId'),
            attendee : attendee
        });

        registerAttendee.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.showSpinner', false);
                component.set('v.showButtonTicket', false);
                component.set('v.showResult', false);
                component.set('v.showTicket', true);

                component.set('v.errorMsg', 'Registration correct');
                component.set('v.attendeeName', '');
                component.set('v.attendeeBirthday', '');
                component.set('v.attendeeEmail', '');

            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        component.set('v.errorMsg', errors[0].message);
                        component.set('v.showResult', false);
                        component.set('v.showSpinner', false);
                        component.set('v.showTicket', true);
                        component.set('v.showButtonTicket', true);
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(registerAttendee);  
    }
})
