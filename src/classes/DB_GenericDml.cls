public with sharing class DB_GenericDml {
    public List<Database.SaveResult> doInsert(List<SObject> sObjectList, Boolean isAllOrNone) {
    	return Database.insert(sObjectList, isAllOrNone);
    }

    public List<Database.SaveResult> doInsert(List<SObject> sObjectList) {
    	Boolean isAllOrNone = true;
    	return this.doInsert(sObjectList, isAllOrNone);
    }

	// ------------------------------------------------

    public List<Database.SaveResult> doUpdate(List<SObject> sObjectList, Boolean isAllOrNone) {
    	return Database.update(sObjectList, isAllOrNone);
    }

    public List<Database.SaveResult> doUpdate(List<SObject> sObjectList) {
    	Boolean isAllOrNone = true;
    	return this.doUpdate(sObjectList, isAllOrNone);
    }

	// ------------------------------------------------

    public List<Database.DeleteResult> doDelete(List<SObject> sObjectList, Boolean isAllOrNone) {
    	return Database.delete(sObjectList, isAllOrNone);
    }

    public List<Database.DeleteResult> doDelete(List<SObject> sObjectList) {
    	Boolean isAllOrNone = true;
    	return this.doDelete(sObjectList, isAllOrNone);
    }

	// ------------------------------------------------

    public List<Database.SaveResult> doPublish(List<SObject> sObjectList) {
    	return EventBus.publish(sObjectList);
    }
}