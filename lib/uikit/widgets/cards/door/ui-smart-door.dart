import 'package:eezee/iot/api/data/model/temperature.sensor.dart';
import 'package:eezee/iot/api/data/provider/temperature.provider.dart';
import 'package:eezee/iot/api/iot.ws.service.dart';
import 'package:eezee/uikit/widgets/cards/door/ui-door.dart';
import 'package:eezee/uikit/widgets/cards/temperature/ui-temperature.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../iot/api/data/model/door/door.sensor.dart';
import '../../../../iot/api/data/provider/door/door.sensor.provider.dart';


class UiSmartDoorWidget extends ConsumerWidget {

  final String location;

  const UiSmartDoorWidget({Key? key, required this.location })
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<DoorSensor> state = ref.watch(doorSensorProvider(location)); // this works
    return state.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => UiDoorWidget(label: location, open: null),
      // error: (err, stack) => Text('Error: $err'),
      data: (state) {
        return UiDoorWidget(label: state.door, open: !state.locked);
      },
    );
  }
}