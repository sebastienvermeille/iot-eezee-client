import 'package:eezee/dashboard/config/config.dart';
import 'package:eezee/uikit/widgets/cards/media/ui-smart-music-player.dart';
import 'package:flutter/material.dart';

import '../main_layout.dart';


class Multimedia extends StatefulWidget {
  const Multimedia({Key? key}) : super(key: key);

  @override
  _MultimediaState createState() => _MultimediaState();
}

class _MultimediaState extends State<Multimedia> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final musicRooms = DashboardConfig.musicRooms;
    return MainLayout(
        title: 'Multimedia',
        child:
          Column(
            children: [
              Expanded(
              child:
                LayoutBuilder(builder: (context, constraints) {
                  return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 700 ? 2 : 1,
                        childAspectRatio: 2,
                      ),
                    shrinkWrap: false,
                    children: [
                      for( var location in musicRooms) UiSmartMusicPlayerWidget(room: location),
                    ]
                  );
                }
              ),
            ),
          ]
        )
   );
  }
}
