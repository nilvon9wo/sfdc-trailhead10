({
	getRecord : function(component) {
        var record = component.find('editRecord');
        record.set('v.recordId', component.get('v.remoteRecordId'));
        record.reloadRecord();
	},
    saveRecord : function(component,event,helper) {
		helper.setValue(component, 'Beds__c', 'propertyBeds');
		helper.setValue(component, 'Baths__c', 'propertyBaths');
		helper.setValue(component, 'Price__c', 'propertyPrice');

        component.find('editRecord')
        	.saveRecord(helper.afterSave);       
        helper.showHideModal(component);
    },
	toggleDialog: function(component, event, helper) {
        helper.showHideModal(component);
	}
})