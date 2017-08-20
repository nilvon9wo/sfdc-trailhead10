public class INA_TopicAssignmentService {
	DB_FeedItemSelector feedItemSelector;
	DB_TopicAssignmentSelector topicAssignmentSelector;
	INA_NotificationAuraCtrl notificationAuraController;
	
    public INA_TopicAssignmentService(
    		DB_FeedItemSelector feedItemSelector,
    		DB_TopicAssignmentSelector topicAssignmentSelector,
    		INA_NotificationAuraCtrl notificationAuraController
    	) {
    	this.feedItemSelector = feedItemSelector;
    	this.topicAssignmentSelector = topicAssignmentSelector;
    	this.notificationAuraController = notificationAuraController;
    }
    
    public INA_TopicAssignmentService() {
    	this(new DB_FeedItemSelector(), new DB_TopicAssignmentSelector(), new INA_NotificationAuraCtrl());
    }

	private static Integer MESSAGE_LENGTH = 255;
    
    public void bearAlert(List<TopicAssignment> topicAssignmentList) {
    	Set<Id> feedItemIdSet = this.getFeedItemPostIdSet(topicAssignmentList);
    	Map<Id, FeedItem> feedItemByIdMap = new Map<Id, FeedItem>(this.feedItemSelector.selectById(feedItemIdSet));
    	List<String> messageList = this.createMessages(feedItemByIdMap, topicAssignmentList);
    	this.notificationAuraController.publishNotificationList(messageList);
    }
    
    @testVisible
    private Set<Id> getFeedItemPostIdSet(List<TopicAssignment> topicAssignmentList) {
    	Set<Id> feedIdSet = new Set<Id>();
    	for (TopicAssignment topicAssignment: topicAssignmentList) {
    		Id topicAssignmentEntityId = topicAssignment.EntityId; 
    		if (topicAssignmentEntityId.getSObjectType() == FeedItem.SObjectType) {
    			feedIdSet.add(topicAssignmentEntityId);
    		}
    	}
    	return feedIdSet;
    }
    
    @testVisible
    private List<String> createMessages(Map<Id, FeedItem> feedItemByIdMap, List<TopicAssignment> topicAssignmentList) {
    	Set<Id> topicAssignmentIdSet = (new Map<Id, TopicAssignment>(topicAssignmentList)).keySet();
    	List<TopicAssignment> bearTopicAssignmentList = this.topicAssignmentSelector.selectWithTopicByIdAndTopicName(topicAssignmentIdSet, 'BearAlert');

    	List<String> messageList = new List<String>();
    	for (TopicAssignment topicAssignment : bearTopicAssignmentList) {
    		FeedItem feedItem = feedItemByIdMap.get(topicAssignment.EntityId);
    		if (feedItem != null) {
	    		messageList.add(feedItem.body.stripHtmlTags().abbreviate(MESSAGE_LENGTH));
    		}
    	}
    	
    	return messageList; 
    }
    

}