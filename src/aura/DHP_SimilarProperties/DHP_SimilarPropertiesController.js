({
	doInit : function(component, event, helper) {
		var spinner = helper.showSpinner(component);
		helper.getSimilarProperties(component, spinner);
	}
})