public class IBM_LeadGeoResolutionExpression implements IBM_GeoResolutionExpressionIntf {
    private DB_LeadSelector leadSelector;
    
    public IBM_LeadGeoResolutionExpression(DB_LeadSelector leadSelector) {
    	this.leadSelector = leadSelector;
    }
    
    public IBM_LeadGeoResolutionExpression() {
    	this(new DB_LeadSelector());
    }
    
    public IBM_Geolocation resolveGeolocation(Id leadId) { 
    	Lead lead = this.leadSelector.selectById(new Set<Id>{leadId})[0];

    	IBM_Geolocation geolocation;   
    	if (lead != null) {
    		geolocation = new IBM_Geolocation(lead.Address.getLatitude(), lead.Address.getLongitude()); 
    	}
    	return geolocation;
    } 
}