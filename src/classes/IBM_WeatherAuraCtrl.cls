public class IBM_WeatherAuraCtrl {
	private IBM_UserWrapper userWrapper;
	private Http http;
	
	public IBM_WeatherAuraCtrl(IBM_UserWrapper userWrapper, Http http) {
		this.userWrapper = userWrapper;
		this.http = http;
	}

	public IBM_WeatherAuraCtrl() {
		this(new IBM_UserWrapper(), new Http());
	}

	private final static Map<SObjectType, Type> GEOLOCATION_RESOLUTION_EXPRESSION_TYPE_BY_SOBJECT_TYPE_MAP = new Map<SObjectType, Type>{
		Account.SObjectType => IBM_AccountGeoResolutionExpression.class,
		Contact.SObjectType => IBM_ContactGeoResolutionExpression.class,
		Lead.SObjectType => IBM_LeadGeoResolutionExpression.class 
	};

	private final static Map<SObjectType, IBM_GeoResolutionExpressionIntf> GEOLOCATION_RESOLUTION_EXPRESSION_BY_SOBJECT_TYPE_MAP 
		= new Map<SObjectType, IBM_GeoResolutionExpressionIntf>();


	// Weather Observation ------------------------------------------------------
	
	@AuraEnabled 
	public static String getWeatherObservation(Id recordId) {
		return (new IBM_WeatherAuraCtrl()).getObservation(recordId);
	}

	@testVisible 
	private String getObservation(Id recordId) {
		IBM_Geolocation geoLocation = this.resolveGeolocation(recordId);
       	return this.requestWeather('geocode/' + geoLocation.urlString + '/observations.json');
	}

	// Weather Forecasts ------------------------------------------------------

	@AuraEnabled 
	public static String getWeather3DayForecasts(Id recordId) {
		return (new IBM_WeatherAuraCtrl()).get3DayForecasts(recordId);
	}

	@testVisible 
	private String get3DayForecasts(Id recordId) {
		IBM_Geolocation geoLocation = this.resolveGeolocation(recordId);
       	return this.requestWeather('geocode/' + geoLocation.urlString + '/forecast/daily/3day.json?units=m');
	}
	
	// Weather Alerts ------------------------------------------------------

	@AuraEnabled 
	public static String getWeatherAlerts(String country) {
		return (new IBM_WeatherAuraCtrl()).getAlerts(country);
	}

	@testVisible 
	private String getAlerts(String country) {
        return this.requestWeather('country/' + country + '/alerts.json');
	}
	
	// Helpers ------------------------------------------------------
    
	@testVisible 
    private IBM_Geolocation resolveGeolocation(Id recordId) {
    	SObjectType sObjectType = recordId.getSobjectType(); 
    	if (GEOLOCATION_RESOLUTION_EXPRESSION_BY_SOBJECT_TYPE_MAP.get(sObjectType) == null) {
    		IBM_GeoResolutionExpressionIntf resolutionExpression 
    			= (IBM_GeoResolutionExpressionIntf) GEOLOCATION_RESOLUTION_EXPRESSION_TYPE_BY_SOBJECT_TYPE_MAP.get(sObjectType).newInstance();
    		GEOLOCATION_RESOLUTION_EXPRESSION_BY_SOBJECT_TYPE_MAP.put(sObjectType, resolutionExpression);
    	}
    	return GEOLOCATION_RESOLUTION_EXPRESSION_BY_SOBJECT_TYPE_MAP.get(sObjectType).resolveGeolocation(recordId); 
    }

	@testVisible 
    private String requestWeather(String url) {
    	String languageParamSeparator = url.contains('?') ? '&' : '?'; 

    	HttpRequest request = new HttpRequest();
    	request.setEndpoint(
    		'callout:IBM_Bluemix_Weather/api/weather/v1/' + url 
    		+ languageParamSeparator + 'language=' + this.userWrapper.language
    	);
    	request.setMethod('GET');
    	
    	return http.send(request).getBody();
    }
}