public class LX_UserInfoWrapper {  
    public Id userId {get; private set;}

    @testVisible private String uiThemeDisplayed;
    
    public LX_UserInfoWrapper() {
    	this.uiThemeDisplayed = UserInfo.getUiThemeDisplayed();
    	this.userId = UserInfo.getUserId();
    }
    
    public Boolean usesClassic() {
    	return this.uiThemeDisplayed == 'Theme3';
    }
}