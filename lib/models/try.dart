class WeatherModelTry {
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherModelTry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
    json['current'] != null ? new Current.fromJson(json['current']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  String? tzId;
  String? localtime;


  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    tzId = json['tz_id'];
    localtime = json['localtime'];
  }
}

class Current {
  String? lastUpdated;
  double? tempC;
  var isDay;
  Condition? condition;
  var windKph;
  String? windDir;
  int? humidity;
  double? feelslikeC;
  double? uv;

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDir = json['wind_dir'];
    humidity = json['humidity'];
    feelslikeC = json['feelslike_c'];
    uv = json['uv'];
  }
}

class Condition {
  String? text;
  String? icon;
  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(new Forecastday.fromJson(v));
      });
    }
  }
}

class Forecastday {
  String? date;
  Day? day;
  Astro? astro;
  List<Hour>? hour;

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? new Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? new Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(new Hour.fromJson(v));
      });
    }
  }
}

class Day {
  double? maxtempC;
  double? mintempC;
  double? avgtempC;
  double? avghumidity;
  Condition? condition;
  double? uv;

  Day.fromJson(Map<String, dynamic> json) {
    maxtempC = json['maxtemp_c'];
    mintempC = json['mintemp_c'];
    avgtempC = json['avgtemp_c'];
    avghumidity = json['avghumidity'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    uv = json['uv'];
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  String? moonPhase;
  String? moonIllumination;


  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonset = json['moonset'];
    moonPhase = json['moon_phase'];
    moonIllumination = json['moon_illumination'];
  }
}

class Hour {
  String? time;
  double? tempC;
  var isDay;
  Condition? condition;
  var windKph;
  var windDir;
  int? humidity;
  double? feelslikeC;
  double? uv;

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    windDir = json['wind_dir'];
    humidity = json['humidity'];
    feelslikeC = json['feelslike_c'];
    uv = json['uv'];
  }
}
