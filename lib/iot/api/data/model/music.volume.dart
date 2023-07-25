// To parse this JSON data, do
//
//     final musicVolume = musicVolumeFromJson(jsonString);

import 'dart:convert';

MusicVolume musicVolumeFromJson(String str) => MusicVolume.fromJson(json.decode(str));

String musicVolumeToJson(MusicVolume data) => json.encode(data.toJson());

class MusicVolume {
  int volume;
  String room;

  MusicVolume({
    required this.volume,
    required this.room,
  });

  factory MusicVolume.fromJson(Map<String, dynamic> json) => MusicVolume(
    volume: json["volume"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "volume": volume,
    "room": room,
  };
}
