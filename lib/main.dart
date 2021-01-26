import 'package:LPI_water_annimation/allScreen/changeVar.dart';
import 'package:LPI_water_annimation/allScreen/sliderPage.dart';
import 'package:LPI_water_annimation/allScreen/tankManual.dart';
//import 'package:LPI_water_annimation/allScreen/tankManual.dart';
import 'package:flutter/material.dart';
import 'package:LPI_water_annimation/allScreen/loginScreen.dart';
import 'package:LPI_water_annimation/allScreen/registrationScreen.dart';

import 'package:LPI_water_annimation/widgets/mqttView.dart';
import 'package:LPI_water_annimation/mqtt/state/MQTTAppState.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryTextTheme:
                TextTheme(headline6: TextStyle(color: Colors.white))),
        home: ChangeNotifierProvider<MQTTAppState>(
          create: (_) => MQTTAppState(),
          child: MQTTView(),
        )
        /*initialRoute: SliderPage.idScreen,
      routes: {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        SliderPage.idScreen: (context) => SliderPage(),
        TankManual.idScreen: (context) => TankManual(),
        ChangeVar.idScreen: (context) => ChangeVar(),
      },*/
        );
  }
}
