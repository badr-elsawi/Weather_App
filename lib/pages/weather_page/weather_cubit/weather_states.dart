abstract class WeatherStates {}
class WeatherInitialState extends WeatherStates {}
//get weather data
//********************************************************
class GetDataLoadingState extends WeatherStates {}
class GetDataSuccessState extends WeatherStates {}
class GetDataErrorState extends WeatherStates {}
//********************************************************
//select town state
class SelectTownState extends WeatherStates {}