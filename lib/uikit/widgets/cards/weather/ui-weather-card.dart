import 'package:eezee/font/weather_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class UIWeatherCardWidget extends StatelessWidget {

  final String label;
  final double? actualTemperature;
  final double? minExpectedTemperature;
  final double? maxExpectedTemperature;
  final double? expectedRain;

  const UIWeatherCardWidget({Key? key, required this.label, this.actualTemperature, this.minExpectedTemperature, this.maxExpectedTemperature, this.expectedRain}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,

      child: Column(
        children: [
          Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        width: 120,
                        // height: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.height,
                        child: WeatherScene.sunset.getWeather()
                    ),
                    Center(
                      child: Row(
                          children: [

                            Text('$actualTemperature °C', style: TextStyle(fontSize: 32)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('max $maxExpectedTemperature °C'),
                                Text('min $minExpectedTemperature °C'),
                              ],

                            )    ,
                          ]


                      ),
                    ),

                    Row(
                      children: [
                        Icon(WeatherIcons.w1703, size: 10),
                        Text(' $expectedRain mm'),
                      ],

                    ),
                  ],
                )
              )
          )
        ],
      ),

      // child: Container(
      //   // decoration: BoxDecoration(
      //   //     LinearGradient(colors: [
      //   //       Colors.blueAccent, Colors.cyanAccent
      //   //     ])
      //   // ),
      //   child: ListTile(
      //     leading: const Icon(Icons.cloud),
      //     title:  Text('$actualTemperature °C', style: TextStyle(fontSize: 32), textAlign: TextAlign.center),
      //     subtitle:
      //
      //       Row(
      //         children: [
      //           Icon(WeatherIcons.w1703, size: 10),
      //           Text(' $expectedRain mm'),
      //         ],
      //
      //       ),
      //     trailing:
      //         Column(
      //           children: [
      //             Text('max $maxExpectedTemperature °C'),
      //             Text('min $minExpectedTemperature °C'),
      //
      //           ],
      //
      //         )
      //
      //   ),
    );
  }
}