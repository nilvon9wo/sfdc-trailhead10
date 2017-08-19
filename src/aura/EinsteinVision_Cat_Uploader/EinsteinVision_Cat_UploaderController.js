({
    onReadImage: function(component, event, helper) {
        var files = component.get('v.files');
        var file = files && files.length > 0 && files[0][0];  
        if (file) {
        	helper.read(component, file);
        }   
    },
    onGetImageUrl: function(component, event, helper) {
    	console.log('########## helper: ', helper);
        helper.onGetImageUrl(component);
    },
})