public virtual class DB_TopicAssignmentSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                TopicAssignment.EntityId,
                TopicAssignment.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return TopicAssignment.sObjectType;
    }

    public List<TopicAssignment> selectWithTopicByIdAndTopicName(Set<Id> idSet, String topicName) {
        return (List<TopicAssignment>) Database.query(
        	newQueryFactory()
        		.setCondition('id IN :idSet AND Topic.Name = :topicName')
        		.toSOQL()
        );
    }
}