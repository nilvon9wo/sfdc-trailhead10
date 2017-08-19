({
    init: function (component, event, helper) {
        var options = [
            { value: "us", label: "United States of America", lon: -95.7129, lat: 37.0902, selected: true },
            { value: "de", label: "Germany", lon: 10.4515, lat: 51.1657 }
        ];
        component.set("v.countryOptions", options);
        helper.getCountryAlerts(component);
    },
    jsLoaded: function(component, event, helper) {
        var map = L.map('map', {zoomControl: false}).setView([37.0902, -95.7129], 5);
        var tileParams = { attribution: 'Tiles © Esri' }; 
        L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', tileParams)
        	.addTo(map);
        component.set("v.map", map);
        helper.getCountryAlerts(component);
    },
    getCountryAlerts: function(component, event, helper) {
        helper.getCountryAlerts(component);
    }
})