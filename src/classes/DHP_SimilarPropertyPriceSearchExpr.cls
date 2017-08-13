public class DHP_SimilarPropertyPriceSearchExpr implements DHP_SimilarPropertySearchExprIntf {
	DB_PropertySelector propertySelector;
	
	public DHP_SimilarPropertyPriceSearchExpr(DB_PropertySelector propertySelector) {
		this.propertySelector = propertySelector;
	}

	public DHP_SimilarPropertyPriceSearchExpr() {
		this(new DB_PropertySelector());
	}
	
    public List<Property__c> getSimilar(DHP_PropertySearchDTO searchDTO) {
    	return this.propertySelector.selectByPriceRange(searchDTO.price, searchDTO.priceRange, searchDTO.propertyId);
    }
}