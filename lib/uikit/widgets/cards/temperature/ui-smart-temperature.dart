import 'package:eezee/iot/api/data/model/temperature.sensor.dart';
import 'package:eezee/iot/api/data/provider/temperature.provider.dart';
import 'package:eezee/iot/api/iot.ws.service.dart';
import 'package:eezee/uikit/widgets/cards/temperature/ui-temperature.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class UiSmartTemperatureWidget extends ConsumerWidget {

  final String room;
  final double celsiusValue = 12;

  const UiSmartTemperatureWidget({Key? key, required this.room })
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<TemperatureSensor> state = ref.watch(temperatureSensorProvider(room)); // this works
    var tmp = ref.watch(websocketProvider); // this works
    // AsyncValue<TemperatureSensor> state = ref.watch(autoUpdatedTemperatureProvider(room)); // this works
    return state.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => UiTemperatureWidget(label: room),
      // error: (err, stack) => Text('Error: $err'),
      data: (state) {
        return UiTemperatureWidget(label: state.room, celsiusValue: state.temperature, tooColdStartAt: 18, tooWarmStartAt: 23);
      },
    );
  }
}