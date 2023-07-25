import 'package:eezee/iot/api/data/model/music.playlists.dart';
import 'package:eezee/iot/api/data/provider/music.playlists.provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MusicPlaylistsDialogWidget extends ConsumerStatefulWidget {

  const MusicPlaylistsDialogWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MusicPlaylistsDialogWidgetState();
}

class _MusicPlaylistsDialogWidgetState extends ConsumerState<MusicPlaylistsDialogWidget> {

  @override
  void initState() {
    super.initState();

    final playlists = ref.read(musicPlaylistsProvider("office"));
    print(playlists); // Hello world
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(musicPlaylistsProvider("office"));


    AsyncValue<MusicPlaylists> playlistsState = ref.watch(musicPlaylistsProvider("office")); // this works
    return playlistsState.when(
        loading: () => const CircularProgressIndicator(),
    error: (err, stack) => Text("error"),
    // error: (err, stack) => Text('Error: $err'),
    data: (state) {
      return Dialog(
        child:
          Padding(
            padding: EdgeInsets.all(20),
            child:
              Column(
                  children: [
                    for( var channel in state.channels) Row(
                      children: [
                        Radio(
                          value: channel.label,
                          groupValue: "playlist_office",
                          onChanged: (value) {
                            Navigator.pop(context, value);
                          },
                        ),
                        Text(channel.label),
                      ],
                    ),
                  ]
              ),
          ),
      );
    }



      // Container(
      //   height: 300,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text("Playlists",style:TextStyle(fontSize: 20),),
      //       ElevatedButton(
      //
      //           onPressed: (){
      //             Navigator.of(context).pop();
      //           }, child: Text("Close"))
      //     ],
      //   ),
      // ),
    );
  }

}