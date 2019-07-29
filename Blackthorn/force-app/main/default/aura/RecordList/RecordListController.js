({
    init: function (component, event, helper) {
        var recordId = component.get('v.recordId');
        
        var actions = [
            { label: 'Show details', name: 'show_details' },
            { label: 'Delete', name: 'delete' }
        ];

        var getRecords = component.get("c.getRecords");

        // set if we need related lists
        getRecords.setParams({
            recordId: recordId
        });

        getRecords.setCallback(this, function (response) {
            if (response.getState() === "SUCCESS") {
                component.set('v.data', response.getReturnValue());
            } else {
                console.warn(response.getError());
            }
        });
        $A.enqueueAction(getRecords);


        component.set('v.columns', [
            { label: 'Name', fieldName: 'Name', type: 'text' },
            { label: 'Birthday', fieldName: 'BTTrial__Birthday__c', type: 'date' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ]);

    },

    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');

        switch (action.name) {
            case 'show_details':
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": row.Id
                });
                navEvt.fire();
                break;
            case 'delete':
                var rows = component.get('v.data');
                var rowIndex = rows.indexOf(row);
                var deleteRecord = component.get("c.deleteRecord");

                // set if we need related lists
                deleteRecord.setParams({
                    recordId: row.Id
                });

                deleteRecord.setCallback(this, function (response) {
                    if (response.getState() === "SUCCESS") {
                        rows.splice(rowIndex, 1);
                        component.set('v.data', rows);
                    } else {
                        console.warn(response.getError());
                    }
                });
                $A.enqueueAction(deleteRecord);


                
                break;
        }
    }
})
