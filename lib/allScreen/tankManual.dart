import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class TankManual extends StatefulWidget {
  static const String idScreen = "ManualTank";
  @override
  _TankManualState createState() => _TankManualState();
}

class _TankManualState extends State<TankManual> {
  double waterLevel = 0.0;
  double waterLevelPercentage = 0.0;

  int modeState = 0;
  String mode = 'Automatic';

  void increaseWaterLevel() {
    setState(() {
      waterLevel += 0.01;
      waterLevelPercentage =
          double.parse((waterLevel * 100).toStringAsFixed(2));
    });
  }

  void decreaseWaterLevel() {
    setState(() {
      waterLevel -= 0.01;
      waterLevelPercentage =
          double.parse((waterLevel * 100).toStringAsFixed(2));
    });
  }

  void modeStateFunction() {
    setState(() {
      if (modeState == 0) {
        mode = 'Manual';
        modeState = 1;
      } else {
        mode = 'Automatic';
        modeState = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "$mode",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: modeStateFunction),
              SizedBox(
                height: 50.0,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 350.00,
                  width: 350.0,
                  child: LiquidCircularProgressIndicator(
                    value: waterLevel,
                    valueColor: AlwaysStoppedAnimation(Colors.lightBlue),
                    //backgroundColor: Colors.white,
                    borderColor: Colors.black54,
                    borderWidth: 15,
                    direction: Axis.vertical,
                    center: Text("$waterLevelPercentage"),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Increase",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: increaseWaterLevel),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Decrease",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: decreaseWaterLevel),
            ],
          ),
        ),
      ),
    );
  }
}
