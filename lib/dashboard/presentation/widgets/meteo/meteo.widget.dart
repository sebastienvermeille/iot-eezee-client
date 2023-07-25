import 'package:eezee/uikit/widgets/cards/weather/ui-smart-weather-card.dart';
import 'package:flutter/material.dart';

import '../../../../uikit/widgets/cards/temperature/ui-smart-temperature.dart';

class MeteoWidget extends StatelessWidget {


  const MeteoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      child: Container(
                  height: 100,
                  color: Colors.orange,
                  child:
                  UISmartWeatherCardWidget(zipCode: 3953, outsideThermometer: "outdoor"),
      )
              // FractionallySizedBox(
              //   widthFactor: 0.5,// Take whole horizontal space
              //   alignment: Alignment.topRight,
              //   child: Container(
              //     height: 100,
              //     color: Colors.orange,
              //     child:
              //     UiSmartTemperatureWidget(room: "rika"),
              //   ),
              // ),
        //   LayoutBuilder(builder: (context, constraints) {
        //     return GridView(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           childAspectRatio: 1,
        //         ),
        //         shrinkWrap: true,
        //         children: const [
        //           UISmartWeatherCardWidget(zipCode: 3953, outsideThermometer: "outdoor"),
        //           UiSmartTemperatureWidget(room: "rika"),
        //         ]
        //     );
        //   }
        // ),
    );
  }
}