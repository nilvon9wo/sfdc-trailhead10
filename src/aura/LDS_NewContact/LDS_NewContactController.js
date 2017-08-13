({
	doInit : function(component, event, helper) {
		helper.prepareNewRecordFromTemplate(component);
	}, 
	
	handleSaveContact: function(component, event, helper) {
		if(helper.validateContactForm(component)) {
			component.find('contactRecordCreator')
				.saveRecord($A.getCallback(helper.onSaveRecord));
		}
	}
})