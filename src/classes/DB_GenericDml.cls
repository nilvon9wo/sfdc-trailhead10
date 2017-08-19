public with sharing class DB_GenericDml {
    public List<SObject> doInsert(List<SObject> sObjectList) {
    	insert sObjectList;
    	return sObjectList;
    }

    public List<SObject> doUpdate(List<SObject> sObjectList) {
    	update sObjectList;
    	return sObjectList;
    }

    public List<SObject> doDelete(List<SObject> sObjectList) {
    	delete sObjectList;
    	return sObjectList;
    }
}