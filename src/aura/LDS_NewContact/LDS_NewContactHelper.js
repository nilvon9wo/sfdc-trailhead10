({
	prepareNewRecordFromTemplate : function(component) {
		var sObjectType = 'Contact';
		var recordTypeId = null;
		var skipCache = false;
		var callback = $A.getCallback(function(){
				var newContact = component.get('v.newContact');
				var error = component.get('v.newContactError');
				if (!record || error) {
					console.error('Error initializing record template: ' + error);
				}
				else {
					console.info('Record template initialized: ' + newContact.sobjectTtpe);
				}
			}); 
					
		component.find('contactRecordCreator')
			.getNewRecord(sObjectTpe, recordTypeId, skipCache, callback);
	},
	
	onSaveRecord: function(saveResult) {
		switch (saveResult.state) {
			case 'SUCCESS': 
				this.toast('Save completed successfully.'); 
				break;
			case 'DRAFT': 
				this.toast('Draft saved successfully.'); 
				break; 
			case 'INCOMPLETE': 
				console.warn('User is offline, device does not support drafts.'); 
				break; 
			case 'ERROR': 
				console.error('Problem saving record, error: ' + JSON.stringify(saveResult.error)); 
				break;
			default: 
				console.error(
						'Unknown problem,' 
						+ ' state: ' + saveResult.state + ','  
						+ ' error: ' + JSON.stringify(saveResult.error)
					);
		}
	},
	
	toast: function(message) {
		var resultsToast = $A.get('e.force:showToast');
		resultsToast.setParams({
			title: 'Saved',
			message: message
		});
	}	
})