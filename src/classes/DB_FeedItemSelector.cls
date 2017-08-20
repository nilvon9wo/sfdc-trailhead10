public virtual class DB_FeedItemSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
        		FeedItem.Body,
                FeedItem.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return FeedItem.sObjectType;
    }

    public List<FeedItem> selectById(Set<Id> idSet) {
   		return (List<FeedItem>) selectSObjectsById(idSet);
    }
    
}