import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../iot.service.dart';
import '../model/temperature.sensor.dart';

final temperatureSensorProvider = FutureProvider.family<TemperatureSensor, String>((ref, room) async {
  return await IotApiService().getTemperature(room);
});
