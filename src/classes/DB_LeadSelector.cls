public virtual class DB_LeadSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Lead.Address,
                Lead.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Lead.sObjectType;
    }

    public List<Lead> selectById(Set<Id> idSet) {
   		return (List<Lead>) selectSObjectsById(idSet);
    }
    
}