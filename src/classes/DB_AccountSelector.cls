public virtual class DB_AccountSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Account.BillingLatitude,
                Account.BillingLongitude,
                Account.Id
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Account.sObjectType;
    }

    public List<Account> selectById(Set<Id> idSet) {
   		return (List<Account>) selectSObjectsById(idSet);
    }
    
}