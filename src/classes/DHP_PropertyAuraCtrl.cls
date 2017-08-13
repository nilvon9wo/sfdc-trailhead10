public class DHP_PropertyAuraCtrl {
	private static Type DEFAULT_SEARCH_EXPRESSION_TYPE = DHP_SimilarPropertyPriceSearchExpr.class; 
	
	@testVisible private static Map<String, Type> searchExpressionTypeByCriteriaMap = new Map<String, Type> {
		'Bedrooms' => DHP_SimilarPropertyBedroomSearchExpr.class,
		'Price' => DHP_SimilarPropertyPriceSearchExpr.class
	};

	@testVisible private static Map<Type, DHP_SimilarPropertySearchExprIntf> searchExpressionInstanceByTypeMap = new Map<Type, DHP_SimilarPropertySearchExprIntf>();
	
	@AuraEnabled
	public static List<Property__c> getSimilarProperties(
			Id propertyId,
			String searchCriteria,
			Decimal numberOfBeds,
			Decimal price,
			Decimal priceRange
		) {
			DHP_PropertySearchDTO searchDTO = new DHP_PropertySearchDTO(propertyId, searchCriteria, numberOfBeds, price, priceRange);
			return (!String.isBlank(propertyId))
				 ? (new DHP_PropertyAuraCtrl()).getSimilar(searchDTO)
				 : new List<Property__c>();
	}    
 
	@testVisible
	private List<Property__c> getSimilar (DHP_PropertySearchDTO searchDTO) {
		Type searchType = searchExpressionTypeByCriteriaMap.get(searchDTO.searchCriteria);
		if (searchType == null) {
			searchType = DEFAULT_SEARCH_EXPRESSION_TYPE;
		}
		
		if (searchExpressionInstanceByTypeMap.get(searchType) == null) {
			searchExpressionInstanceByTypeMap.put(searchType, (DHP_SimilarPropertySearchExprIntf) searchType.newInstance());
		}
		DHP_SimilarPropertySearchExprIntf searchExpression = searchExpressionInstanceByTypeMap.get(searchType);
		return searchExpression.getSimilar(searchDTO);
	}    
}