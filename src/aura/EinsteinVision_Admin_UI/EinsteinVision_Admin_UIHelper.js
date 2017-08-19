({
	onCreateDataset : function(component) {
		var params = { 
			zipUrl : component.find('zipUrl').get('v.value')
		};
		
		var self = this;
		var onResponse = function(component) {
			self.onLoadDatasets(component);
		}; 
		
		LxHelper.getFromServer(component, 'createDatasetFromUrl', params, onResponse); 
	},

    // ---------------------------------------------------------------------------------------------

    onLoadDatasets: function(component) {
		var params = {};

		var self = this;
		var onResponse = function(component, returnValue) {
	    	component.set('v.datasets', returnValue);
	    	if (returnValue.length > 0) {
	    		self.onModelStatus(component, returnValue);
	    	};
	    };

		LxHelper.getFromServer(component, 'getDatasets', params, onResponse); 
    },

    // ---------------------------------------------------------------------------------------------

    onModelStatus: function(component, datasets) {
    	var params = {
    		datasetId: datasets[0].id
    	};

		var onResponse = function(component, returnValue) {
	    	component.set('v.datasetModels', returnValue)
	    };

    	LxHelper.getFromServer(component, 'getModels', params, onResponse);
    },

    // ---------------------------------------------------------------------------------------------

    onDeleteDataset: function(component, event) {
    	var params = {
    		datasetId: event.getSource().get('v.value')
    	};

		var self = this;
		var onResponse = function(component) {
			self.onLoadDatasets(component);
	    };

   		LxHelper.getFromServer(component, 'deleteDataset', params, onResponse);
    },

    // ---------------------------------------------------------------------------------------------

    onTrainDataset: function(component, event) {
    	var params = {
    		datasetId: event.getSource().get('v.value')
    	};

		var onResponse = function(component, returnValue) {
	    	var toastEvent = $A.get('e.force:showToast');
	    	toastEvent.setParams({
	    		title: 'Success!',
	    		type: 'success',
	    		message: 'The model id for the training is' + returnValue + '.'
	    			+ '  Refresh the dataset to see the training progress.'
	    	});
	    	toastEvent.fire();
	    };

   		LxHelper.getFromServer(component, 'trainDataset', params, onResponse);
    } 
})