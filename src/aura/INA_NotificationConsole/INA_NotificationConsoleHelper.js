({
  connectCometd : function(component) {
    var cometdUrl = window.location.protocol+'//'+window.location.hostname+'/cometd/40.0/';
    var cometd = this.configureCometDWebsocket(component, cometdUrl);
    cometd.handshake(this.onCometDConnection(component, cometd));
  },
  configureCometDWebsocket: function(component, cometdUrl){
	var cometd = component.get('v.cometd');
	cometd.configure({
	  url: cometdUrl,
	  requestHeaders: { Authorization: 'OAuth '+ component.get('v.sessionId')},
	  appendMessageTypeToURL : false
	});
	cometd.websocketEnabled = false;
	return cometd;
  },
  onCometDConnection: function(component, cometd) {
	  var self = this;
	  return $A.getCallback(function(handshakeReply){
	      if (handshakeReply.successful) {
	        var newSubscription = self.subscribeToPlatformEvent(component, cometd);
	        self.saveSubscriptionForLater(component, newSubscription);
	      }
	      else {
	    	  console.error('Failed to connected to CometD.');
	      }
	  });
  },
  subscribeToPlatformEvent: function(component, cometd) {
	var self = this;
	var onCallback = function(platformEvent) {
        self.onReceiveNotification(component, platformEvent);
      }; 
    return cometd.subscribe('/event/Notification__e', onCallback);
  }, 
  saveSubscriptionForLater: function(component, newSubscription) {
	  var subscriptions = component.get('v.cometdSubscriptions');
	  subscriptions.push(newSubscription);
	  component.set('v.cometdSubscriptions', subscriptions);
  },      

  // --------------------------------------------------------------

  disconnectCometDWhenLeavingPage: function(component) {
	var self = this;
	window.addEventListener('unload', function(event) {
	    self.disconnectCometd(component);
	});
  },

  disconnectCometd : function(component) {
    var cometd = component.get('v.cometd');
    this.unsubscribeAllCometDSubscriptions(component, cometd);
    cometd.disconnect();
  },
  unsubscribeAllCometDSubscriptions: function(component, cometd) {
    cometd.batch(function() {
      var subscriptions = component.get('v.cometdSubscriptions');
      subscriptions.forEach(function (subscription) {
        cometd.unsubscribe(subscription);
      });
    });
    component.set('v.cometdSubscriptions', []);
  },  

  // --------------------------------------------------------------

  onReceiveNotification : function(component, platformEvent) {
    var newNotification = this.extractNotificationFromPlatformEvent(platformEvent);
    this.saveNotificationInHistory(component, newNotification);
    if (!component.get('v.isMuted')) {
    	this.displayToast(component, 'info', newNotification.message);
    }
  },
  extractNotificationFromPlatformEvent: function(platformEvent) {
    return {
      time : $A.localizationService.formatDateTime(platformEvent.data.payload.CreatedDate, 'HH:mm'),
      message : platformEvent.data.payload.Message__c
    };
  },
  saveNotificationInHistory: function(component, newNotification) {
	var notifications = component.get('v.notifications');
	notifications.push(newNotification);
	component.set('v.notifications', notifications);
  },
  // ----------------------------------------------------------

  displayToast : function(component, type, message) {
    var toastEvent = $A.get('e.force:showToast');
    toastEvent.setParams({
      type: type,
      message: message
    });
    toastEvent.fire();
  },
  
  // ----------------------------------------------------------

	retrieveSessionId: function(component) {
		var params = {};

		var self = this;
		var onResponse = function(component, returnValue) {
		    if (component.isValid()) {
		    	component.set('v.sessionId', returnValue);
		    	if (component.get('v.cometd')) {
		    		self.connectCometd(component);
		    	}
		    }
		}; 
		
		LxHelper.getFromServer(component, 'getSessionId', params, onResponse); 
	}
})