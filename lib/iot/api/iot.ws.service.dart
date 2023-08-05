import 'dart:convert';
import 'dart:developer';

import 'package:eezee/iot/api/data/provider/music.player.status.provider.dart';
import 'package:eezee/iot/api/data/provider/music.volume.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'constants.dart';
import 'data/provider/temperature.provider.dart';

final websocketProvider = StreamProvider<List<String>>((ref) async* {

  log("Init websocket");

  final wsUrl = Uri.parse(ApiConstants.wsBaseUrl);
  var channel = WebSocketChannel.connect(wsUrl);

  // close the connection when the stream is destroyed
  ref.onDispose(() => channel.sink.close());

  channel.sink.add('ping!');

    // Parse the received value and emit a message instance
    await for(final message in channel.stream){
      // print(message);
      var parsedJson = jsonDecode(message);
      // print('$parsedJson');
      // print(parsedJson["topic"]);


      String topic = parsedJson["topic"];
      if(topic.startsWith("sensors/temperature/")){
        // print("received a change for a temperature sensor: ");

        var parts = topic.split("/");
        var room = parts.last;
        // print(room);

        // print("${"refreshed " + room} from ws");
        ref.refresh(temperatureSensorProvider(room));
      } else if(topic.startsWith("media/audio/status/")){
        var parts = topic.split("/");
        var room = parts.last;
        // print("received a change for sonos player status :$room");

        ref.refresh(musicPlayerStatusProvider(room));

      } else if(topic.startsWith("media/audio/volume/")){
        var parts = topic.split("/");
        var room = parts.last;
        // print("received a change for sonos player volume : $room");

        ref.refresh(musicVolumeProvider(room));

      }
    }

});