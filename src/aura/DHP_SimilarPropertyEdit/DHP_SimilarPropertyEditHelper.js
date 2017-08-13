({
	afterSave : function() {
		return $A.getCallback(function(result) {
			console.info('@@@ result.state', result.state);
			switch(result.state) {
				case 'SUCCESS' : 
					$A.get('e.c:LX_RecordUpdated').fire(); 
					break;
				case 'DRAFT' : 
					$A.get('e.c:LX_RecordUpdated').fire(); 
					break;
				case 'ERROR': 
					console.error('Error: ' + JSON.stringify(result.error)); 
					break;
				default: 
					console.error('Unknown problem, '
							+ ' state: ' + result.state +
							+ ' error: ' + JSON.stringify(result.error)
						);
			}
		}); 
	},
	parseFor: function(component, attributeName) {
		return parseInt(component.find(attributeName).get('v.value'), 10);
	},
	setValue: function(component, sObjectPropertyName, attributeName){
        var value = parseInt(component.find(attributeName).get('v.value'), 10);
        component.set('v.selectedProperty.fields.' + sObjectPropertyName + '.value', value);	
	}, 
    showHideModal : function(component) {
        var modal = component.find('editDialog');
        $A.util.toggleClass(modal, 'slds-fade-in-open');
        
        var overlay = component.find('overlay');
        $A.util.toggleClass(overlay, 'slds-backdrop--open');
        
        component.set('v.showDialog', true);
    } 
})