import 'dart:convert';
import 'dart:developer';

import 'package:eezee/iot/api/constants.dart';
import 'package:eezee/iot/api/data/model/encoded.binary.dart';
import 'package:eezee/iot/api/data/model/meteo/meteo.today.dart';
import 'package:eezee/iot/api/data/model/music.player.status.dart';
import 'package:eezee/iot/api/data/model/music.playlists.dart';
import 'package:eezee/iot/api/data/model/music.volume.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'data/model/door/door.sensor.dart';
import 'data/model/music.track.dart';
import 'data/model/temperature.sensor.dart';

class IotApiService {
  Future<TemperatureSensor> getTemperature(String room) async {
    late TemperatureSensor data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.temperatureSensorEndpoint}/$room");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = TemperatureSensor.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
      // print('Error Occurred'+e.toString());
    }
    return data;
  }

  getMusicVolume(String room) async {
    late MusicVolume data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicVolumeEndpoint}/$room");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = MusicVolume.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  getMusicTrack(String room) async {
    late MusicTrack data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicTrackEndpoint}/$room");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = MusicTrack.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  getMusicPlaylists(String room) async {
    late MusicPlaylists data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicPlayerPlaylistsEndpoint}/$room");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = MusicPlaylists.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  getMusicPlayerStatus(String room) async {
    late MusicPlayerStatus data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicPlayerStatusEndpoint}/$room");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = MusicPlayerStatus.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  playMusic(String label) async {
    print('play');
    return _updateMusicPlayerStatus(label, true);
  }

  pauseMusic(String label) async {
    print('pause');
    return _updateMusicPlayerStatus(label, false);
  }

  _updateMusicPlayerStatus(String room, bool on) async {
    late MusicPlayerStatus data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicPlayerStatusEndpoint}/$room");
      var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode({ "status": on }));
      if(response.statusCode == 200){
        data = MusicPlayerStatus.fromJson(json.decode(response.body));

        return data;
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
        return Future.error("Received ${response.statusCode}");
      }
    } catch (e) {
      print('Error Occurred');
      return Future.error("Exception occured ouops");
    }
  }

  Future<bool> definePlaylist(String room, String channel) async {
    MusicPlaylists playlists = await getMusicPlaylists(room);

    Channel completeChannel = playlists.channels.firstWhere((element) => element.label == channel);
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicPlayerPlaylistsEndpoint}/$room");
      var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode({ "channel": completeChannel }));
      if(response.statusCode == 200){
        print('ok');
        return Future.value(true);
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
        return Future.error("Received ${response.statusCode}");
      }
    } catch (e) {
      print('Error Occurred');
      return Future.error("Exception occured ouops");
    }
  }

  Image _imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  // TODO: delete not used
  Future<Image> getBinary(String uri) async {

    var bytes = utf8.encode(uri);
    var encodedUri = base64.encode(bytes);

    print('Get binary ' + uri);

    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.binaryEndpoint}$encodedUri");
      var response = await http.get(url, headers: {"Content-Type": "application/json"});
      if(response.statusCode == 200){

        EncodedBinary encodedBinary = EncodedBinary.fromJson(json.decode(response.body));

        return Future.value(_imageFromBase64String(encodedBinary.data));

        // return Future.value(true);
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
        return Future.error("Received ${response.statusCode}");
      }
    } catch (e) {
      print('Error Occurred');
      return Future.error("Exception occured ouops");
    }
  }

  setMusicVolume(String room, int value) async {
    print('set volume');
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.musicVolumeEndpoint}/$room");
      var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: jsonEncode({ "volume": value }));
      if(response.statusCode == 200){
        print('ok');
        return Future.value(true);
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
        return Future.error("Received ${response.statusCode}");
      }
    } catch (e) {
      print('Error Occurred');
      return Future.error("Exception occured ouops");
    }
  }

  getMeteoToday(int zipCode) async {
    late MeteoToday data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.meteoTodayEndpoint}/$zipCode");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = MeteoToday.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  getDoorSensor(String location) async {
    late DoorSensor data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.doorSensorEndpoint}/$location");
      var response = await http.get(url);
      if(response.statusCode == 200){
        data = DoorSensor.fromJson(json.decode(response.body));
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
      }
    } catch (e) {
      print('Error Occurred');
    }
    return data;
  }

  Future<DoorSensor> unlockDoor(String location) async {
    late DoorSensor data;
    try {
      var url = Uri.parse("${ApiConstants.baseUrl}${ApiConstants.doorUnlockEndpoint}/$location");
      var response = await http.post(url, headers: {"Content-Type": "application/json"});
      if(response.statusCode == 200){
        data = DoorSensor.fromJson(json.decode(response.body));
        return data;
      } else if(response.statusCode == 204){
        // maybe not yet cached
        print('received 204, maybe it is not yet cached');
        return Future.error("Received 204, maybe it is not yet cached by the server.");
      }
      else {
        print('Error Occurred received: ${response.statusCode}');
        return Future.error("Received ${response.statusCode}");
      }
    } catch (e) {
      print('Error Occurred');
      return Future.error("Exception occured ouops");
    }
  }
}