({
	getWeather : function(component, event, helper) {
		helper.getWeatherObservation(component);
		helper.getWeatherForecast(component);
	}
})