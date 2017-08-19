public with sharing class DB_GenericDml {
    public List<SObject> doInsert(List<SObject> sObjectList) {
    	insert sObjectList;
    	return sObjectList;
    }
}