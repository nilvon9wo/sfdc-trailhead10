public class INA_NotificationAuraCtrl {
	DB_GenericDml genericDml;
	INA_UserWrapper userWrapper;
	
	public INA_NotificationAuraCtrl(DB_GenericDml genericDml, INA_UserWrapper userWrapper) {
		this.genericDml = genericDml;
		this.userWrapper = userWrapper;
	}
	
	public INA_NotificationAuraCtrl() {
		this(new DB_GenericDml(), new INA_UserWrapper());
	}

	// --------------------------------------------------------	
	@AuraEnabled
	public static String getSessionId() {
	  return (new INA_NotificationAuraCtrl()).getUserSessionId();
	}

	@testVisible
	private String getUserSessionId() {
	  return this.userWrapper.sessionId;
	}

	// --------------------------------------------------------	
	
	public static void publishNotifications(List<String> messages) {
		(new INA_NotificationAuraCtrl()).publishNotificationList(messages);
	}
	  
	public List<Database.SaveResult> publishNotificationList(List<String> messageList) {
		List<Notification__e> notificationList = new List<Notification__e>();
	  	for (String message: messageList) {
	    	notificationList.add(new Notification__e(Message__c = message));
	  	}
		return this.publishNotificationList(notificationList);
	}
	
	@testVisible 
	private List<Database.SaveResult> publishNotificationList(List<Notification__e> notificationList) {
		List<Database.SaveResult> publishResultList = this.genericDml.doPublish(notificationList);
		for (Database.SaveResult result : publishResultList) {
		    if (!result.isSuccess()) {
		      for (Database.Error error : result.getErrors()) {
		        System.debug(LoggingLevel.ERROR, '!!! Error returned: ' +  error.getStatusCode() +' - '+ error.getMessage());
		      }
		    }
		}
		return publishResultList;
	}	  
}