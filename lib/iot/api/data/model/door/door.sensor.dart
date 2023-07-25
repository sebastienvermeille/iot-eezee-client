// To parse this JSON data, do
//
//     final doorSensor = doorSensorFromJson(jsonString);

import 'dart:convert';

DoorSensor doorSensorFromJson(String str) => DoorSensor.fromJson(json.decode(str));

String doorSensorToJson(DoorSensor data) => json.encode(data.toJson());

class DoorSensor {
  String door;
  bool locked;
  DateTime measuredAt;

  DoorSensor({
    required this.door,
    required this.locked,
    required this.measuredAt,
  });

  factory DoorSensor.fromJson(Map<String, dynamic> json) => DoorSensor(
    door: json["door"],
    locked: json["locked"],
    measuredAt: DateTime.parse(json["measuredAt"]),
  );

  Map<String, dynamic> toJson() => {
    "door": door,
    "locked": locked,
    "measuredAt": measuredAt.toIso8601String(),
  };
}
