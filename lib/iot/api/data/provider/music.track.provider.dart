import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../iot.service.dart';
import '../model/music.track.dart';
import '../model/music.volume.dart';
import '../model/temperature.sensor.dart';

final musicTrackProvider = FutureProvider.family<MusicTrack, String>((ref, room) async {
  return await IotApiService().getMusicTrack(room);
});
