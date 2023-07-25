import 'package:eezee/iot/api/data/provider/music.player.status.provider.dart';
import 'package:eezee/iot/api/data/provider/music.track.provider.dart';
import 'package:eezee/iot/api/data/provider/music.volume.provider.dart';
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

  getCover(){
    return cover ?? "nothing";
  }

  getTrackName(){
    return trackName ?? "-";
  }

  Image? coverImage;
  getCoverImage() {
    if(getCover() != null){
      IotApiService().getBinary(getCover()).then((value) {
        coverImage = value;
      });
    }
    return coverImage;
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




    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient:LinearGradient(colors: [
            Colors.blueAccent, Colors.cyanAccent
          ])
          ,
        ),
          child: Column(
              children: [
                Text(widget.label),
                // widget.getCoverImage(),

                Image(
                  height: 128,
                  width: 128,
                  image: NetworkImage(widget.getCover()),
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
                      icon: Icon(
                        Icons.pause,
                        size: 24.0,
                      ),
                      label: Text(""),
                    )
                    : TextButton.icon(
                        onPressed: () {
                          IotApiService().playMusic(widget.label);
                          widget.states?.invalidate(musicPlayerStatusProvider(widget.label));
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          size: 24.0,
                        ),
                        label: Text(""),
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
                          return MusicPlaylistsDialogWidget();
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
                      icon: Icon(
                        Icons.radio,
                        size: 24.0,
                      ),
                      label: Text(""),
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