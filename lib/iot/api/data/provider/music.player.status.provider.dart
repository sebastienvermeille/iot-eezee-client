import 'package:eezee/iot/api/data/model/music.player.status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../iot.service.dart';

final musicPlayerStatusProvider = FutureProvider.family<MusicPlayerStatus, String>((ref, room) async {
  return await IotApiService().getMusicPlayerStatus(room);
});
