public class IBM_Geolocation {
    public Double latitude {get; private set;}
    public Double longitude {get; private set;}
    
    public IBM_Geolocation (Decimal latitude, Decimal longitude) {
    	this.latitude = latitude;
    	this.longitude = longitude;
    } 
    
    public String urlString {
    	get {
    		return this.latitude + '/' + this.longitude; 
    	}
    } 
}