({
    getCountryAlerts : function(component) {
        this.getFromServer(component, 'getWeatherAlerts', this.displayWeatherAlerts);
    },
    getFromServer: function(component, serverMethod, callback) {
        component.set('v.spinnerWaiting', true);
        var action = component.get('c.' + serverMethod);
        action.setParams({
            country: component.get('v.countrySelected')
        });
        action.setCallback(this, this.onResponse(component, callback));
        $A.enqueueAction(action);
    },
    displayWeatherAlerts: function(component, responseValue) {
        var alertsFromJson = responseValue.alerts;
        if (!alertsFromJson)  {
        	this.toastMissingAlerts();
            return;
        }

        var map = component.get('v.map');
        this.removeOldMarkers(component, map);
        this.addNewMarkers(component, alertsFromJson, map);
        this.panToCountry(component, map);
    },
    removeOldMarkers: function(component, map) {
        var oldAlerts = component.get('v.alerts');
        for (var i = 0; i < oldAlerts.length; i++) {
            map.removeLayer(oldAlerts[i]);
        }
    }, 
    addNewMarkers: function(component, alertsFromJson, map) {
        var newAlerts = [];
        for (var i = 0; i < alertsFromJson.length; i++) {
            var newAlert = alertsFromJson[i];
            var marker = L.marker([newAlert.lat, newAlert.lon])
                .addTo(map)
                .bindPopup(newAlert.event_desc);
            newAlerts.push(marker);
        }
        component.set('v.alerts', newAlerts);
    },
    panToCountry: function(component, map) {
        var targetCountry = component.get('v.countrySelected')
        var countryOptions = component.get('v.countryOptions');
        var panToCountry = countryOptions.find(helper.findTargetCountry(targetCountry));
        map.panTo(new L.LatLng(panToCountry.lat, panToCountry.lon));
    },
    findTargetCountry: function(targetCountry) {
        return function(optionCountry) {
        	var isMatch = optionCountry.value === targetCountry; 
            return isMatch;
        };
    },
    onResponse: function(component, callback) {
        var self = this;
        return $A.getCallback(function(response) {
            if (response.getState() === 'ERROR') {
                self.onError(response.getError());
            }
            else {
                callback(component, JSON.parse(response.getReturnValue()));
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
    },
    toastMissingAlerts: function() {
        var toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            message: 'There are no weather alerts for the selected country available. Lucky them!',
            title: 'No weather alerts!',
            type: 'success'
        });
        toastEvent.fire();
    }        
})