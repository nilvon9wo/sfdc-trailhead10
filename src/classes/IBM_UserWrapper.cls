public class IBM_UserWrapper {
    public String language {get; private set;}
    
    public IBM_UserWrapper() {
    	this.language = UserInfo.getLanguage().replace('_','-');
    } 
}