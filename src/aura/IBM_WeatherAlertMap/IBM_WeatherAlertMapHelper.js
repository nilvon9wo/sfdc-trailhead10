({
    getCountryAlerts: function(component) {
        var action = component.get("c.getWeatherAlerts");
        var countryId = component.get("v.countrySelected");
        component.set("v.spinnerWaiting", true);
        action.setParams({country: countryId});
        action.setCallback(this, function(resp) {
            var state = resp.getState();
            console.log(state);
            if (state === 'ERROR') {
                var errors = resp.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
                component.set("v.spinnerWaiting", false);
                return;
            }
            var map = component.get("v.map");
            var alertsJson = JSON.parse(resp.getReturnValue()).alerts;
            if (typeof alertsJson=='undefined') {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: "No weather alerts!",
                    message: "There are no weather alerts for the selected country available. Lucky them!",
                    type: "success"
                });
                toastEvent.fire();
                component.set("v.spinnerWaiting", false);
                return;
            }
            var alerts = component.get("v.alerts");
            for (var i=0;i<alerts.length;i++) {
                map.removeLayer(alerts[i]);
            }
            alerts = [];
            for (var n=0;n<alertsJson.length;n++) {
                var marker = L.marker([alertsJson[n].lat, alertsJson[n].lon]).addTo(map)
                .bindPopup(alertsJson[n].event_desc);
                alerts.push(marker);
            }
            var countryOptions = component.get("v.countryOptions");
            for (var n=0;n<countryOptions.length;n++) {
                if (countryOptions[n].value==countryId) {
                    map.panTo(new L.LatLng(countryOptions[n].lat, countryOptions[n].lon));
                    break;                    
                }
            }
            component.set("v.alerts", alerts);
            component.set("v.spinnerWaiting", false);
        });
        $A.enqueueAction(action);
    },
	getCountryAlerts2 : function(component) {
		this.getFromServer(component, 'getWeatherAlerts', this.displayWeatherAlerts);
	},
	getFromServer: function(component, serverMethod, callback) {
		var action = component.get('c.' + serverMethod);
		action.setParams({
			recordId: component.get('v.recordId')
		});
		action.setCallback(this, this.onResponse(component, callback));
        $A.enqueueAction(action);
	},
    displayWeatherAlerts: function(component, responseValue) {
    	// TODO
	},
	onResponse: function(component, callback) {
		var self = this;
		return function(response) {
			if (response.getState() === 'ERROR') {
				self.onError(response.getError());
			}
			else {
				callback(component, JSON.parse(response.getReturnValue()));
			}
		}
	},
	onError: function(errors) {
		var errorMessage = errors && errors[0] && errors[0].message;
		if (errorMessage) {
			alert('Error message: ' + errorMessage);
		}
		else {
			console.error('Unknown error');
		}
	},
})