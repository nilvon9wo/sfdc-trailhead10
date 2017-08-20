public class INA_TopicAssignmentTriggerHandler extends fflib_SObjectDomain {
    List<TopicAssignment> topicAssignmentList;
    INA_TopicAssignmentService topicAssignmentService; 

    public INA_TopicAssignmentTriggerHandler(List<TopicAssignment> topicAssignmentList, INA_TopicAssignmentService topicAssignmentService) {
        super(topicAssignmentList);
        this.topicAssignmentList = topicAssignmentList;
        this.topicAssignmentService = topicAssignmentService; 
    }
    
    public INA_TopicAssignmentTriggerHandler(List<TopicAssignment> topicAssignmentList) {
        this(topicAssignmentList, new INA_TopicAssignmentService());
    }
 
    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> topicAssignmentList) {
            return new INA_TopicAssignmentTriggerHandler (topicAssignmentList);
        }
    } 
	
    public override void onAfterInsert() {
    	this.topicAssignmentService.bearAlert(this.topicAssignmentList);
    }
}