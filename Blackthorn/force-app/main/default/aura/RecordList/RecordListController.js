({
    init: function (component, event, helper) {
        var recordId = component.get('v.recordId');
        
        var actions = [
            { label: 'Show details', name: 'show_details' },
            { label: 'Delete', name: 'delete' }
            ],
        fetchData = {
            name : 'company.companyName',
            author: 'name.findName',
            published : 'address.state'
        };

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
                alert('Showing Details: ' + JSON.stringify(row));
                break;
            case 'delete':
                helper.removeBook(cmp, row);
                break;
        }
    }
})
