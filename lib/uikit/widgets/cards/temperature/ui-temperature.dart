import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class UiTemperatureWidget extends StatelessWidget {

  final String label;
  final double? celsiusValue;
  final double? tooWarmStartAt;
  final double? tooColdStartAt;

  const UiTemperatureWidget({Key? key, required this.label, this.celsiusValue, this.tooWarmStartAt, this.tooColdStartAt}) : super(key: key);

  isTooCold(){
    if(tooColdStartAt == null){
        return false;
    }

    if(celsiusValue! <= tooColdStartAt!){
      return true;
    } else {
      return false;
    }
  }

  isTooHot(){
    if(tooWarmStartAt == null){
      return false;
    }

    if(celsiusValue! >= tooWarmStartAt!){
      return true;
    } else {
      return false;
    }
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
          gradient: isTooCold()
            ? const LinearGradient(colors: [
              Colors.blueAccent, Colors.cyanAccent
            ])
            : isTooHot()
            ? const LinearGradient(colors: [
              Colors.redAccent, Colors.yellow
            ])
            : const LinearGradient(colors: [
            Colors.white, Colors.white10
          ])
          ,
            // LinearGradient(colors: [
            //   Colors.greenAccent, Colors.cyanAccent
            // ]),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child:
                const Icon(Icons.thermostat_outlined),
            ),
            Expanded(
              child:
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            label,
                            style: const TextStyle(fontSize: 20),
                            maxLines: 1,
                          ),
                              isTooCold() ? const AutoSizeText('Too cold') : isTooHot() ? const AutoSizeText('Too warm') : celsiusValue == null ? const AutoSizeText('Not available') : const AutoSizeText('Comfortable'),
                        ]
                    ),
                  )


            ),
            Container(
              padding: const EdgeInsets.all(10),
              child:
                celsiusValue == null
                    ? const Text('-')
                    : AutoSizeText(
                        '$celsiusValue °C',
                        style: const TextStyle(fontSize: 50),
                        maxLines: 1,
                      ),

            )
          ],
        ),
      ),
    );
  }
}