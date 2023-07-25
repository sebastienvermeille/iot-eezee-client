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
            ? LinearGradient(colors: [
              Colors.blueAccent, Colors.cyanAccent
            ])
            : isTooHot()
            ? LinearGradient(colors: [
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
        child: ListTile(
          leading: const Icon(Icons.thermostat_outlined),
          title: Text(label),
          subtitle: isTooCold() ? const Text('Too cold') : isTooHot() ? const Text('Too warm') : celsiusValue == null ? const Text('Not available') : const Text('Comfortable'),
          trailing:
              celsiusValue == null
            ? Text('-')
            : Text('$celsiusValue °C')
        ),
      ),
    );
  }
}