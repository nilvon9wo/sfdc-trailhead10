({
	cancelDialog: function(component, event, helper) {
		var propertyId = component.get('v.recordId');
	    if (!propertyId) {
	        var goHome = $A.get('e.force:navigateToObjectHome');
	        goHome.setParams({
	            scope: 'Property__c'
	        });
	        goHome.fire();
	    } else {
	        helper.navigateTo(component, propertyId);
	    }
	},

	doInit : function(component, event, helper) {
		var propertyId = component.get('v.recordId');
		if (propertyId) {
			component.set('v.modalContext', 'Edit');
		}
		else {
			helper.getNew(component);
		}
	},

	saveRecord : function(component, event, helper) {
		var isNumber = true;
		helper.setValue(component, 'Name', 'propertyName');
		helper.setValue(component, 'Beds__c', 'propertyBeds', isNumber);
		helper.setValue(component, 'Baths__c', 'propertyBaths', isNumber);
		helper.setValue(component, 'Price__c', 'propertyPrice', isNumber);
		helper.setValue(component, 'Status__c', 'propertyStatus');

		component.find('forceRecord')
			.saveRecord(helper.afterSave(component	));
	}
})