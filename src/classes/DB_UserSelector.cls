public virtual class DB_UserSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                User.id,
                User.FirstName,
                User.LastName
        };
    }

    public Schema.SObjectType getSObjectType() {
        return User.sObjectType;
    }

    public List<User> selectById(Set<Id> idSet) {
   		return (List<User>) selectSObjectsById(idSet);
    }
    
}