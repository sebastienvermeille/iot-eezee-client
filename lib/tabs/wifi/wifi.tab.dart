import 'package:flutter/material.dart';

import '../../main_layout.dart';

class WifiTab extends StatefulWidget {
  const WifiTab({Key? key}) : super(key: key);

  @override
  _WifiTabState createState() => _WifiTabState();
}

class _WifiTabState extends State<WifiTab> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Wifi network',
        child:
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      'http://7.7.7.107:8040/home-automation/wifi/wifi_guest.png',
                      width: 400,
                      height: 400),
                ]

              )

            ),

    );
  }
}
