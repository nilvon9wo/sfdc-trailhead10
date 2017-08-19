public class IBM_AccountGeoResolutionExpression implements IBM_GeoResolutionExpressionIntf {
    private DB_AccountSelector accountSelector; 
    
    public IBM_AccountGeoResolutionExpression(DB_AccountSelector accountSelector) {
    	this.accountSelector = accountSelector;
    }
    
    public IBM_AccountGeoResolutionExpression() {
    	this(new DB_AccountSelector());
    }
    
    public IBM_Geolocation resolveGeolocation(Id accountId) {
    	Account account = this.accountSelector.selectById(new Set<Id>{accountId})[0];

    	IBM_Geolocation geolocation;  
    	if (account != null) {
    		geolocation = new IBM_Geolocation(account.BillingLatitude, account.BillingLongitude); 
    	}
    	return geolocation;
    } 
}