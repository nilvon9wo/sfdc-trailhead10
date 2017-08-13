public class LX_VisualForcePageWrapper { 
	@testVisible private Map<String, String> pageParameters;
	
	public LX_VisualForcePageWrapper() {
		this.pageParameters = ApexPages.currentPage().getParameters();
	}
	
	public Boolean hasLightningParam() {
		return !String.isBlank(pageParameters.get('beLightning'));
	}
}