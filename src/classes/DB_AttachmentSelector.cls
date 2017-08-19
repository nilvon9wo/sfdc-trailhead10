public virtual class DB_AttachmentSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Attachment.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Attachment.sObjectType;
    }

    public List<Attachment> selectByParentId(Set<Id> idSet) {
		return (List<Attachment>) Database.query(
			newQueryFactory()
				.setCondition('parentId IN :idSet')
				.toSOQL()
		);
    }
}