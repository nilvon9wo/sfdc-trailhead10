public class DHP_SimilarPropertyBedroomSearchExpr implements DHP_SimilarPropertySearchExprIntf {
	DB_PropertySelector propertySelector;
	
	public DHP_SimilarPropertyBedroomSearchExpr(DB_PropertySelector propertySelector) {
		this.propertySelector = propertySelector;
	}

	public DHP_SimilarPropertyBedroomSearchExpr() {
		this(new DB_PropertySelector());
	}
	
    public List<Property__c> getSimilar(DHP_PropertySearchDTO searchDTO) {
    	return this.propertySelector.selectByNumberOfBeds(searchDTO.numberOfBeds, searchDTO.propertyId);
    }
}