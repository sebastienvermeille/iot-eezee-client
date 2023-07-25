// To parse this JSON data, do
//
//     final meteoToday = meteoTodayFromJson(jsonString);

import 'dart:convert';

MeteoToday meteoTodayFromJson(String str) => MeteoToday.fromJson(json.decode(str));

String meteoTodayToJson(MeteoToday data) => json.encode(data.toJson());

class MeteoToday {
  String zipCode;
  Today today;

  MeteoToday({
    required this.zipCode,
    required this.today,
  });

  factory MeteoToday.fromJson(Map<String, dynamic> json) => MeteoToday(
    zipCode: json["zipCode"],
    today: Today.fromJson(json["today"]),
  );

  Map<String, dynamic> toJson() => {
    "zipCode": zipCode,
    "today": today.toJson(),
  };
}

class Today {
  Temperature temperature;
  Rain rain;
  Weather weather;
  String weekday;

  Today({
    required this.temperature,
    required this.rain,
    required this.weather,
    required this.weekday,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
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
  double mean;
  String unit;

  Rain({
    required this.mean,
    required this.unit,
  });

  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    mean: json["mean"]?.toDouble(),
    unit: json["unit"],
  );

  Map<String, dynamic> toJson() => {
    "mean": mean,
    "unit": unit,
  };
}

class Temperature {
  int min;
  int max;
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
