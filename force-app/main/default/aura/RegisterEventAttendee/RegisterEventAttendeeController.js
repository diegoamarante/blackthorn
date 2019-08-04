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

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events, 
        // which could trigger other events and 
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);    
    },
    showTicket : function(component, event, helper) {
        component.set('v.showTicket', !component.get('v.showTicket'));
        component.set('v.v.attendeeName', 'Nombre');
    }

})
