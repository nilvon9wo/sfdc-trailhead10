({
	saveContact : function(component, event, helper) {
		component.find('recordLoader')
			.saveRecord(helper.afterSave(component));
	},
	
	handleRecordUpdated: function(component, event, helper) {
		helper.controlComponent(component, event.getParams());
		
	}
})