({
	doWithProperty : function(component, functioName) {
		var event = $A.get('e.force:' + functioName);
		event.setParams({
			recordId: component.get('v.propertyId')
		});
		event.fire(); 		
	}
})