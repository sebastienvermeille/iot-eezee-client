import 'package:eezee/iot/api/data/model/meteo/meteo.today.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../iot.service.dart';

final meteoTodayProvider = FutureProvider.family<MeteoToday, int>((ref, zipCode) async {
  return await IotApiService().getMeteoToday(zipCode);
});
