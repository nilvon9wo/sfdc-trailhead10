public class INA_UserWrapper {
    public String sessionId {get; private set;}
    
    public INA_UserWrapper() {
    	this.sessionId = UserInfo.getSessionId();
    }
}