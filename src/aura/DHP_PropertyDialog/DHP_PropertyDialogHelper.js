({
	getNew : function (component) {
		console.log('########## getNew component: ', component);
		var sObjectType = 'Property__c';
		var propertyId = null;
		var loadFromCache = false;

		var callback = $A.getCallback(function() {
		console.log('########## getNew callback: ');
            var property = component.get('v.propertyRecord');
            var error = component.get('v.recordError');
            if (!property || error) {
                console.error('Error initializing record template: ' + error);
            }
        });
		         
		component.find('forceRecord')
			.getNewRecord(sObjectType, propertyId, loadFromCache, callback);
	},

	afterSave : function(component) {
		var self = this;
		return $A.getCallback(function(result) {
			var resultError = JSON.stringify(result.error);
			console.info(result.state);
			switch(result.state) {
				case 'SUCCESS': 
					self.toast({title: 'Saved', message: 'The record was saved.'}); 
					self.navigateTo(component, result.recordId);
					break;
				case 'ERROR':
					console.error('Error: ' + resultError);
					self.toast({title: 'Error', message: 'There was an error saving the record: ' + resultError}); 
					break;
				default:
					console.error('Unknown problem, state: ' + result.state + ', error: ' + resultError);
			}
	    });
	},
	
	navigateTo: function(component, propertyId) {
        var navigationEvent = $A.get('e.force:navigateToSObject');
        navigationEvent.setParams({
            recordId: propertyId
        });
        navigationEvent.fire();
    },
    
	setValue: function(component, sObjectPropertyName, attributeName, isNumber){
		var value = isNumber
			? parseInt(component.find(attributeName).get('v.value'), 10)
			: component.find(attributeName).get('v.value');
			
        component.set('v.propertyRecord.' + sObjectPropertyName, value);
	},
	 
	toast: function(params) {
		var resultsToast = $A.get('e.force:showToast');
		resultsToast.setParams(params);
		resultsToast.fire();
	}
})