import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../iot.service.dart';
import '../model/music.volume.dart';
import '../model/temperature.sensor.dart';

final musicVolumeProvider = FutureProvider.family<MusicVolume, String>((ref, room) async {
  return await IotApiService().getMusicVolume(room);
});
