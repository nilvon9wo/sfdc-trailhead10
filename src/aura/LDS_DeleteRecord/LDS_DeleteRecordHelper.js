({
	onDeleteRecord: function(saveResult) {
		switch (saveResult.state) {
			case 'SUCCESS': 
				console.info('Record is deleted.'); 
				break;
			case 'DRAFT': 
				console.info('Draft deleted successfully.'); 
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
	}
})