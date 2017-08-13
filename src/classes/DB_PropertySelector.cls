public virtual class DB_PropertySelector extends fflib_SObjectSelector {
	private static final Decimal DEFAULT_PRICE = 1;
	private static final Decimal DEFAULT_PRICE_RANGE = 100000;

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Property__c.Baths__c,
                Property__c.Beds__c,
                Property__c.Broker__c,
                Property__c.Id,
                Property__c.Name,
                Property__c.Price__c,
                Property__c.Status__c,
                Property__c.Thumbnail__c
        };
    }

    public Schema.SObjectType getSObjectType() {
        return Property__c.sObjectType;
    }

    public List<Property__c> selectByNumberOfBeds(Decimal numberOfBeds, Id excludedProperty) {
		return (List<Property__c>) Database.query(
			newQueryFactory()
				.setCondition('beds__c = :numberOfBeds AND id != :excludedProperty')
				.toSOQL()
		);
    }

    public List<Property__c> selectByPriceRange(Decimal price, Decimal priceRange, Id excludedProperty) {
		Decimal searchPrice = (price != null) ? price : DEFAULT_PRICE;
    	Decimal searchRange = (priceRange != null) ? priceRange : DEFAULT_PRICE_RANGE;
    	Decimal minimum = searchPrice - searchRange;
    	Decimal maximum = searchPrice + searchRange;
    	return (List<Property__c>) Database.query(
			newQueryFactory()
				.setCondition('price__c > :minimum AND price__c < :maximum AND id != :excludedProperty')
				.toSOQL()
		);
    }

}