import 'package:eezee/iot/api/data/model/music.playlists.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../iot.service.dart';

final musicPlaylistsProvider = FutureProvider.family<MusicPlaylists, String>((ref, room) async {
  return await IotApiService().getMusicPlaylists(room);
});
