// To parse this JSON data, do
//
//     final musicPlayerStatus = musicPlayerStatusFromJson(jsonString);

import 'dart:convert';

MusicPlayerStatus musicPlayerStatusFromJson(String str) => MusicPlayerStatus.fromJson(json.decode(str));

String musicPlayerStatusToJson(MusicPlayerStatus data) => json.encode(data.toJson());

class MusicPlayerStatus {
  bool playing;
  String room;

  MusicPlayerStatus({
    required this.playing,
    required this.room,
  });

  factory MusicPlayerStatus.fromJson(Map<String, dynamic> json) => MusicPlayerStatus(
    playing: json["playing"],
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "playing": playing,
    "room": room,
  };
}
