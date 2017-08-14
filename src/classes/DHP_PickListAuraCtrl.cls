public class DHP_PickListAuraCtrl {
	SCM_GlobalDescribeWrapper globalDescribeWrapper; 
	
	public DHP_PickListAuraCtrl(SCM_GlobalDescribeWrapper globalDescribeWrapper) {
		this.globalDescribeWrapper = globalDescribeWrapper;
	} 

	public DHP_PickListAuraCtrl() {
		this(new SCM_GlobalDescribeWrapper());
	} 
	
	@AuraEnabled        
	public static List<String> getPickListValuesIntoList(String sObjectType, String selectedField) {
		return (new DHP_PickListAuraCtrl()).getPickListValuesList(sObjectType, selectedField);
	}
	
	@testVisible
	private List<String> getPickListValuesList(String sObjectType, String selectedField) {
		return this.globalDescribeWrapper.getPickListValuesList(sObjectType, selectedField);
	}
}