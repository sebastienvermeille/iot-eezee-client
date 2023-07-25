import 'package:eezee/iot/api/data/model/music.player.status.dart';
import 'package:eezee/uikit/widgets/cards/media/ui-music-player.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../iot/api/data/model/music.track.dart';
import '../../../../iot/api/data/model/music.volume.dart';
import '../../../../iot/api/data/provider/music.player.status.provider.dart';
import '../../../../iot/api/data/provider/music.track.provider.dart';
import '../../../../iot/api/data/provider/music.volume.provider.dart';
import '../../../../iot/api/iot.ws.service.dart';


class UiSmartMusicPlayerWidget extends ConsumerWidget {

  final String room;
  final double celsiusValue = 12;

  const UiSmartMusicPlayerWidget({Key? key, required this.room })
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MusicVolume> volumeState = ref.watch(musicVolumeProvider(room)); // this works
    AsyncValue<MusicTrack> trackState = ref.watch(musicTrackProvider(room)); // this works
    AsyncValue<MusicPlayerStatus> playerStatusState = ref.watch(musicPlayerStatusProvider(room)); // this works

    if (volumeState is AsyncError || trackState is AsyncError || playerStatusState is AsyncError) {
      return UiMusicPlayerWidget(label: room, volume: 0);
    } else if (volumeState is AsyncLoading || trackState is AsyncLoading || playerStatusState is AsyncLoading) {
      return const CircularProgressIndicator();
    }

    return UiMusicPlayerWidget(
        label: volumeState.value!.room,
        volume: volumeState.value!.volume,
        trackName: trackState.value!.track.title,
        cover: trackState.value!.track.cover,
        isPlaying: playerStatusState.value!.playing,
        states: ref,
    );
  }
}