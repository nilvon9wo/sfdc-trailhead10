public abstract class LX_VisualForcePageBase { 
	private LX_UserInfoWrapper userInfoWrapper;  
	private LX_VisualForcePageWrapper visualForcePageWrapper;
	
	public LX_VisualForcePageBase(LX_UserInfoWrapper userInfoWrapper, LX_VisualForcePageWrapper visualForcePageWrapper) {
		this.userInfoWrapper = userInfoWrapper;
		this.visualForcePageWrapper = visualForcePageWrapper;
	}
	 
	public LX_VisualForcePageBase() {
		this(new LX_UserInfoWrapper(), new LX_VisualForcePageWrapper());
	}

	public Boolean getIsClassic() {
    	return this.userInfoWrapper.usesClassic()
    		&& !this.visualForcePageWrapper.hasLightningParam();
	}

	public Boolean getIsLightningExperience() {
    	return !this.getIsClassic();
	} 
}