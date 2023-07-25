import 'dart:async';

import 'package:eezee/iot/api/data/provider/door/door.sensor.provider.dart';
import 'package:eezee/iot/api/iot.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../progress/animated.progress.bar.dart';

class UiDoorWidget extends ConsumerWidget {

  final String label;
  final bool? open;

  const UiDoorWidget({Key? key, required this.label, this.open}) : super(key: key);

  isOpen() {
    return open == true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: isOpen()
            ? LinearGradient(colors: [
              Colors.white, Colors.blueAccent
            ])
            : const LinearGradient(colors: [
            Colors.white, Colors.white10
          ])
          ,
            // LinearGradient(colors: [
            //   Colors.greenAccent, Colors.cyanAccent
            // ]),
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.door_sliding_outlined),
              title: Text(label),
              subtitle: isOpen() ? const Text('Unlocked') : const Text('Locked'),
              trailing:
              ElevatedButton(
                child: Text('Unlock', style: TextStyle(fontSize: 20.0),),

                onPressed: isOpen() ? null : () {
                  IotApiService().unlockDoor(label).then((value) {
                    ref.invalidate(doorSensorProvider(label));
                    Future.delayed(Duration(seconds: 60), () {
                      // Do something
                      ref.invalidate(doorSensorProvider(label));
                    });
                  });

                },
              ),
            ),
            if(isOpen()) AnimatedProgressBarWidget(duration: 60),
          ]

        )

      ),
    );
  }
}