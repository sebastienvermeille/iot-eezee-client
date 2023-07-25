import 'package:eezee/iot/api/data/model/meteo/meteo.today.dart';
import 'package:eezee/iot/api/data/model/temperature.sensor.dart';
import 'package:eezee/iot/api/data/provider/meteo/meteo.today.provider.dart';
import 'package:eezee/iot/api/data/provider/temperature.provider.dart';
import 'package:eezee/uikit/widgets/cards/temperature/ui-temperature.dart';
import 'package:eezee/uikit/widgets/cards/weather/ui-weather-card.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class UISmartWeatherCardWidget extends ConsumerWidget {

  final int zipCode;
  final String outsideThermometer;
  final double celsiusValue = 12;

  const UISmartWeatherCardWidget({Key? key, required this.zipCode, required this.outsideThermometer })
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<TemperatureSensor> actualTemperatureState = ref.watch(temperatureSensorProvider(outsideThermometer));
    AsyncValue<MeteoToday> todayForecastState = ref.watch(meteoTodayProvider(zipCode));

    return todayForecastState.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => UiTemperatureWidget(label: outsideThermometer),
      // error: (err, stack) => Text('Error: $err'),
      data: (state) {
        return UIWeatherCardWidget(
            label: zipCode.toString(),
            actualTemperature: actualTemperatureState.value?.temperature,
            minExpectedTemperature: todayForecastState.value?.today.temperature.min.toDouble(),
            maxExpectedTemperature: todayForecastState.value?.today.temperature.max.toDouble(),
            expectedRain: todayForecastState.value?.today.rain.mean,
        );
      }
    );
  }
}