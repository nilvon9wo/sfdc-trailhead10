(function(_window){
    _window.LxHelper = {
		getFromServer: function(component, serverMethod, params, callback) {
		    component.set('v.spinnerWaiting', true);
		    var action = component.get('c.' + serverMethod);
		    action.setParams(params);
		    action.setCallback(this, this.onResponse(component, callback));
		    $A.enqueueAction(action);
		},
		
		onResponse: function(component, callback) {
		    var self = this;
		    return $A.getCallback(function(response) {
		        if (response.getState() === 'ERROR') {
		            self.onError(response.getError());
		        }
		        else {
		        	var returnValue = response.getReturnValue();
		        	var isObject = (typeof returnValue === 'object') && !Array.isArray(returnValue);
		        	var value = isObject ? JSON.parse(returnValue) : returnValue; 
		            callback(component, value);
		        }
				component.set('v.spinnerWaiting', false);
		    });
		},
		
		onError: function(errors) {
		    var errorMessage = errors && errors[0] && errors[0].message;
		    if (errorMessage) {
		        alert('Error message: ' + errorMessage);
		    }
		    else {
		        console.error('Unknown error');
		    }
		}
    };
})(window);

