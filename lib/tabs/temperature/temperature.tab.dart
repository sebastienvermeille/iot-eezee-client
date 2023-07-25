import 'package:eezee/dashboard/config/config.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../main_layout.dart';
import '../../uikit/widgets/cards/temperature/ui-smart-temperature.dart';

class TemperatureTab extends StatefulWidget {
  const TemperatureTab({Key? key}) : super(key: key);

  @override
  _TemperatureTabState createState() => _TemperatureTabState();
}

class _TemperatureTabState extends State<TemperatureTab> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final thermometers = DashboardConfig.temperatures;
    return MainLayout(
        title: 'Temperatures',
        child:
        Column(
            children: [
              Expanded(
                child:
                  LayoutBuilder(builder: (context, constraints) {
                    return GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: constraints.maxWidth > 700 ? 3 : 1,
                          childAspectRatio: 5,
                        ),
                        shrinkWrap: false,
                        children: [
                          for( var location in thermometers) UiSmartTemperatureWidget(room: location),
                        ]
                    );
                    }
                  )
              ),
            ]
        )
    );
  }
}
