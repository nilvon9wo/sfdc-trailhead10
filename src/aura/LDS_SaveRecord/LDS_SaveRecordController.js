({
	handleSaveRecord : function(component, event, helper) {
		component.find('recordEditor')
			.saveRecord($A.getCallback(helper.onSaveRecord));
	}
})