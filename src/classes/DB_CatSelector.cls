public virtual class DB_CatSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Cat__c.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Cat__c.sObjectType;
    }

    public List<Cat__c> selectById(Set<Id> idSet) {
   		return (List<Cat__c>) selectSObjectsById(idSet);
    }
    
}