public virtual class SCM_GlobalDescribeWrapper {
	public virtual List<String> getPickListValuesList(String sObjectType, String selectedField) {
	    List<Schema.PicklistEntry> picklistEntryList = Schema.getGlobalDescribe()
	    	.get(sObjectType) 
	    	.getDescribe()
	    	.fields
	    	.getMap()
	    	.get(selectedField)
	    	.getDescribe()
	     	.getPicklistValues();
	    
	    List<String> pickListValuesList = new List<String>();
	    for( Schema.PicklistEntry picklistEntry : picklistEntryList){
	        pickListValuesList.add(picklistEntry.getLabel());
	    }     
	    return pickListValuesList;
	}
}