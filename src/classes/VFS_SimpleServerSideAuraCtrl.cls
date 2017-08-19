public with sharing class VFS_SimpleServerSideAuraCtrl {
    @AuraEnabled
    public static String serverEcho(String echoString) {
    	return (new VFS_SimpleServerSideAuraCtrl()).echo(echoString);
    }
    
    @testVisible
    private String echo(String echoString) {
    	return 'Hello from the server, ' + echoString;
    } 
}