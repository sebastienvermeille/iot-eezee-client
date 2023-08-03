import 'package:eezee/main_layout.dart';
import 'package:eezee/uikit/widgets/cards/door/ui-smart-door.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../uikit/widgets/cards/media/ui-smart-music-player.dart';
import '../../../uikit/widgets/cards/temperature/ui-smart-temperature.dart';
import '../../../uikit/widgets/cards/weather/ui-smart-weather-card.dart';


class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      title: 'Dashboard',
      child:
      Column(
          children: [
            Expanded(
                child:
                LayoutBuilder(builder: (context, constraints) {
                  return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 700 ? 2 : 1,
                        childAspectRatio: 5,
                      ),
                      shrinkWrap: false,
                      children: [
                        UiSmartTemperatureWidget(room: "rika"),
                        UiSmartTemperatureWidget(room: "outdoor"),
                            // UiSmartMusicPlayerWidget(room: "living"),
                        // UiSmartDoorWidget(location: "main"),
                      ]
                  );
                }
                )
            ),
          ]
      )



                  // UISmartWeatherCardWidget(zipCode: 3953, outsideThermometer: "outdoor"),

                  // Row(
                  //   children: [
                  //     UiSmartMusicPlayerWidget(room: "living"),
                  //   ],
                  // ),
                  //
                  // // UiSmartTemperatureWidget(room: "rika"),
                  //
                  //
                  //
                  //  UiSmartDoorWidget(location: "main"),


              // SizedBox(
              //   height: 280,
              //   width: double.infinity,
              //   child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Flexible(
              //           child: FractionallySizedBox(
              //               heightFactor: 1,
              //               widthFactor: 0.9,
              //               child: UiSmartDoorWidget(location: "main"),
              //           ),
              //         ),
              //         Flexible(
              //           child: FractionallySizedBox(
              //             heightFactor: 1,
              //             widthFactor: 0.9,
              //             child: UiSmartMusicPlayerWidget(room: "living"),
              //           ),
              //         ),
              //       ]
              //   ),
              // ),
    );
  }
}
