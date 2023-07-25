import 'dart:convert';

TemperatureSensor temperatureSensorFromJson(String str) => TemperatureSensor.fromJson(json.decode(str));

String temperatureSensorToJson(TemperatureSensor data) => json.encode(data.toJson());

class TemperatureSensor {
  double temperature;
  String unit;
  DateTime measuredAt;
  String room;

  TemperatureSensor({
    required this.temperature,
    required this.unit,
    required this.measuredAt,
    required this.room,
  });

  factory TemperatureSensor.fromJson(Map<String, dynamic> json) => TemperatureSensor(
    temperature: json["temperature"]?.toDouble(),
    unit: json["unit"],
    measuredAt: DateTime.parse(json["measuredAt"]),
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "unit": unit,
    "measuredAt": measuredAt.toIso8601String(),
    "room": room,
  };
}