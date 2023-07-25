import 'package:eezee/font/weather_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class UiCameraWidget extends StatefulWidget {
  const UiCameraWidget({Key? key, required String label}) : super(key: key);

  @override
  State<UiCameraWidget> createState() => _UiCameraWidgetState();
}

class _UiCameraWidgetState extends State<UiCameraWidget> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.network(
        'http://7.7.7.107:1984/api/stream.mp4?src=UNIFI_MOTO_QA_MED&mp4=all',
      ),
      podPlayerConfig:
        PodPlayerConfig(
          autoPlay: true,
          isLooping: true,
          forcedVideoFocus: true
        )
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 0,
      child: PodVideoPlayer(controller: controller),
    );

  }
}