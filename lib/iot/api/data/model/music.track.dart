// To parse this JSON data, do
//
//     final musicTrack = musicTrackFromJson(jsonString);

import 'dart:convert';

MusicTrack musicTrackFromJson(String str) => MusicTrack.fromJson(json.decode(str));

String musicTrackToJson(MusicTrack data) => json.encode(data.toJson());

class MusicTrack {
  Track track;
  String room;

  MusicTrack({
    required this.track,
    required this.room,
  });

  factory MusicTrack.fromJson(Map<String, dynamic> json) => MusicTrack(
    track: Track.fromJson(json["track"]),
    room: json["room"],
  );

  Map<String, dynamic> toJson() => {
    "track": track.toJson(),
    "room": room,
  };
}

class Track {
  String artist;
  String album;
  String title;
  String cover;

  Track({
    required this.artist,
    required this.album,
    required this.title,
    required this.cover,
  });

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    artist: json["artist"],
    album: json["album"],
    title: json["title"],
    cover: json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "artist": artist,
    "album": album,
    "title": title,
    "cover": cover,
  };
}
