({
	afterSave : function(component) {
		return $A.getCallback(function(saveResult) {
			var errorMessage = '';
			if (saveResult.state === 'ERROR') {
				for (var i = 0;  i < saveResult.error.length; i++) {
					errorMessage += saveResult.error[i].message + '\n';
				}
			}
			component.set('v.recordSaveError', errorMessage);
		}		
	},
	
	controlComponent: function(component, eventParams) {
		switch (eventParams) {
			case 'CHANGED': this.onChange(eventParams.changedFields); break;
			case 'LOADED': console.warn('Record is loaded in the cache'); break;
			case 'DELETED': console.warn('Record is deleted and removed from the cache'); break;
			case 'ERROR': console.error('Error: ' + component.get('v.recordSaveError')); break;
		}
	},
	
	onChange: function (changedFields) {
		console.info('Fields that are changed: ' + JSON.stringify(changedFields));
		
		var resultsToast = $A.get('e.force:showToast');
		resultsToast.setParams({
			title: 'Saved',
			message: 'The record was updated'
		});
		resultsToast.fire();
	}
})