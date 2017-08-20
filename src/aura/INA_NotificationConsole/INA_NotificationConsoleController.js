({
  onClear : function(component, event, helper) {
    component.set('v.notifications', []);
  },

  onCometdLoaded : function(component, event, helper) {
		component.set('v.cometd', new org.cometd.CometD());
		if (component.get('v.sessionId')) {
			helper.connectCometd(component);
		} 
  },

  onInit : function(component, event, helper) {
	  component.set('v.cometdSubscriptions', []);
	  component.set('v.notifications', []);
	  helper.disconnectCometDWhenLeavingPage(component);
	  helper.retrieveSessionId(component);	
	  helper.displayToast(component, 'success', 'Ready to receive notifications.');
  },

  onToggleMute : function(component, event, helper) {
    var isMuted = component.get('v.isMuted');
    component.set('v.isMuted', !isMuted);
    helper.displayToast(
    		component, 
    		'success', 
    		'Notifications '+ ((!isMuted) ? 'muted' : 'unmuted') +'.'
  	);
  }
})