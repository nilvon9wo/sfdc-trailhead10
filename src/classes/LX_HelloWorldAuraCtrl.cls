public with sharing class LX_HelloWorldAuraCtrl {
	DB_UserSelector userSelector;
	LX_UserInfoWrapper userInfoWrapper;
    
    public LX_HelloWorldAuraCtrl(DB_UserSelector userSelector, LX_UserInfoWrapper userInfoWrapper) {
    	this.userSelector = userSelector;
    	this.userInfoWrapper = userInfoWrapper;
    }

    public LX_HelloWorldAuraCtrl() {
    	this(new DB_UserSelector(), new LX_UserInfoWrapper());
    }
    
    @AuraEnabled
    public static User getCurrentUser() {
    	return (new LX_HelloWorldAuraCtrl()).getUser();
    }
    
    @testVisible
    private User getUser() {
    	return this.userSelector.selectById(new Set<Id>{this.userInfoWrapper.userId})[0];
    }
}