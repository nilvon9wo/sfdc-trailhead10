global with sharing class PART_PostInstall implements InstallHandler {
	private DB_GenericDml genericDml;
	
	public PART_PostInstall(DB_GenericDml genericDml) {
		this.genericDml = genericDml;
	}

	public PART_PostInstall() {
		this(new DB_GenericDml());
	}
	
    global void onInstall(InstallContext installContext) {
    	if (installContext.previousVersion() == null) {
    		this.genericDml.doInsert(new List<Account>{new Account(name = 'New Account')});
    	}
    	else if (installContext.previousVersion().compareTo(new Version(1,0)) == 0) {
    	}
    	if (installContext.isUpgrade()) {
    	}
    	if (installContext.isPush()) {
    	}
    }
}