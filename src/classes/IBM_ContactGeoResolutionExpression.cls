public class IBM_ContactGeoResolutionExpression implements IBM_GeoResolutionExpressionIntf {
    private DB_ContactSelector contactSelector; 
    
    public IBM_ContactGeoResolutionExpression(DB_ContactSelector contactSelector) {
    	this.contactSelector = contactSelector;
    }
    
    public IBM_ContactGeoResolutionExpression() {
    	this(new DB_ContactSelector());
    }
    
    public IBM_Geolocation resolveGeolocation(Id contactId) {
    	Contact contact = this.contactSelector.selectById(new Set<Id>{contactId})[0];

    	IBM_Geolocation geolocation;  
    	if (contact != null) {
    		geolocation = new IBM_Geolocation(contact.MailingLatitude, contact.MailingLongitude); 
    	}
    	return geolocation;
    }
}