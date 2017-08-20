trigger TopicAssignmentTrigger on TopicAssignment (after insert) {
	fflib_SObjectDomain.triggerHandler(INA_TopicAssignmentTriggerHandler.class);
}