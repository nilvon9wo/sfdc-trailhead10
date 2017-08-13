({
	editRecord: function(component) {
		var recordId = component.get('v.propertyId');
		component.set('v.remoteRecordId', recordId);
		component.set('v.showDialog', 'true');
	},
	navigateToRecord : function(component, event, helper) {
		helper.doWithProperty(component, 'navigateToSObject');
	}
})