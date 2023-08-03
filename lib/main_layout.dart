
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

final activeTabProvider = StateNotifierProvider<CurrentTab, int>((ref) {
  return CurrentTab(ref);
});



class CurrentTab extends StateNotifier<int> {

  final Ref ref;

  CurrentTab(this.ref): super(0);

  void setActiveTab(int value){
    this.state = value;
  }
}


class MainLayout extends ConsumerWidget {
  Widget child;
  String title;
  FloatingActionButton? floatingActionButton;

  MainLayout({required this.title, required this.child, this.floatingActionButton, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    int selectedIndex = ref.watch(activeTabProvider);
    NavigationRailLabelType labelType = NavigationRailLabelType.none;
    double groupAlignment = -1.0;

    const double iconSize = 50;



    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            minWidth: 10.w,
          selectedIndex: selectedIndex,
          groupAlignment: groupAlignment,
          onDestinationSelected: (int index) {
            switch(index){
              case 0:
                Navigator.pushReplacementNamed(context, '/dashboard');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/media');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/temperature');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/wifi');
                break;
            }

            ref.read(activeTabProvider.notifier).setActiveTab(index);
            // setState(() {
            //   _selectedIndex = index;
            // });
          },
          labelType: labelType,
          destinations: const <NavigationRailDestination>[
            NavigationRailDestination(
              icon: Icon(Icons.dashboard_outlined, size: iconSize),
              selectedIcon: Icon(Icons.dashboard, size: iconSize),
              label: Text('Dashboard'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.audiotrack_outlined, size: iconSize),
              selectedIcon: Icon(Icons.audiotrack, size: iconSize),
              label: Text('Audio'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.thermostat_outlined, size: iconSize),
              selectedIcon: Icon(Icons.thermostat, size: iconSize),
              label: Text('Temperature'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.wifi_outlined, size: iconSize),
              selectedIcon: Icon(Icons.wifi, size: iconSize),
              label: Text('Wifi'),
            ),
          ],
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // This is the main content.
        Expanded(
          child:
            Scaffold(
              appBar: AppBar(
                title:Text(title),
                backgroundColor: Colors.black,
              ),
              body: child
            )
        ),
      ],
    ),
    );

  }
}