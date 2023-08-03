import 'package:eezee/multimedia/multimedia.dart';
import 'package:eezee/tabs/temperature/temperature.tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'dashboard/presentation/pages/dashboard.dart';
import 'iot/api/iot.ws.service.dart';
import 'tabs/wifi/wifi.tab.dart';



void main() {
  runApp(
    const ProviderScope(
      child: MyApp()
    )
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ws = ref.watch(websocketProvider); // init it here for the whole app

    return Sizer(
        builder: (context, orientation, deviceType)
    {
      return MaterialApp(
        title: 'EEZEE',
        initialRoute: '/dashboard',
        routes: {
          '/dashboard': (context) => const Dashboard(),
          '/media': (context) => const Multimedia(),
          '/temperature': (context) => const TemperatureTab(),
          '/wifi': (context) => const WifiTab(),
        },
      );
    }
    );
  }
}

class NavRailExample extends StatefulWidget {
  final Widget child;

  const NavRailExample({required this.child, super.key});

  @override
  State<NavRailExample> createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.none;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            groupAlignment: groupAlignment,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: labelType,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.cloud_outlined),
                selectedIcon: Icon(Icons.cloud),
                label: Text('Temperature'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.audiotrack_outlined),
                selectedIcon: Icon(Icons.audiotrack),
                label: Text('Audio'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          const Expanded(
            child: Dashboard(),
          ),

        ],
      ),
    );
  }
}