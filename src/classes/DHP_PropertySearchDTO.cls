public class DHP_PropertySearchDTO {
	@testVisible public Id propertyId {get; private set;}
	@testVisible public String searchCriteria {get; private set;}
	@testVisible public Decimal numberOfBeds {get; private set;}
	@testVisible public Decimal price {get; private set;}
	@testVisible public Decimal priceRange {get; private set;}
		
    public DHP_PropertySearchDTO(
    		Id propertyId,
			String searchCriteria,
			Decimal numberOfBeds,
			Decimal price,
			Decimal priceRange
		) {
			this.propertyId = propertyId;
			this.searchCriteria = searchCriteria;
			this.numberOfBeds = numberOfBeds;
			this.price = price;
			this.priceRange = priceRange;
    }
}