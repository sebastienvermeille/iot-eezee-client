// To parse this JSON data, do
//
//     final musicPlaylists = musicPlaylistsFromJson(jsonString);

import 'dart:convert';

MusicPlaylists musicPlaylistsFromJson(String str) => MusicPlaylists.fromJson(json.decode(str));

String musicPlaylistsToJson(MusicPlaylists data) => json.encode(data.toJson());

class MusicPlaylists {
  String room;
  List<Channel> channels;

  MusicPlaylists({
    required this.room,
    required this.channels,
  });

  factory MusicPlaylists.fromJson(Map<String, dynamic> json) => MusicPlaylists(
    room: json["room"],
    channels: List<Channel>.from(json["channels"].map((x) => Channel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "room": room,
    "channels": List<dynamic>.from(channels.map((x) => x.toJson())),
  };
}

class Channel {
  String label;
  String type;
  String source;

  Channel({
    required this.label,
    required this.type,
    required this.source,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    label: json["label"],
    type: json["type"],
    source: json["source"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "type": type,
    "source": source,
  };
}
