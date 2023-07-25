import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../iot.service.dart';
import '../../model/door/door.sensor.dart';

final doorSensorProvider = FutureProvider.family<DoorSensor, String>((ref, location) async {
  return await IotApiService().getDoorSensor(location);
});
