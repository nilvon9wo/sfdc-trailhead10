({
	getSimilarProperties : function(component, spinner) {
		var action = component.get('c.getSimilarProperties');
		var property = component.get('v.property.fields');
		if (property) {
			action.setParams({
				numberOfBeds: property['Beds__c'].value,
				price: property['Price__c'].value,
				priceRange: parseInt(component.get("v.priceRange"), 10),
				propertyId: component.get('v.recordId'),
				searchCriteria: component.get("v.searchCriteria")
			});
			action.setCallback(this, function(response){
				var similarProperties = response.getReturnValue();
				component.set('v.similarProperties', similarProperties);
				$A.util.addClass(spinner, 'slds-hide');
			});
			$A.enqueueAction(action);
		}
	},
	showSpinner: function(component) {
    	var spinner = component.find('spinner');
    	$A.util.removeClass(spinner, 'slds-hide');
    	return spinner;
	}
})