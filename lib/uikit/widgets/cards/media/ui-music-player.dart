import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:eezee/iot/api/data/provider/music.player.status.provider.dart';
import 'package:eezee/iot/api/data/provider/music.track.provider.dart';
import 'package:eezee/multimedia/music.playlists.dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';

import '../../../../iot/api/iot.service.dart';

class UiMusicPlayerWidget extends ConsumerStatefulWidget {

  final String label;
  final int volume;
  String? cover;
  String? trackName;
  bool? isPlaying;
  WidgetRef? states;

  UiMusicPlayerWidget({Key? key, required this.label, required this.volume, this.cover, this.trackName, this.isPlaying, this.states}) : super(key: key);

  @override
  ConsumerState<UiMusicPlayerWidget> createState() => _UiMusicPlayerWidgetState();

  String? getCover(){
    return cover;
  }

  getTrackName(){
    return trackName ?? "-";
  }

  Image? coverImage;

  Image getCoverImage()  {
    coverImage = const Image(image: AssetImage('assets/images/uikit/media/unknown_song.jpg'), height: 128, width: 128);

    if(getCover() != null){
      var res = IotApiService().getBinary(getCover() ?? "");
      res.then((value) {
        print('Get image content');
        coverImage = Image(image: NetworkImage(value as String), height: 128, width: 128);
        return coverImage!;

      }, onError: (ex){
        coverImage = const Image(image: AssetImage('assets/images/uikit/media/unknown_song.jpg'), height: 128, width: 128);
        print('no data');
        return coverImage!;

      }
      );
    } else {
      coverImage = const Image(image: AssetImage('assets/images/uikit/media/unknown_song.jpg'), height: 128, width: 128);
      return coverImage!;

    }

    return coverImage!;

  }

}

class _UiMusicPlayerWidgetState extends ConsumerState<UiMusicPlayerWidget> {


  late double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
   // _currentSliderValue = ref.read(musicVolumeProvider(widget.label)).value!.volume.toDouble(); // todo: check it

  }

  @override
  Widget build(BuildContext context) {


    const double iconSize=50;

    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
        decoration: const BoxDecoration(
          gradient:LinearGradient(colors: [
            Colors.blueAccent, Colors.cyanAccent
          ])
          ,
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(widget.label, maxLines: 1, style: const TextStyle(fontSize: 20)),
                const Expanded(child:
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                    FittedBox(
                      child:
                        DropShadow(
                          child:
                            Image(image: AssetImage('assets/images/uikit/media/unknown_song.jpg'), height: 128, width: 128)
                            // widget.getCoverImage(),
                            // CachedNetworkImage(
                            //   imageUrl: widget.cover as String,
                            //   imageBuilder: (context, imageProvider) =>
                            //       Container(
                            //         decoration: BoxDecoration(
                            //           image: DecorationImage(
                            //             image: imageProvider,
                            //             fit: BoxFit.fitWidth,
                            //           ),
                            //         ),
                            //       ),
                            //   placeholder: (context,  url) =>
                            //     CircularProgressIndicator(),
                            //   errorWidget: (context, url, error) =>
                            //   Icon(Icons.error),
                            // )
                        ),
                    ),
                  ),
                ),

                // Text(widget.getTrackName()),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // TextButton.icon(     // <-- TextButton
                    //   onPressed: () {},
                    //   icon: Icon(
                    //     Icons.skip_previous,
                    //     size: 24.0,
                    //   ),
                    //   label: Text(""),
                    // ),
                    widget.isPlaying == true
                    ? TextButton.icon(
                      onPressed: () {
                        IotApiService().pauseMusic(widget.label);
                        widget.states?.invalidate(musicPlayerStatusProvider(widget.label));
                      },
                      icon: const Icon(
                        Icons.pause,
                        size: iconSize,
                      ),
                      label: const Text(""),
                    )
                    : TextButton.icon(
                        onPressed: () {
                          IotApiService().playMusic(widget.label);
                          widget.states?.invalidate(musicPlayerStatusProvider(widget.label));
                        },
                        icon: const Icon(
                          Icons.play_arrow,
                          size: iconSize,
                        ),
                        label: const Text(""),
                      )
                    ,
                    // TextButton.icon(     // <-- TextButton
                    //   onPressed: () {
                    //
                    //   },
                    //   icon: Icon(
                    //     Icons.skip_next,
                    //     size: 24.0,
                    //   ),
                    //   label: Text(""),
                    // ),
                    TextButton.icon(     // <-- TextButton
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return const MusicPlaylistsDialogWidget();
                        }).then((selectedRadioChannel){
                          if(selectedRadioChannel != null){
                            IotApiService().definePlaylist(widget.label, selectedRadioChannel).then((result) {

                                if(result == true){
                                  widget.states?.invalidate(musicTrackProvider(widget.label));

                                  // the status reported by the API change few seconds after (but this prevent to click pause)
                                  // // TODO: redesign this is purely ugly! -> no longer needed with WS (maybe just disable the button for a while?)
                                  // Future.delayed(Duration(seconds: 3), () {
                                  //   widget.states?.invalidate(musicPlayerStatusProvider(widget.label));
                                  // });


                                }
                            });

                          } else {
                            print("Closed the radio popup without choosing any channel.");
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.radio,
                        size: iconSize,
                      ),
                      label: const Text(""),
                    ),
                  ]
                ),
                Slider(
                  value: widget.volume.toDouble(),
                  max: 100,
                  divisions: 100,
                  label: widget.volume.round().toString(),
                  onChanged: (double value) {
                    IotApiService().setMusicVolume(widget.label, value.round());
                    ref.refresh(musicPlayerStatusProvider(widget.label));
                    // musicVolumeProvider(widget.label)
                    // setState(() {
                    //   _currentSliderValue = value;
                    //
                    }
                  ),
                // TextButton.icon(     // <-- TextButton
                //   onPressed: () {},
                //   icon: Icon(
                //     Icons.volume_mute,
                //     size: 24.0,
                //   ),
                //   label: Text("Mute"),
                // ),
              ]
        )
      ),
    );
  }

}