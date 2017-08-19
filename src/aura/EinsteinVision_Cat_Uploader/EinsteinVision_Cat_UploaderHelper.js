({
	read : function(component, file) {
        if (!file.type.match(/(image.*)/)) {
            return alert('Image file not supported');
        }
        
        var self = this;
        var reader = new FileReader();
        reader.onloadend = function() {
            var dataURL = reader.result;
            component.set('v.image', dataURL);
            self.onUploadImage(component, file, dataURL.match(/,(.*)$/)[1]);
        };
        reader.readAsDataURL(file);
	},

    onUploadImage: function(component, file, base64Data) {
		var params = {
            catId: component.get('v.recordId'),
            fileName: file.name,
            base64: base64Data
        };
		
		var onResponse = function(component) {
			$A.get('e.force:refreshView').fire();
		}; 
		
		LxHelper.getFromServer(component, 'getCatPrediction', params, onResponse); 
	},

    onGetImageUrl: function(component, file, base64Data) { 
		var params = {
            catId: component.get('v.recordId')
        };
		console.log('####### params: ' , params);
		var onResponse = function(component, returnValue) {
			if(returnValue) {
				console.log('####### returnValue: ' , returnValue);
				component.set('v.image', '/servlet/servlet.FileDownload?file=' + returnValue);
			}
		}; 
		
		LxHelper.getFromServer(component, 'getImageUrlFromAttachment', params, onResponse); 
    }
})