// To parse this JSON data, do
//
//     final meteoForecast = meteoForecastFromJson(jsonString);

import 'dart:convert';

MeteoForecast meteoForecastFromJson(String str) => MeteoForecast.fromJson(json.decode(str));

String meteoForecastToJson(MeteoForecast data) => json.encode(data.toJson());

class MeteoForecast {
  String zipCode;
  List<Forecast> forecast;

  MeteoForecast({
    required this.zipCode,
    required this.forecast,
  });

  factory MeteoForecast.fromJson(Map<String, dynamic> json) => MeteoForecast(
    zipCode: json["zipCode"],
    forecast: List<Forecast>.from(json["forecast"].map((x) => Forecast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "zipCode": zipCode,
    "forecast": List<dynamic>.from(forecast.map((x) => x.toJson())),
  };
}

class Forecast {
  Temperature temperature;
  Rain rain;
  Weather weather;
  String weekday;

  Forecast({
    required this.temperature,
    required this.rain,
    required this.weather,
    required this.weekday,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    temperature: Temperature.fromJson(json["temperature"]),
    rain: Rain.fromJson(json["rain"]),
    weather: Weather.fromJson(json["weather"]),
    weekday: json["weekday"],
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature.toJson(),
    "rain": rain.toJson(),
    "weather": weather.toJson(),
    "weekday": weekday,
  };
}

class Rain {
  String mean;

  Rain({
    required this.mean,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    mean: json["mean"],
  );

  Map<String, dynamic> toJson() => {
    "mean": mean,
  };
}

class Temperature {
  String min;
  String max;
  String unit;

  Temperature({
    required this.min,
    required this.max,
    required this.unit,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) => Temperature(
    min: json["min"],
    max: json["max"],
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
    "unit": unit,
  };
}

class Weather {
  String symbol;

  Weather({
    required this.symbol,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "symbol": symbol,
  };
}
